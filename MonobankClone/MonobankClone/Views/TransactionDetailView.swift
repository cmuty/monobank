import SwiftUI

struct TransactionDetailView: View {
    let transaction: Transaction
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with back button and icon
            VStack(spacing: 20) {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                // Transaction icon
                ZStack {
                    Circle()
                        .fill(transaction.iconColor.opacity(0.2))
                        .frame(width: 80, height: 80)
                    
                    Image(systemName: transaction.iconName)
                        .font(.system(size: 32, weight: .medium))
                        .foregroundColor(transaction.iconColor)
                }
                
                // Transaction title
                Text(transaction.title)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                
                // Transaction type badge
                Text(getTransactionType())
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.black.opacity(0.7))
                    )
                
                // Date
                Text(transaction.date.formatted(.dateTime.day().month().year().hour().minute()))
                    .font(.system(size: 16))
                    .foregroundColor(.black.opacity(0.6))
                
                // Amount
                Text(transaction.formattedAmount)
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.black)
                
                Spacer()
            }
            .padding(.top, 20)
            .background(Color.white)
            
            // Bottom section
            VStack(spacing: 16) {
                // Description section
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: "doc.text")
                            .font(.system(size: 16))
                            .foregroundColor(.black.opacity(0.6))
                        Text("Опис та #теги")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.black.opacity(0.6))
                        Spacer()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.black.opacity(0.05))
                )
                
                // Balance section
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: "creditcard")
                            .font(.system(size: 16))
                            .foregroundColor(.black.opacity(0.6))
                        Text("Залишок")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.black.opacity(0.6))
                        Spacer()
                        Text("0.33 ₴")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.black.opacity(0.05))
                )
                
                // Question section
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: "questionmark.circle")
                            .font(.system(size: 16))
                            .foregroundColor(.red)
                        Text("Поставити запитання")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.black)
                        Spacer()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.black.opacity(0.05))
                )
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 20)
            .background(Color(red: 0.95, green: 0.95, blue: 0.95))
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.0, green: 0.1, blue: 0.45),
                    Color(red: 0.18, green: 0.35, blue: 0.65),
                    Color.white
                ]),
                startPoint: .top,
                endPoint: .center
            )
        )
        .ignoresSafeArea()
    }
    
    private func getTransactionType() -> String {
        if transaction.title.contains("Переказ") {
            return "На Білу картку"
        } else if transaction.title.contains("Нова пошта") {
            return "Інше"
        } else if transaction.title.contains("Білої картки") {
            return "Поповнення картки"
        }
        return "Операція"
    }
}

#Preview {
    TransactionDetailView(transaction: Transaction.sampleTransactions[0])
}
