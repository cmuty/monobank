import SwiftUI

struct MarketView: View {
    var body: some View {
        VStack(spacing: 20) {
                // Header
                Text("Маркет")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, 60)
                
                Spacer()
                
                // Empty state
                VStack(spacing: 16) {
                    Image(systemName: "bag.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.white.opacity(0.3))
                    
                    Text("Маркет незабаром")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                
                // Отступ для фиксированного footer
                Spacer().frame(height: 120)
        }
    }
}

#Preview {
    MarketView()
}
