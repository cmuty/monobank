import SwiftUI

struct CardView: View {
    let card: Card
    
    var cardGradient: LinearGradient {
        switch card.cardType {
        case .black:
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.15, green: 0.15, blue: 0.2),
                    Color(red: 0.1, green: 0.1, blue: 0.15)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .white:
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.85, green: 0.87, blue: 0.92),
                    Color(red: 0.75, green: 0.77, blue: 0.85)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .iron:
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.4, green: 0.4, blue: 0.45),
                    Color(red: 0.3, green: 0.3, blue: 0.35)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .platinum:
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.7, green: 0.7, blue: 0.75),
                    Color(red: 0.6, green: 0.6, blue: 0.65)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
    
    var textColor: Color {
        card.cardType == .white ? .black : .white
    }
    
    var body: some View {
        ZStack {
            // Card background with 3D effect
            RoundedRectangle(cornerRadius: 16)
                .fill(cardGradient)
                .frame(width: 340, height: 200)
                .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
                .rotation3DEffect(
                    .degrees(card.cardType == .black ? 35 : 0.5),  // Черная карта максимально наклонена
                    axis: (x: 1, y: 0, z: 0),
                    perspective: 0.5
                )
            
            VStack(alignment: .leading, spacing: 0) {
                // Top section - monobank logo
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("monobank")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(textColor)
                        Text("Universal Bank")
                            .font(.system(size: 8))
                            .foregroundColor(textColor.opacity(0.6))
                    }
                    
                    Spacer()
                }
                .padding(.top, 20)
                .padding(.horizontal, 24)
                
                Spacer()
                
                // Card number
                Text(card.maskedNumber)
                    .font(.system(size: 18, weight: .medium, design: .monospaced))
                    .foregroundColor(textColor.opacity(0.8))
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)
                
                // Bottom section - только VISA, без имени владельца
                HStack {
                    Spacer()
                    
                    Text("VISA")
                        .font(.system(size: 20, weight: .bold))
                        .italic()
                        .foregroundColor(textColor)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
            }
            .frame(width: 340, height: 200)
            .rotation3DEffect(
                .degrees(card.cardType == .black ? 35 : 0.5),  // Черная карта максимально наклонена
                axis: (x: 1, y: 0, z: 0),
                perspective: 0.5
            )
        }
    }
}

#Preview {
    ZStack {
        Color.blue
        CardView(card: Card.sampleCards[0])
    }
}
