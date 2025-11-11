import SwiftUI

struct ContentView: View {
    @State private var selectedTab: TabItem = .cards
    @State private var cards: [Card] = Card.sampleCards
    @State private var transactions: [Transaction] = Transaction.sampleTransactions
    
    var body: some View {
        ZStack {
            // Background gradient - новый дизайн
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.078, green: 0.145, blue: 0.373),  // #14255F
                    Color(red: 0.0, green: 0.043, blue: 0.118)     // #000B1E
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            ZStack(alignment: .bottom) {
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
                
                // Fixed bottom tab bar
                BottomTabBar(selectedTab: $selectedTab)
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
