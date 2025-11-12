import SwiftUI
import UIKit

// MARK: - Design System
struct DesignSystem {
    
    // MARK: - Colors
    struct Colors {
        // Background Colors
        static let bgTop = Color(red: 0/255, green: 26/255, blue: 117/255)        // #001A75
        static let bgBottom = Color(red: 46/255, green: 88/255, blue: 165/255)    // #2E58A5
        
        // Card Colors
        static let cardTop = Color(red: 17/255, green: 26/255, blue: 64/255)      // #111A40
        static let cardBottom = Color(red: 29/255, green: 46/255, blue: 96/255)   // #1D2E60
        
        // UI Elements
        static let chipBg = Color.white.opacity(0.14)                             // rgba(255,255,255,0.14)
        
        // Text Colors
        static let textPrimary = Color.white                                      // #FFFFFF
        static let textSecondary = Color(red: 216/255, green: 216/255, blue: 216/255) // #D8D8D8
        
        // Status Colors
        static let positive = Color(red: 0/255, green: 200/255, blue: 83/255)     // #00C853
        static let negative = Color(red: 255/255, green: 59/255, blue: 48/255)    // #FF3B30
        
        // Dividers
        static let divider = Color(red: 43/255, green: 61/255, blue: 112/255)     // #2B3D70
        
        // Tab Bar
        static let tabActive = Color(red: 229/255, green: 57/255, blue: 53/255)   // #E53935
        static let tabMuted = Color(red: 165/255, green: 165/255, blue: 165/255)  // #A5A5A5
        
        // Actions
        static let actionBg = Color(red: 30/255, green: 47/255, blue: 96/255)     // #1E2F60
        
        // Bottom Sheet
        static let bottomSheetBg = Color.white
        static let bottomSheetButtonBg = Color(red: 239/255, green: 242/255, blue: 247/255) // #EFF2F7
    }
    
    // MARK: - Typography
    struct Typography {
        // Balance Typography
        static let balanceNumber = Font.system(size: 60, weight: .bold, design: .default)
            .monospacedDigit()
        static let balanceCurrency = Font.system(size: 54, weight: .bold, design: .default)
        
        // Card Typography
        static let cardNumber = Font.system(size: 20, weight: .semibold, design: .default)
            .monospacedDigit()
        static let cardHolder = Font.system(size: 14, weight: .medium, design: .default)
        
        // Headers
        static let headerLarge = Font.system(size: 20, weight: .semibold, design: .default)
        static let headerMedium = Font.system(size: 18, weight: .semibold, design: .default)
        static let headerSmall = Font.system(size: 16, weight: .semibold, design: .default)
        
        // Body Text
        static let bodyLarge = Font.system(size: 17, weight: .regular, design: .default)
        static let bodyMedium = Font.system(size: 16, weight: .regular, design: .default)
        static let bodySmall = Font.system(size: 14, weight: .regular, design: .default)
        static let caption = Font.system(size: 12, weight: .regular, design: .default)
        
        // Buttons
        static let buttonMedium = Font.system(size: 14, weight: .medium, design: .default)
        static let buttonSmall = Font.system(size: 12, weight: .medium, design: .default)
        
        static let tabBar = Font.system(size: 12, weight: .medium, design: .default)
    }

    struct Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 20
        static let xxl: CGFloat = 24
        static let xxxl: CGFloat = 28
        static let huge: CGFloat = 32
    }

    struct CornerRadius {
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
        static let card: CGFloat = 20
        static let bottomSheet: CGFloat = 24
        static let extraLarge: CGFloat = 28
        static let capsule: CGFloat = 100
    }
    
    struct Shadow {
        static let card = ShadowStyle(
            color: Color.black.opacity(0.25),
            radius: 10,
            x: 0,
            y: 4
        )
        
        static let bottomSheet = ShadowStyle(
            color: Color.black.opacity(0.1),
            radius: 8,
            x: 0,
            y: -2
        )
        
        static let tabBar = ShadowStyle(
            color: Color.black.opacity(0.08),
            radius: 6,
            x: 0,
            y: -1
        )
    }
    
    struct Sizes {
        static let avatarSmall: CGFloat = 34
        static let avatarMedium: CGFloat = 44
        
        static let badge: CGFloat = 16
        
        static let actionButton: CGFloat = 72
        static let actionButtonIcon: CGFloat = 24
        static let chipButton: CGFloat = 28
        static let addButton: CGFloat = 28
        
        static let cardHeight: CGFloat = 200
        
        static let transactionIcon: CGFloat = 32
        static let transactionRow: CGFloat = 64
        
        static let tabBarHeight: CGFloat = 88
    }
    
    // MARK: - Card Carousel
    struct CardCarousel {
        static let leftPeek: CGFloat = 16
        static let rightPeek: CGFloat = 44
        static let spacing: CGFloat = 14
        static let inactiveScale: CGFloat = 0.96
        static let activeScale: CGFloat = 1.0
    }
}

// MARK: - Shadow Style
struct ShadowStyle {
    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat
}

// MARK: - View Extension for Shadows
extension View {
    func applyShadow(_ shadowStyle: ShadowStyle) -> some View {
        self.shadow(
            color: shadowStyle.color,
            radius: shadowStyle.radius,
            x: shadowStyle.x,
            y: shadowStyle.y
        )
    }
}

// MARK: - Background Gradient
extension DesignSystem {
    static var backgroundGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [Colors.bgTop, Colors.bgBottom]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    static var cardGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [Colors.cardTop, Colors.cardBottom]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

// MARK: - Haptic Feedback Helper
class HapticManager {
    static let shared = HapticManager()
    
    private let lightImpact = UIImpactFeedbackGenerator(style: .light)
    private let mediumImpact = UIImpactFeedbackGenerator(style: .medium)
    private let heavyImpact = UIImpactFeedbackGenerator(style: .heavy)
    
    func light() {
        lightImpact.impactOccurred()
    }
    
    func medium() {
        mediumImpact.impactOccurred()
    }
    
    func heavy() {
        heavyImpact.impactOccurred()
    }
}
