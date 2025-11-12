import SwiftUI

struct ContentView: View {
    @State private var selectedTab: TabItem = .cards
    @State private var cards: [Card] = Card.sampleCards
    @State private var transactions: [Transaction] = Transaction.sampleTransactions
    
    var body: some View {
        ZStack {
            // Background gradient - от синего к белому
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0/255, green: 26/255, blue: 117/255),  // #001A75 синий сверху
                    Color.white  // белый снизу
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
