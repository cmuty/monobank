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
            .padding(.horizontal, 1)
            .padding(.vertical, 6)
            .background(
                // Карточка с белым цветом
                RoundedRectangle(cornerRadius: 32)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 32)
                            .stroke(Color.black.opacity(0.1), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: -2)
            )
            
            // Отдельная кнопка маркета - полноценная кнопка
            Button(action: { selectedTab = .market }) {
                VStack(spacing: 4) {
                    Image(systemName: TabItem.market.icon)
                        .font(.system(size: 16, weight: selectedTab == .market ? .semibold : .regular))
                        .foregroundColor(selectedTab == .market ? Color(red: 1.0, green: 0.2, blue: 0.2) : Color.black.opacity(0.7))
                    
                    Text("Маркет")
                        .font(.system(size: 10, weight: selectedTab == .market ? .semibold : .medium))
                        .foregroundColor(selectedTab == .market ? Color(red: 1.0, green: 0.2, blue: 0.2) : Color.black.opacity(0.8))
                }
            }
            .frame(width: 60, height: 65)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.black.opacity(0.1), lineWidth: 1)
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
            VStack(spacing: 4) {
                Image(systemName: tab.icon)
                    .font(.system(size: 16, weight: isSelected ? .semibold : .regular))
                    .foregroundColor(isSelected ? Color(red: 1.0, green: 0.2, blue: 0.2) : Color.black.opacity(0.7))
                
                Text(tab.rawValue)
                    .font(.system(size: 10, weight: isSelected ? .semibold : .medium))
                    .foregroundColor(isSelected ? Color(red: 1.0, green: 0.2, blue: 0.2) : Color.black.opacity(0.8))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
        }
    }
}

#Preview {
    VStack {
        Spacer()
        BottomTabBar(selectedTab: .constant(.cards))
    }
}
