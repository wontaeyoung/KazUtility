public extension Array {
  subscript(at index: Int) -> Element? {
    guard self.indices ~= index else { return nil }
    
    return self[index]
  }
}
