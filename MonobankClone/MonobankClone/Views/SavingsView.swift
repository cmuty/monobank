import SwiftUI

struct SavingsView: View {
    var body: some View {
        VStack(spacing: 20) {
                // Header
                Text("Накопичення")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, 60)
                
                Spacer()
                
                // Empty state
                VStack(spacing: 16) {
                    Image(systemName: "target")
                        .font(.system(size: 60))
                        .foregroundColor(.white.opacity(0.3))
                    
                    Text("Створіть свою першу скарбничку")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                    
                    Button(action: {}) {
                        Text("Створити")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 32)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white.opacity(0.2))
                            )
                    }
                    .padding(.top, 8)
                }
                
                Spacer()
        }
    }
}

#Preview {
    SavingsView()
}
