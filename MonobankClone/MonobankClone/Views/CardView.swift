import SwiftUI

struct CardView: View {
    let card: Card
    var disableTilt: Bool = false
    
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
                    .degrees(disableTilt ? 0 : (card.cardType == .black || card.cardType == .white ? 60 : 0.5)),  // Черная и белая карты наклонены
                    axis: (x: 1, y: 0, z: 0),
                    perspective: 0.4
                )
            
            ZStack {
                // monobank logo - сверху слева
                VStack(alignment: .leading, spacing: 2) {
                    Text("monobank")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(textColor)
                    Text("Universal Bank")
                        .font(.system(size: 8))
                        .foregroundColor(textColor.opacity(0.6))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.top, 20)
                .padding(.leading, 24)
                
                // Card number - по центру, крупнее
                Text(card.maskedNumber)
                    .font(.custom("SF Pro Display", size: 28))
                    .fontWeight(.light)
                    .kerning(2.0)
                    .foregroundColor(textColor.opacity(0.9))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
                // VISA - снизу справа
                Text("VISA")
                    .font(.system(size: 20, weight: .bold))
                    .italic()
                    .foregroundColor(textColor)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .padding(.bottom, 20)
                    .padding(.trailing, 24)
            }
            .frame(width: 340, height: 200)
            .rotation3DEffect(
                .degrees(disableTilt ? 0 : (card.cardType == .black || card.cardType == .white ? 60 : 0.5)),  // Черная и белая карты наклонены
                axis: (x: 1, y: 0, z: 0),
                perspective: 0.4
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
