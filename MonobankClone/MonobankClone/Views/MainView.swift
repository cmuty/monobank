import SwiftUI

struct MainView: View {
    @Binding var cards: [Card]
    @State private var currentCardIndex = 0
    @State private var showTransactionList = false
    @State private var showCardDetail = false
    
    var currentCard: Card {
        cards.isEmpty ? Card.sampleCards[0] : cards[currentCardIndex]
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Fixed Top bar
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
                        
                        // Cashback и котик рядом
                        HStack(spacing: 12) {
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
                            
                            Text("🐱")
                                .font(.system(size: 20))
                            
                            Image(systemName: "chart.bar.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 5)
                    .padding(.bottom, 20)
            
            // Scrollable content
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // Отступ сверху чтобы опустить весь интерфейс
                    Spacer()
                        .frame(height: 40)
                    
                    // Дополнительный отступ для баланса
                    Spacer()
                        .frame(height: 20)
                    
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
                    .padding(.bottom, 50)
                    
                    // Card with background card
                    TabView(selection: $currentCardIndex) {
                        ForEach(cards.indices, id: \.self) { index in
                            ZStack {
                                // Background card - под каждой картой отдельно
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color(red: 0.92, green: 0.89, blue: 0.85),  // Светлый бежевый как на скриншоте
                                            Color(red: 0.88, green: 0.85, blue: 0.81)   // Чуть темнее
                                        ]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ))
                                    .frame(width: 290, height: 170)
                                    .shadow(color: Color(red: 0.08, green: 0.14, blue: 0.37).opacity(0.4), radius: 15, x: 0, y: 8)
                                    .offset(y: 20)  // Смещаем вниз чтобы была видна только снизу
                                    .rotation3DEffect(
                                        .degrees(25),
                                        axis: (x: 1, y: 0, z: 0),
                                        perspective: 0.4
                                    )
                                
                                // Main card с 3D эффектом
                                CardView(card: cards[index])
                                    .shadow(color: Color(red: 0.08, green: 0.14, blue: 0.37).opacity(0.4), radius: 20, x: 0, y: 10)
                            }
                            .tag(index)
                            .onTapGesture {
                                showCardDetail = true
                            }
                        }
                    }
                    .frame(height: 220)
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    
                    // Card indicators - индикаторы карт
                    HStack(spacing: 8) {
                        ForEach(cards.indices, id: \.self) { index in
                            Circle()
                                .fill(currentCardIndex == index ? Color.white : Color.white.opacity(0.3))
                                .frame(width: 8, height: 8)
                        }
                    }
                    .padding(.top, 12)
                    
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
                        .background(Color.black.opacity(0.4))
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
                    .padding(.bottom, 40)
                    
                    // Transactions section - опускаем ниже
                    VStack(spacing: 0) {
                        HStack {
                            Text("Операції")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Button(action: { showTransactionList = true }) {
                                HStack(spacing: 3) {
                                    Text("Усі")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.black)
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 10, weight: .semibold))
                                        .foregroundColor(.black)
                                }
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.black.opacity(0.1))
                                )
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        .padding(.bottom, 16)
                        
                        // Transaction list - показываем транзакции текущей карты
                        VStack(spacing: 8) {
                            ForEach(currentCard.transactions.prefix(3)) { transaction in
                                TransactionRow(transaction: transaction)
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        Spacer(minLength: 120)  // Больше места для фиксированного footer
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)  // Белый цвет для карточки операций
                    )
                    .padding(.horizontal, 16)  // Отступы от краев экрана
                }
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .sheet(isPresented: $showTransactionList) {
            TransactionListView(transactions: .constant(currentCard.transactions), card: currentCard)
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
        VStack(spacing: 8) {
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
                .foregroundColor(.black)
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
                    .foregroundColor(.black.opacity(0.7))
            }
            
            Spacer()
            
            // Amount - красивое как в оригинале
            VStack(alignment: .trailing, spacing: 2) {
                Text(transaction.formattedAmount)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(transaction.amount >= 0 ? Color(red: 0.2, green: 0.7, blue: 0.3) : .black)
                
                Text(transaction.currency)
                    .font(.system(size: 12))
                    .foregroundColor(.black.opacity(0.7))
            }
        }
        .padding(.vertical, 12)
    }
}

#Preview {
    MainView(cards: .constant(Card.sampleCards))
}
