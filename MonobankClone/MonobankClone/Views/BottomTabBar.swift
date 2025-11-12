import SwiftUI

struct BottomTabBar: View {
    @Binding var selectedTab: TabItem
    
    var body: some View {
        HStack(spacing: 12) {
            // Основная карточка с 4 разделами (без маркета)
            HStack(spacing: 0) {
                ForEach(TabItem.allCases.filter { $0 != .market }, id: \.self) { tab in
                    TabBarButton(
                        tab: tab,
                        isSelected: selectedTab == tab,
                        action: { selectedTab = tab }
                    )
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
            .background(
                // Карточка с темно-черным цветом как у Monobank карты
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color(red: 0.15, green: 0.15, blue: 0.2))
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color.white.opacity(0.1), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: -2)
            )
            
            // Отдельная кнопка маркета
            TabBarButton(
                tab: .market,
                isSelected: selectedTab == .market,
                action: { selectedTab = .market }
            )
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color(red: 0.15, green: 0.15, blue: 0.2))
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color.white.opacity(0.1), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: -2)
            )
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 16)
    }
}

struct TabBarButton: View {
    let tab: TabItem
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: tab.icon)
                    .font(.system(size: 18, weight: isSelected ? .semibold : .regular))
                    .foregroundColor(isSelected ? Color(red: 1.0, green: 0.2, blue: 0.2) : Color.white.opacity(0.7))
                
                Text(tab.rawValue)
                    .font(.system(size: 9, weight: isSelected ? .semibold : .medium))
                    .foregroundColor(isSelected ? Color(red: 1.0, green: 0.2, blue: 0.2) : Color.white.opacity(0.8))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 6)
        }
    }
}

#Preview {
    VStack {
        Spacer()
        BottomTabBar(selectedTab: .constant(.cards))
    }
}
