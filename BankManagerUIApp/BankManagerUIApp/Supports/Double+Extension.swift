import Foundation

extension Double {
    
    func formatTimeToDecimalPlaces(_ decimalPlaces: Int) -> Double {
        let formatString = "%.\(decimalPlaces)f"
        return Double(String(format: formatString, self)) ?? 0.0
    }
}
