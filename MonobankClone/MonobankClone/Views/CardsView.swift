import SwiftUI

struct CardsView: View {
    @Binding var cards: [Card]
    @Binding var transactions: [Transaction]
    @State private var currentCardIndex = 0
    @State private var showTransactionList = false
    @State private var showCardDetail = false
    @State private var showBalance = true
    @State private var scrollPosition: Int = 0
    
    var currentCard: Card {
        cards.isEmpty ? Card.sampleCards[0] : cards[currentCardIndex]
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background gradient
                DesignSystem.backgroundGradient
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        // Header Section
                        HeaderView()
                            .padding(.horizontal, DesignSystem.Spacing.lg)
                            .padding(.top, DesignSystem.Spacing.sm)
                            .padding(.bottom, DesignSystem.Spacing.xl)
                        
                        // Balance Section
                        BalanceView(
                            balance: currentCard.balance,
                            currency: currentCard.currency,
                            showBalance: $showBalance
                        )
                        .padding(.bottom, 40)
                        
                        // Card Carousel
                        CardCarouselView(
                            cards: cards,
                            currentIndex: $currentCardIndex,
                            screenWidth: geometry.size.width
                        )
                        .frame(height: DesignSystem.Sizes.cardHeight)
                        
                        // All Cards Button
                        AllCardsButton()
                            .padding(.top, 15)
                            .padding(.bottom, DesignSystem.Spacing.xl)
                        
                        // Quick Actions
                        QuickActionsView()
                            .padding(.horizontal, DesignSystem.Spacing.xl)
                            .padding(.bottom, 15)
                        
                        // Bottom Sheet with Transactions
                        TransactionsBottomSheet(transactions: transactions)
                            .padding(.horizontal, DesignSystem.Spacing.lg)
                    }
                }
                .ignoresSafeArea(edges: .bottom)
            }
        }
        .sheet(isPresented: $showTransactionList) {
            TransactionListView(transactions: $transactions, card: currentCard)
        }
        .sheet(isPresented: $showCardDetail) {
            CardDetailView(card: currentCard)
        }
    }
}

// MARK: - Header View
struct HeaderView: View {
    var body: some View {
        VStack(spacing: DesignSystem.Spacing.sm) {
            // Top row - Time and location
            HStack {
                HStack(spacing: 4) {
                    Text("09:41")
                        .font(DesignSystem.Typography.bodySmall)
                        .foregroundColor(DesignSystem.Colors.textPrimary)
                    
                    Image(systemName: "location.fill")
                        .font(.system(size: 12))
                        .foregroundColor(DesignSystem.Colors.textSecondary)
                }
                
                Spacer()
                
                // Right side icons
                HStack(spacing: DesignSystem.Spacing.md) {
                    // Cashback
                    HStack(spacing: 4) {
                        Text("🎁")
                            .font(.system(size: 14))
                        Text("19.68 ₴")
                            .font(DesignSystem.Typography.buttonSmall)
                            .foregroundColor(DesignSystem.Colors.textPrimary)
                    }
                    
                    // Cat icon
                    Text("🐱")
                        .font(.system(size: 20))
                    
                    // Menu button
                    Image(systemName: "line.3.horizontal")
                        .font(.system(size: 18))
                        .foregroundColor(DesignSystem.Colors.textPrimary)
                }
            }
            
            // Bottom row - Avatar with notification badge
            HStack {
                // Avatar with notification badge
                ZStack {
                    Circle()
                        .fill(Color.purple.opacity(0.8))
                        .frame(width: DesignSystem.Sizes.avatarSmall, height: DesignSystem.Sizes.avatarSmall)
                    
                    Text("БЗ")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(DesignSystem.Colors.textPrimary)
                }
                .overlay(
                    // Notification badge
                    Circle()
                        .fill(Color.red)
                        .frame(width: DesignSystem.Sizes.badge, height: DesignSystem.Sizes.badge)
                        .overlay(
                            Text("1")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(.white)
                        )
                        .offset(x: 12, y: -12),
                    alignment: .topTrailing
                )
                
                Spacer()
            }
        }
    }
}

// MARK: - Balance View
struct BalanceView: View {
    let balance: Double
    let currency: String
    @Binding var showBalance: Bool
    
