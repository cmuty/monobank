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
            // 3D Card layers for thickness effect
            ForEach(0..<4, id: \.self) { layer in
                RoundedRectangle(cornerRadius: 16)
                    .fill(cardGradient.opacity(layer == 0 ? 1.0 : 0.7 - Double(layer) * 0.15))
                    .frame(width: 320, height: 190)
                    .offset(x: CGFloat(layer) * 1.5, y: CGFloat(layer) * 1.5)
                    .rotation3DEffect(
                        .degrees(disableTilt ? 0 : (card.cardType == .black || card.cardType == .white ? 60 : 0.5)),
                        axis: (x: 1, y: 0, z: 0),
                        perspective: 0.4
                    )
            }
            
            ZStack {
                // monobank logo - сверху слева
                VStack(alignment: .leading, spacing: 0) {
                    Text("monobank")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(textColor)
                        .shadow(color: Color(red: 0.08, green: 0.14, blue: 0.37).opacity(0.8), radius: 4, x: 1, y: 2)
                    
                    HStack(spacing: 0) {
                        // Invisible text to align "Universal Bank" under "ank"
                        Text("monob")
                            .font(.system(size: 20, weight: .medium))
                            .opacity(0)
                        
                        Text("Universal Bank")
                            .font(.system(size: 6))
                            .foregroundColor(textColor.opacity(0.6))
                            .shadow(color: Color(red: 0.08, green: 0.14, blue: 0.37).opacity(0.6), radius: 1, x: 0.5, y: 0.5)
                    }
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
                    .shadow(color: Color(red: 0.08, green: 0.14, blue: 0.37).opacity(0.9), radius: 6, x: 2, y: 3)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
                // VISA - снизу справа
                Text("VISA")
                    .font(.system(size: 20, weight: .bold))
                    .italic()
                    .foregroundColor(textColor)
                    .shadow(color: Color(red: 0.08, green: 0.14, blue: 0.37).opacity(0.8), radius: 4, x: 1, y: 2)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .padding(.bottom, 20)
                    .padding(.trailing, 24)
            }
            .frame(width: 320, height: 190)
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
