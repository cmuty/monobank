import SwiftUI

struct CreditView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.25, green: 0.27, blue: 0.65),
                    Color(red: 0.35, green: 0.25, blue: 0.65)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header
                Text("Кредити")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, 60)
                
                Spacer()
                
                // Empty state
                VStack(spacing: 16) {
                    Image(systemName: "chart.pie.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.white.opacity(0.3))
                    
                    Text("У вас поки немає кредитів")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    CreditView()
}
