import Foundation

struct ParsedReceiptDraft {
    var amount: Double?
    var merchantName: String?
    var occurredAt: Date
    var address: String?
    var rawText: String
    var confidence: Double
}

protocol ReceiptParser {
    func parse(rawText: String, occurredAt: Date) -> ParsedReceiptDraft
}

struct PlaceholderReceiptParser: ReceiptParser {
    func parse(rawText: String, occurredAt: Date) -> ParsedReceiptDraft {
        let lines = rawText
            .split(whereSeparator: \.isNewline)
            .map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        let merchant = lines.first
        let address = lines.dropFirst().first(where: {
            $0.contains("路") || $0.contains("街") || $0.localizedCaseInsensitiveContains("road") || $0.localizedCaseInsensitiveContains("street")
        })
        let amount = extractAmount(from: rawText)
        let confidence = amount == nil ? 0.4 : 0.75
        return ParsedReceiptDraft(
            amount: amount,
            merchantName: merchant,
            occurredAt: occurredAt,
            address: address,
            rawText: rawText,
            confidence: confidence
        )
    }

    private func extractAmount(from text: String) -> Double? {
        let pattern = #"\d+(?:\.\d{1,2})?"#
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return nil }
        let range = NSRange(text.startIndex..<text.endIndex, in: text)
        let matches = regex.matches(in: text, range: range)
        let candidates = matches.compactMap { match -> Double? in
            guard let r = Range(match.range, in: text) else { return nil }
            return Double(String(text[r]))
        }
        return candidates.max()
    }
}
