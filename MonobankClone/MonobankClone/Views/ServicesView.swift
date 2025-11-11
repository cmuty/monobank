import SwiftUI

struct ServicesView: View {
    let services = [
        ServiceItem(
            title: "Служба підтримки",
            subtitle: "",
            iconName: "person.fill.questionmark",
            iconColor: .blue
        ),
        ServiceItem(
            title: "Поширені запитання",
            subtitle: "",
            iconName: "questionmark.circle.fill",
            iconColor: .purple
        ),
        ServiceItem(
            title: "Виписки та довідки",
            subtitle: "",
            iconName: "doc.text.fill",
            iconColor: .pink
        ),
        ServiceItem(
            title: "Умови і тарифи",
            subtitle: "",
            iconName: "doc.plaintext.fill",
            iconColor: .green
        )
    ]
    
    var body: some View {
        ScrollView {
                VStack(spacing: 20) {
                    // Header
                    Text("Ще")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        .padding(.top, 60)
                    
                    // Limits and restrictions
                    VStack(spacing: 0) {
                        HStack(spacing: 16) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.blue.opacity(0.2))
                                    .frame(width: 60, height: 60)
                                
                                Image(systemName: "building.columns.fill")
                                    .font(.system(size: 28))
                                    .foregroundColor(.blue)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Ліміти та обмеження")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                                
                                Text("Для витрат з карток")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white.opacity(0.5))
                        }
                        .padding(20)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white.opacity(0.15))
                    )
                    .padding(.horizontal, 20)
                    
                    // Exchange rates
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Корисне")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                        
                        ExchangeRatesView()
                    }
                    
                    // Services grid
                    VStack(spacing: 12) {
                        HStack(spacing: 12) {
                            ServiceCard(service: services[0])
                            ServiceCard(service: services[1])
                        }
                        
                        HStack(spacing: 12) {
                            ServiceCard(service: services[2])
                            ServiceCard(service: services[3])
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 120)  // Отступ для фиксированного footer
                }
            }
    }
}

struct ServiceCard: View {
    let service: ServiceItem
    
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(service.iconColor.opacity(0.2))
                    .frame(width: 60, height: 60)
                
                Image(systemName: service.iconName)
                    .font(.system(size: 28))
                    .foregroundColor(service.iconColor)
            }
            
            Text(service.title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.15))
        )
    }
}

#Preview {
    ServicesView()
}
