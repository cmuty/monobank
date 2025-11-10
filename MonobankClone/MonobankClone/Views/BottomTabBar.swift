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
        .padding(.horizontal, 8)
        .padding(.top, 8)
        .padding(.bottom, 20)
        .background(
            Color(UIColor.systemBackground)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: -5)
        )
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
                    .font(.system(size: 22))
                    .foregroundColor(isSelected ? .red : .gray)
                
                Text(tab.rawValue)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(isSelected ? .red : .gray)
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