    var body: some View {
        HStack(spacing: DesignSystem.Spacing.sm) {
            // Add button
            Button(action: {
                HapticManager.shared.light()
            }) {
                Circle()
                    .fill(DesignSystem.Colors.chipBg)
                    .frame(width: DesignSystem.Sizes.addButton, height: DesignSystem.Sizes.addButton)
                    .overlay(
                        Image(systemName: "plus")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(DesignSystem.Colors.textPrimary)
                    )
            }
            
            // Balance display
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                if showBalance {
                    // Format balance to remove unnecessary decimals for whole numbers
                    let formattedBalance = balance.truncatingRemainder(dividingBy: 1) == 0 ? 
                        String(format: "%.0f", balance) : String(format: "%.2f", balance)
                    
                    Text(formattedBalance)
                        .font(DesignSystem.Typography.balanceNumber)
                        .foregroundColor(DesignSystem.Colors.textPrimary)
                    
                    Text(currency)
                        .font(DesignSystem.Typography.balanceCurrency)
                        .foregroundColor(DesignSystem.Colors.textPrimary)
                        .baselineOffset(-6)
                } else {
                    Text("••••••")
                        .font(DesignSystem.Typography.balanceNumber)
                        .foregroundColor(DesignSystem.Colors.textPrimary)
                }
            }
            
            // Eye button
            Button(action: {
                withAnimation(.easeInOut(duration: 0.25)) {
                    showBalance.toggle()
                }
                HapticManager.shared.light()
            }) {
                Image(systemName: showBalance ? "eye.slash.fill" : "eye.fill")
                    .font(.system(size: 20))
                    .foregroundColor(DesignSystem.Colors.textSecondary)
            }
            
            Spacer()
        }
        .padding(.horizontal, DesignSystem.Spacing.lg)
    }
}

// MARK: - Card Carousel View
struct CardCarouselView: View {
    let cards: [Card]
    @Binding var currentIndex: Int
    let screenWidth: CGFloat
    
    private var cardWidth: CGFloat {
        screenWidth - (DesignSystem.CardCarousel.leftPeek + DesignSystem.CardCarousel.rightPeek)
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: DesignSystem.CardCarousel.spacing) {
                ForEach(cards.indices, id: \.self) { index in
                    MonobankCardView(card: cards[index])
                        .frame(width: cardWidth)
                        .scaleEffect(currentIndex == index ? DesignSystem.CardCarousel.activeScale : DesignSystem.CardCarousel.inactiveScale)
                        .scrollTransition { content, phase in
                            content
                                .scaleEffect(phase.isIdentity ? 1.0 : 0.96)
                                .opacity(phase.isIdentity ? 1.0 : 0.8)
                        }
                        .onTapGesture {
                            HapticManager.shared.light()
                        }
                }
            }
            .padding(.leading, DesignSystem.CardCarousel.leftPeek)
            .padding(.trailing, DesignSystem.CardCarousel.rightPeek)
        }
        .scrollTargetLayout()
        .scrollTargetBehavior(.paging)
    }
}

// MARK: - Monobank Card View
struct MonobankCardView: View {
    let card: Card
    
    var body: some View {
        ZStack {
            // Card background with gradient
            RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.card)
                .fill(DesignSystem.cardGradient)
                .applyShadow(DesignSystem.Shadow.card)
            
            VStack(alignment: .leading) {
                Spacer()
                
                // Card number
                HStack {
                    Text(card.maskedNumber)
                        .font(DesignSystem.Typography.cardNumber)
                        .foregroundColor(DesignSystem.Colors.textPrimary)
                    
                    Spacer()
                }
                .padding(.bottom, DesignSystem.Spacing.sm)
                
                // Bottom row with Visa logo
                HStack {
                    Spacer()
                    
                    Text("VISA")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(DesignSystem.Colors.textPrimary)
                        .italic()
                }
            }
            .padding(DesignSystem.Spacing.xl)
        }
        .frame(height: DesignSystem.Sizes.cardHeight)
    }
}

// MARK: - All Cards Button
struct AllCardsButton: View {
    var body: some View {
        Button(action: {
            HapticManager.shared.light()
        }) {
            HStack(spacing: 6) {
                Image(systemName: "wallet.pass.fill")
                    .font(.system(size: 12))
                Text("Усі картки")
                    .font(.system(size: 14, weight: .medium))
            }
            .foregroundColor(DesignSystem.Colors.textPrimary)
            .padding(.horizontal, DesignSystem.Spacing.md)
            .padding(.vertical, DesignSystem.Spacing.sm)
            .background(
                Capsule()
                    .fill(DesignSystem.Colors.chipBg)
            )
        }
    }
}

