import SwiftUI

// MARK: - View Extensions
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

// MARK: - Rounded Corner Shape
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - Date Extensions
extension Date {
    func formatted(as format: String, locale: Locale = Locale(identifier: "uk_UA")) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = locale
        return formatter.string(from: self)
    }
}

// MARK: - String Extensions
extension String {
    func masked(showFirst: Int = 4, showLast: Int = 4, maskChar: String = "*") -> String {
        guard count > showFirst + showLast else { return self }
        
        let start = prefix(showFirst)
        let end = suffix(showLast)
        let maskLength = count - showFirst - showLast
        let mask = String(repeating: maskChar, count: maskLength)
        
        return "\(start)\(mask)\(end)"
    }
}

// MARK: - Double Extensions
extension Double {
    func formatted(currency: String = "₴", decimals: Int = 2) -> String {
        let sign = self >= 0 ? "+" : ""
        return "\(sign)\(String(format: "%.\(decimals)f", self)) \(currency)"
    }
}
