import SwiftUI

struct ExchangeRatesView: View {
    let rates = ExchangeRate.sampleRates
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Корисне")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 20)
            
            VStack(spacing: 12) {
                ForEach(rates) { rate in
                    ExchangeRateCard(rate: rate)
                }
            }
            .padding(.horizontal, 20)
        }
        .background(Color.white)
        .cornerRadius(20, corners: [.topLeft, .topRight])
    }
}

struct ExchangeRateCard: View {
    let rate: ExchangeRate
    
    var body: some View {
        HStack(spacing: 12) {
            // Flag
            Text(rate.flag)
                .font(.system(size: 32))
            
            // Currency info
            VStack(alignment: .leading, spacing: 4) {
                Text(rate.currencyName)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
                
                Text("\(rate.formattedBuyRate) / \(rate.formattedSellRate)")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
            }
            
            Spacer()
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.systemGray6))
        )
    }
}

#Preview {
    ZStack {
        Color.blue
        VStack {
            Spacer()
            ExchangeRatesView()
        }
    }
}
