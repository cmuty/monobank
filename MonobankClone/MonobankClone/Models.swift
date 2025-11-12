import Foundation
import SwiftUI

// MARK: - Card Model
struct Card: Identifiable, Codable {
    let id: String
    var cardNumber: String
    var cardholderName: String
    var balance: Double
    var currency: String
    var cardType: CardType
    var isBlocked: Bool
    var creditLimit: Double
    
    enum CardType: String, Codable {
        case black
        case white
        case iron
        case platinum
    }
    
    var maskedNumber: String {
        let parts = cardNumber.split(separator: " ")
        if parts.count == 4 {
            return "\(parts[0]) •••• •••• \(parts[3])"
        }
        return cardNumber
    }
}

// MARK: - Transaction Model
struct Transaction: Identifiable, Codable {
    let id: String
    var title: String
    var amount: Double
    var currency: String
    var date: Date
    var category: TransactionCategory
    var iconName: String
    var iconColor: Color
    
    enum TransactionCategory: String, Codable {
        case transfer
        case payment
        case shopping
        case food
        case transport
        case entertainment
        case utilities
        case other
    }
    
    var formattedAmount: String {
        let sign = amount >= 0 ? "+" : ""
        return "\(sign)\(String(format: "%.2f", amount)) \(currency)"
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        formatter.locale = Locale(identifier: "uk_UA")
        return formatter.string(from: date)
    }
}

// MARK: - Exchange Rate Model
struct ExchangeRate: Identifiable {
    let id = UUID()
    var currencyCode: String
    var currencyName: String
    var buyRate: Double
    var sellRate: Double
    var flag: String
    
    var formattedBuyRate: String {
        String(format: "%.2f", buyRate)
    }
    
    var formattedSellRate: String {
        String(format: "%.2f", sellRate)
    }
}

// MARK: - Service Item Model
struct ServiceItem: Identifiable {
    let id = UUID()
    var title: String
    var subtitle: String
    var iconName: String
    var iconColor: Color
}

// MARK: - Tab Item
enum TabItem: String, CaseIterable {
    case cards = "Картки"
    case credits = "Кредити"
    case savings = "Накопичення"
    case more = "Ще"
    case market = "Маркет"
    
    var icon: String {
        switch self {
        case .cards: return "creditcard.fill"
        case .credits: return "clock.fill"
        case .savings: return "target"
        case .more: return "square.grid.2x2.fill"
        case .market: return "lock.fill"
        }
    }
}

// MARK: - Sample Data
extension Card {
    static let sampleCards: [Card] = [
        Card(
            id: UUID().uuidString,
            cardNumber: "4441 1234 5678 6382",
            cardholderName: "BOHDAN ZARVA",
            balance: 1.33,
            currency: "₴",
            cardType: .black,
            isBlocked: false,
            creditLimit: 0
        ),
        Card(
            id: UUID().uuidString,
            cardNumber: "4874 5678 9012 3497",
            cardholderName: "BOHDAN ZARVA",
            balance: 18492.03,
            currency: "₴",
            cardType: .white,
            isBlocked: false,
            creditLimit: 0
        )
    ]
}

extension Transaction {
    static let sampleTransactions: [Transaction] = [
        Transaction(
            id: UUID().uuidString,
            title: "Переказ на картку",
            amount: -34.00,
            currency: "₴",
            date: Date(),
            category: .transfer,
            iconName: "square.fill",
            iconColor: .gray
        ),
        Transaction(
            id: UUID().uuidString,
            title: "Нова пошта",
            amount: -281.56,
            currency: "₴",
            date: Date(),
            category: .shopping,
            iconName: "plus.circle.fill",
            iconColor: .red
        ),
        Transaction(
            id: UUID().uuidString,
            title: "Telegram",
            amount: -83.99,
            currency: "₴",
            date: Date(),
            category: .payment,
            iconName: "paperplane.fill",
            iconColor: .blue
        ),
        Transaction(
            id: UUID().uuidString,
            title: "З Чорної картки",
            amount: 34.00,
            currency: "₴",
            date: Date(),
            category: .transfer,
            iconName: "arrow.down",
            iconColor: .green
        ),
        Transaction(
            id: UUID().uuidString,
            title: "Економ",
            amount: -73.80,
            currency: "₴",
            date: Date().addingTimeInterval(-86400),
            category: .shopping,
            iconName: "cart.fill",
            iconColor: .orange
        ),
        Transaction(
            id: UUID().uuidString,
            title: "EKONOM PLUS",
            amount: -29.90,
            currency: "₴",
            date: Date().addingTimeInterval(-86400),
            category: .shopping,
            iconName: "cart.fill",
            iconColor: .orange
        ),
        Transaction(
            id: UUID().uuidString,
            title: "Економ",
            amount: -12.90,
            currency: "₴",
            date: Date().addingTimeInterval(-86400),
            category: .shopping,
            iconName: "cart.fill",
            iconColor: .orange
        ),
        Transaction(
            id: UUID().uuidString,
            title: "BULOCHKA SHOP",
            amount: -22.00,
            currency: "₴",
            date: Date().addingTimeInterval(-86400),
            category: .food,
            iconName: "fork.knife",
            iconColor: .orange
        ),
        Transaction(
            id: UUID().uuidString,
            title: "Сільпо",
            amount: -137.56,
            currency: "₴",
            date: Date().addingTimeInterval(-172800),
            category: .shopping,
            iconName: "cart.fill",
            iconColor: .orange
        )
    ]
}

extension ExchangeRate {
    static let sampleRates: [ExchangeRate] = [
        ExchangeRate(
            currencyCode: "USD",
            currencyName: "Долар США",
            buyRate: 41.74,
            sellRate: 42.18,
            flag: "🇺🇸"
        ),
        ExchangeRate(
            currencyCode: "EUR",
            currencyName: "Євро",
            buyRate: 48.21,
            sellRate: 48.77,
            flag: "🇪🇺"
        )
    ]
}

// MARK: - Color Extension for Codable
extension Color: Codable {
    enum CodingKeys: String, CodingKey {
        case red, green, blue, opacity
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let r = try container.decode(Double.self, forKey: .red)
        let g = try container.decode(Double.self, forKey: .green)
        let b = try container.decode(Double.self, forKey: .blue)
        let o = try container.decode(Double.self, forKey: .opacity)
        self.init(red: r, green: g, blue: b, opacity: o)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var o: CGFloat = 0
        
        #if os(iOS)
        UIColor(self).getRed(&r, green: &g, blue: &b, alpha: &o)
        #endif
        
        try container.encode(Double(r), forKey: .red)
        try container.encode(Double(g), forKey: .green)
        try container.encode(Double(b), forKey: .blue)
        try container.encode(Double(o), forKey: .opacity)
    }
}