// MARK: - Quick Actions View
struct QuickActionsView: View {
    let actions = [
        ("arrow.right", "Переказати\nна картку"),
        ("doc.text.fill", "Платіж\nза IBAN"),
        ("square.stack.3d.up.fill", "Інші\nплатежі")
    ]
    
    var body: some View {
        HStack(spacing: DesignSystem.Spacing.xl) {
            ForEach(actions.indices, id: \.self) { index in
                QuickActionButton(
                    icon: actions[index].0,
                    title: actions[index].1
                )
            }
        }
    }
}

// MARK: - Quick Action Button
struct QuickActionButton: View {
    let icon: String
    let title: String
    @State private var isPressed = false
    
    var body: some View {
        VStack(spacing: DesignSystem.Spacing.sm) {
            Button(action: {
                HapticManager.shared.light()
            }) {
                Circle()
                    .fill(DesignSystem.Colors.actionBg)
                    .frame(width: DesignSystem.Sizes.actionButton, height: DesignSystem.Sizes.actionButton)
                    .overlay(
                        Image(systemName: icon)
                            .font(.system(size: DesignSystem.Sizes.actionButtonIcon))
                            .foregroundColor(DesignSystem.Colors.textPrimary)
                    )
            }
            .scaleEffect(isPressed ? 0.96 : 1.0)
            .animation(.bouncy(duration: 0.3), value: isPressed)
            .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
                isPressed = pressing
            }, perform: {})
            
            Text(title)
                .font(DesignSystem.Typography.caption)
                .foregroundColor(DesignSystem.Colors.textPrimary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(height: 28)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Transactions Bottom Sheet
struct TransactionsBottomSheet: View {
    let transactions: [Transaction]
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("Операції")
                    .font(DesignSystem.Typography.headerLarge)
                    .foregroundColor(.black)
                
                Spacer()
                
                Button(action: {
                    HapticManager.shared.light()
                }) {
                    HStack(spacing: 3) {
                        Text("Усі")
                            .font(DesignSystem.Typography.buttonMedium)
                            .foregroundColor(.black)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(DesignSystem.Colors.bottomSheetButtonBg)
                    )
                }
            }
            .padding(.horizontal, DesignSystem.Spacing.lg)
            .padding(.top, DesignSystem.Spacing.xl)
            .padding(.bottom, DesignSystem.Spacing.lg)
            
            // Transaction list
            VStack(spacing: 0) {
                ForEach(transactions.prefix(4).indices, id: \.self) { index in
                    TransactionRowView(transaction: transactions[index])
                    
                    if index < transactions.prefix(4).count - 1 {
                        Divider()
                            .background(DesignSystem.Colors.divider.opacity(0.55))
                            .padding(.horizontal, DesignSystem.Spacing.lg)
                    }
                }
            }
            
            Spacer(minLength: 120) // Space for tab bar
        }
        .background(
            RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.bottomSheet, style: .continuous)
                .fill(DesignSystem.Colors.bottomSheetBg)
                .applyShadow(DesignSystem.Shadow.bottomSheet)
        )
    }
}

// MARK: - Transaction Row View
struct TransactionRowView: View {
    let transaction: Transaction
    
    var body: some View {
        HStack(spacing: DesignSystem.Spacing.lg) {
            // Icon
            ZStack {
                Circle()
                    .fill(transaction.iconColor.opacity(0.15))
                    .frame(width: DesignSystem.Sizes.transactionIcon, height: DesignSystem.Sizes.transactionIcon)
                
                Image(systemName: transaction.iconName)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(transaction.iconColor)
            }
            
            // Content
            VStack(alignment: .leading, spacing: 2) {
                Text(transaction.title)
                    .font(DesignSystem.Typography.bodyMedium)
                    .foregroundColor(.black)
                    .lineLimit(1)
                
                Text(transaction.formattedDate)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Amount
            Text(transaction.amount >= 0 ? "+\(String(format: "%.2f", transaction.amount)) ₴" : "−\(String(format: "%.2f", abs(transaction.amount))) ₴")
                .font(.system(size: 16, weight: .semibold))
                .monospacedDigit()
                .foregroundColor(transaction.amount >= 0 ? DesignSystem.Colors.positive : DesignSystem.Colors.negative)
        }
        .padding(.horizontal, DesignSystem.Spacing.lg)
        .padding(.vertical, DesignSystem.Spacing.lg)
        .frame(height: DesignSystem.Sizes.transactionRow)
    }
}

#Preview {
    CardsView(
        cards: .constant(Card.sampleCards),
        transactions: .constant(Transaction.sampleTransactions)
    )
}
