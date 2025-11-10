import SwiftUI

struct TransactionListView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var transactions: [Transaction]
    let card: Card
    @State private var searchText = ""
    
    var groupedTransactions: [String: [Transaction]] {
        Dictionary(grouping: transactions) { transaction in
            transaction.formattedDate
        }
    }
    
    var sortedDates: [String] {
        groupedTransactions.keys.sorted { date1, date2 in
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMMM yyyy"
            formatter.locale = Locale(identifier: "uk_UA")
            
            guard let d1 = formatter.date(from: date1),
                  let d2 = formatter.date(from: date2) else {
                return false
            }
            return d1 > d2
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header with card info
                    VStack(spacing: 8) {
                        // Mini card
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(red: 0.15, green: 0.15, blue: 0.2))
                                .frame(width: 60, height: 38)
                            
                            VStack(spacing: 2) {
                                Text("monobank")
                                    .font(.system(size: 6, weight: .medium))
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Text("VISA")
                                    .font(.system(size: 8, weight: .bold))
                                    .italic()
                                    .foregroundColor(.white)
                            }
                            .padding(4)
                            .frame(width: 60, height: 38)
                        }
                        
                        Text("\(String(format: "%.2f", card.balance)) ₴")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.primary)
                        
                        Text("Вчора")
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(Color(UIColor.systemBackground))
                    
                    // Transactions list
                    ScrollView {
                        LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                            ForEach(sortedDates, id: \.self) { date in
                                Section(header: DateHeader(date: date)) {
                                    VStack(spacing: 0) {
                                        ForEach(groupedTransactions[date] ?? []) { transaction in
                                            TransactionDetailRow(transaction: transaction)
                                            
                                            if transaction.id != groupedTransactions[date]?.last?.id {
                                                Divider()
                                                    .padding(.leading, 76)
                                            }
                                        }
                                    }
                                    .background(Color(UIColor.systemBackground))
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.primary)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}

struct DateHeader: View {
    let date: String
    
    var body: some View {
        HStack {
            Text(date)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
        .background(Color(UIColor.systemGroupedBackground))
    }
}

struct TransactionDetailRow: View {
    let transaction: Transaction
    
    var body: some View {
        HStack(spacing: 12) {
            // Icon
            ZStack {
                Circle()
                    .fill(transaction.iconColor.opacity(0.1))
                    .frame(width: 44, height: 44)
                
                Image(systemName: transaction.iconName)
                    .font(.system(size: 18))
                    .foregroundColor(transaction.iconColor)
            }
            
            // Title
            Text(transaction.title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.primary)
            
            Spacer()
            
            // Amount
            Text(transaction.formattedAmount)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(transaction.amount >= 0 ? .green : .primary)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(Color(UIColor.systemBackground))
    }
}

#Preview {
    TransactionListView(
        transactions: .constant(Transaction.sampleTransactions),
        card: Card.sampleCards[0]
    )
}
