import SwiftUI

struct CardDetailView: View {
    @Environment(\.dismiss) var dismiss
    let card: Card
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient - такой же как в приложении
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.078, green: 0.145, blue: 0.373),  // #14255F
                        Color(red: 0.0, green: 0.043, blue: 0.118)     // #000B1E
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Large card - без наклона
                        CardView(card: card, disableTilt: true)
                            .scaleEffect(1.1)
                            .padding(.top, 40)
                            .padding(.bottom, 20)
                        
                        // Payment settings section
                        VStack(spacing: 0) {
                            SettingRow(
                                icon: "target",
                                title: "Налаштування оплат",
                                subtitle: "Додаткові перевірки",
                                iconColor: .blue
                            )
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(red: 0.2, green: 0.22, blue: 0.55))
                        )
                        .padding(.horizontal, 20)
                        
                        // Black card section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Чорна картка")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                            
                            VStack(spacing: 0) {
                                SettingRow(
                                    icon: "applelogo",
                                    title: "Налаштування Apple Pay",
                                    subtitle: "Обрати скін картки — у нас їх багато",
                                    iconColor: .white
                                )
                                
                                SettingRow(
                                    icon: "lock.fill",
                                    title: "Заблокувати картку",
                                    subtitle: "Ви завжди зможете її розблокувати",
                                    iconColor: .white
                                )
                                
                                SettingRow(
                                    icon: "creditcard.fill",
                                    title: "Змінити кредитний ліміт",
                                    subtitle: "Поточний ліміт 0 ₴",
                                    iconColor: .white
                                )
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color(red: 0.2, green: 0.22, blue: 0.55))
                            )
                            .padding(.horizontal, 20)
                        }
                        
                        // Subscriptions and services
                        VStack(spacing: 0) {
                            SettingRow(
                                icon: "at",
                                title: "Підписки та сервіси",
                                subtitle: "Керування списаннями з картки",
                                iconColor: .white
                            )
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(red: 0.2, green: 0.22, blue: 0.55))
                        )
                        .padding(.horizontal, 20)
                        
                        // Additional options
                        VStack(spacing: 0) {
                            SettingRow(
                                icon: "doc.text.fill",
                                title: "Випустити пластикову картку",
                                subtitle: nil,
                                iconColor: .white
                            )
                            
                            SettingRow(
                                icon: "arrow.right.arrow.left",
                                title: "Перевипустити картку",
                                subtitle: nil,
                                iconColor: .white
                            )
                            
                            SettingRow(
                                icon: "magnifyingglass",
                                title: "Налаштування ПІН-коду",
                                subtitle: nil,
                                iconColor: .white
                            )
                            
                            SettingRow(
                                icon: "doc.plaintext.fill",
                                title: "Реквізити картки",
                                subtitle: "Для поповнення за IBAN",
                                iconColor: .white
                            )
                            
                            SettingRow(
                                icon: "doc.fill",
                                title: "Надіслати виписку за карткою",
                                subtitle: nil,
                                iconColor: .white
                            )
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(red: 0.2, green: 0.22, blue: 0.55))
                        )
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

struct SettingRow: View {
    let icon: String
    let title: String
    let subtitle: String?
    let iconColor: Color
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(iconColor.opacity(0.2))
                    .frame(width: 44, height: 44)
                
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(iconColor)
            }
            
            // Text
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.6))
                }
            }
            
            Spacer()
            
            // Chevron
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white.opacity(0.4))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

#Preview {
    CardDetailView(card: Card.sampleCards[0])
}
