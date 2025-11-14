import SwiftUI

struct ContentView: View {
    @State private var selectedTab: TabItem = .cards
    @State private var cards: [Card] = Card.sampleCards
    
    var body: some View {
        ZStack {
            // Background gradient - трехцветный как на скриншоте Monobank
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.08, green: 0.14, blue: 0.37),     // Темно-синий сверху
                    Color(red: 0.25, green: 0.35, blue: 0.65),     // Мягкий синий в середине
                    Color(red: 0.95, green: 0.96, blue: 0.98)      // Белый снизу
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
                        MainView(cards: $cards)
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
