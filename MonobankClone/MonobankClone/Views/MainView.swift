import SwiftUI

struct MainView: View {
    @Binding var cards: [Card]
    @Binding var transactions: [Transaction]
    @State private var currentCardIndex = 0
    @State private var showTransactionList = false
    @State private var showCardDetail = false
    
    var currentCard: Card {
        cards.isEmpty ? Card.sampleCards[0] : cards[currentCardIndex]
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                    // Top bar
                    HStack {
                        // Profile icon
                        ZStack {
                            Circle()
                                .fill(Color.black.opacity(0.3))
                                .frame(width: 44, height: 44)
                            
                            Text("БЗ")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                        }
                        .overlay(
                            Circle()
                                .fill(Color.red)
                                .frame(width: 12, height: 12)
                                .overlay(
                                    Text("1")
                                        .font(.system(size: 8, weight: .bold))
                                        .foregroundColor(.white)
                                )
                                .offset(x: 15, y: -15),
                            alignment: .topTrailing
                        )
                        
                        Spacer()
                        
                        // Cashback
                        HStack(spacing: 4) {
                            Image(systemName: "gift.fill")
                                .font(.system(size: 14))
                            Text("19.68 ₴")
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.black.opacity(0.25))
                        )
                        
                        Spacer()
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.2))
                                .frame(width: 44, height: 44)
                            
                            Text("🐱")
                                .font(.system(size: 20))
                        }
                        
                        // Menu icon
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.2))
                                .frame(width: 44, height: 44)
                            
                            Image(systemName: "chart.bar.fill")
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 5)
                    .padding(.bottom, 20)
                    
                    // Balance
                    HStack(spacing: 8) {
                        Button(action: {}) {
                            Image(systemName: "eye.slash.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.white.opacity(0.6))
                        }
                        
                        Text("\(String(format: "%.2f", currentCard.balance)) ₴")
                            .font(.system(size: 48, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding(.bottom, 40)
                    
                    // Card
                    TabView(selection: $currentCardIndex) {
                        ForEach(cards.indices, id: \.self) { index in
                            CardView(card: cards[index])
                                .tag(index)
                                .onTapGesture {
                                    showCardDetail = true
                                }
                        }
                    }
                    .frame(height: 220)
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    
                    // All cards button - уже как в оригинале
                    Button(action: {}) {
                        HStack(spacing: 6) {
                            Image(systemName: "creditcard.fill")
                                .font(.system(size: 12))
                            Text("Усі картки")
                                .font(.system(size: 13, weight: .medium))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.white.opacity(0.25))
                        .cornerRadius(16)
                    }
                    .padding(.top, 15)
                    .padding(.bottom, 20)
                    
                    // Action buttons
                    HStack(spacing: 20) {
                        ActionButton(
                            icon: "arrow.right",
                            title: "Переказати\nна картку"
                        )
                        
                        ActionButton(
                            icon: "doc.text.fill",
                            title: "Платіж\nза IBAN"
                        )
                        
                        ActionButton(
                            icon: "square.stack.3d.up.fill",
                            title: "Інші\nплатежі"
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 15)
                    
                    // Transactions section - поднимаем выше
                    VStack(spacing: 0) {
                        HStack {
                            Text("Операції")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Button(action: { showTransactionList = true }) {
                                HStack(spacing: 4) {
                                    Text("Усі")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(.blue)
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        .padding(.bottom, 16)
                        
                        // Transaction list
                        VStack(spacing: 8) {
                            ForEach(transactions.prefix(3)) { transaction in
                                TransactionRow(transaction: transaction)
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        Spacer(minLength: 100)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                    )
                }
        }
        .ignoresSafeArea(edges: .bottom)
        .sheet(isPresented: $showTransactionList) {
            TransactionListView(transactions: $transactions, card: currentCard)
        }
        .sheet(isPresented: $showCardDetail) {
            CardDetailView(card: currentCard)
        }
    }
}

struct ActionButton: View {
    let icon: String
    let title: String
    
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color(red: 0.15, green: 0.15, blue: 0.2))
                    .frame(width: 60, height: 60)
                
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(.white)
            }
            
            Text(title)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(height: 32)
        }
        .frame(maxWidth: .infinity)
    }
}

struct TransactionRow: View {
    let transaction: Transaction
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon - красивая как в оригинале
            ZStack {
                Circle()
                    .fill(transaction.iconColor.opacity(0.15))
                    .frame(width: 48, height: 48)
                
                Image(systemName: transaction.iconName)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(transaction.iconColor)
            }
            
            // Content
            VStack(alignment: .leading, spacing: 2) {
                Text(transaction.title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                    .lineLimit(1)
                
                Text(transaction.date.formatted(.dateTime.day().month().hour().minute()))
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Amount - красивое как в оригинале
            VStack(alignment: .trailing, spacing: 2) {
                Text(transaction.formattedAmount)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(transaction.amount >= 0 ? Color(red: 0.2, green: 0.7, blue: 0.3) : .black)
                
                Text(transaction.currency)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 12)
    }
}

#Preview {
    MainView(cards: .constant(Card.sampleCards), transactions: .constant(Transaction.sampleTransactions))
}
