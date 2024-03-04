public extension Int {
  var toCurrency: String {
    return "₩\(NumberFormatManager.shared.toCurrency(from: self))"
  }
}
