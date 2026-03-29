import SwiftUI

struct ExpenseRowView: View {
    let expense: Expense

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: expense.receiptDetected ? "doc.text.viewfinder" : "square.and.pencil")
                .foregroundStyle(expense.receiptDetected ? .green : .orange)

            VStack(alignment: .leading, spacing: 6) {
                Text(expense.merchantName)
                    .font(.headline)

                HStack {
                    Text(expense.category.localizedName)
                    Text("·")
                    Text(expense.location)
                }
                .font(.caption)
                .foregroundStyle(.secondary)

                Text(LVUFormatters.expenseDate.string(from: expense.date))
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text(localizedCurrency(expense.amount))
                .font(.subheadline.weight(.semibold))
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ExpenseRowView(expense: Expense.samples[0])
        .padding()
}
