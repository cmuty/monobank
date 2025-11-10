import SwiftUI

struct ContentView: View {
    @State private var selectedTab: TabItem = .cards
    @State private var cards: [Card] = Card.sampleCards
    @State private var transactions: [Transaction] = Transaction.sampleTransactions
    
    var body: some View {
        ZStack {
            // Background gradient - точно как в Monobank
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.15, green: 0.18, blue: 0.45),  // Темно-синий
                    Color(red: 0.25, green: 0.30, blue: 0.60),  // Средний синий
                    Color(red: 0.35, green: 0.40, blue: 0.75)   // Светло-синий
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Main content - БЕЗ свайпа между страницами, только кнопки навигации
                Group {
                    switch selectedTab {
                    case .cards:
                        MainView(cards: $cards, transactions: $transactions)
                    case .credits:
                        CreditView()
                    case .savings:
                        SavingsView()
                    case .more:
                        ServicesView()
                    case .market:
                        MarketView()
                    }
                }
                .animation(.easeInOut(duration: 0.3), value: selectedTab)
                
                // Custom bottom tab bar
                BottomTabBar(selectedTab: $selectedTab)
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
