import SwiftUI

struct BottomTabBar: View {
    @Binding var selectedTab: TabItem
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(TabItem.allCases, id: \.self) { tab in
                TabBarButton(
                    tab: tab,
                    isSelected: selectedTab == tab,
                    action: { selectedTab = tab }
                )
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 12)
        .background(
            // Карточка с цветом как у Monobank карты
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(red: 0.2, green: 0.25, blue: 0.4))
                .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: -2)
        )
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
                    .font(.system(size: 20, weight: isSelected ? .semibold : .regular))
                    .foregroundColor(isSelected ? Color(red: 1.0, green: 0.2, blue: 0.2) : Color.white.opacity(0.7))
                
                Text(tab.rawValue)
                    .font(.system(size: 10, weight: isSelected ? .semibold : .medium))
                    .foregroundColor(isSelected ? Color(red: 1.0, green: 0.2, blue: 0.2) : Color.white.opacity(0.8))
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
