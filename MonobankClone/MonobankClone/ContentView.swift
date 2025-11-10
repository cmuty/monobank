import SwiftUI

struct ContentView: View {
    @State private var selectedTab: TabItem = .cards
    @State private var cards: [Card] = Card.sampleCards
    @State private var transactions: [Transaction] = Transaction.sampleTransactions
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.25, green: 0.27, blue: 0.65),
                    Color(red: 0.35, green: 0.25, blue: 0.65)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Main content
                TabView(selection: $selectedTab) {
                    MainView(cards: $cards, transactions: $transactions)
                        .tag(TabItem.cards)
                    
                    CreditView()
                        .tag(TabItem.credits)
                    
                    SavingsView()
                        .tag(TabItem.savings)
                    
                    ServicesView()
                        .tag(TabItem.more)
                    
                    MarketView()
                        .tag(TabItem.market)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
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
