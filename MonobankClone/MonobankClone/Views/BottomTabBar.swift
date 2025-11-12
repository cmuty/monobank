import SwiftUI

struct BottomTabBar: View {
    @Binding var selectedTab: TabItem
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(TabItem.allCases, id: \.self) { tab in
                TabBarButton(
                    tab: tab,
                    isSelected: selectedTab == tab,
                    action: { 
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedTab = tab
                        }
                        HapticManager.shared.light()
                    }
                )
            }
        }
        .frame(height: DesignSystem.Sizes.tabBarHeight)
        .background(
            Rectangle()
                .fill(DesignSystem.Colors.bottomSheetBg)
                .applyShadow(DesignSystem.Shadow.tabBar)
        )
        .ignoresSafeArea(edges: .bottom)
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
                    .font(.system(size: 20, weight: isSelected ? .semibold : .regular))
                    .foregroundColor(isSelected ? DesignSystem.Colors.tabActive : DesignSystem.Colors.tabMuted)
                    .scaleEffect(isSelected ? 1.1 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
                
                Text(tab.rawValue)
                    .font(DesignSystem.Typography.tabBar)
                    .foregroundColor(isSelected ? DesignSystem.Colors.tabActive : DesignSystem.Colors.tabMuted)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 8)
            .padding(.bottom, 20) // Extra padding for home indicator
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    VStack {
        Spacer()
        BottomTabBar(selectedTab: .constant(.cards))
    }
}
