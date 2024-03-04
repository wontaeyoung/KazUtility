import Foundation

public final class NumberFormatManager {
  
  public static let shared = NumberFormatManager()
  private init() { configFormatter() }
  
  // MARK: - Property
  private let formatter = NumberFormatter()

  // MARK: - Method
  private func configFormatter() {
    formatter.numberStyle = .decimal
    formatter.roundingMode = .halfUp
  }
  
  public func toCurrency(from number: Int) -> String {
    return formatter.string(from: number as NSNumber) ?? String(number)
  }
  
  public func toRounded(from number: Double, fractionDigits: Int) -> String {
    formatter.maximumFractionDigits = fractionDigits
    return formatter.string(from: number as NSNumber) ?? String(number)
  }
}

