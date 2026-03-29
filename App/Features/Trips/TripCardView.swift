import SwiftUI

struct TripCardView: View {
    let trip: Trip

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(trip.title)
                        .font(.headline)
                    Text(trip.destination)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                if trip.withKids {
                    Label(L10n.Common.withKids, systemImage: "figure.and.child.holdinghands")
                        .font(.caption)
                        .foregroundStyle(.blue)
                }
            }

            Text(LVUFormatters.tripDateRange.string(from: trip.startDate, to: trip.endDate))
                .font(.caption)
                .foregroundStyle(.secondary)

            HStack {
                Label(localizedCurrency(trip.budget), systemImage: "banknote")
                Spacer()
                Label(trip.isSelfDrive ? L10n.Common.selfDrive : L10n.Common.transit, systemImage: trip.isSelfDrive ? "car" : "tram")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    TripCardView(trip: Trip.samples[0])
        .padding()
}
