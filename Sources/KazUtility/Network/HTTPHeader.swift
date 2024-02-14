import Foundation

public struct HTTPHeader {
  
  let key: String
  let value: String
}

public struct HTTPHeaders {
  
  public typealias HeaderFields = [String: String]
  
  // MARK: - Property
  public var current: HeaderFields {
    var combined = HeaderFields()
    
    self.headers.forEach {
      combined.updateValue($0.value, forKey: $0.key)
    }
    
    return combined
  }
  
  private var headers: [HTTPHeader]
  
  // MARK: - Initializer
  public init() {
    self.headers = []
  }
  
  public init(_ headerList: [HTTPHeader]) {
    self.headers = headerList
  }
  
  public init(_ headerDictionary: [String: String]) {
    self.headers = headerDictionary.map { HTTPHeader(key: $0.key, value: $0.value) }
  }
  
  
  // MARK: - Method
  public mutating func update(_ header: HTTPHeader) {
    guard let index = headers.index(of: header.key) else {
      return self.add(header)
    }
    
    self.headers[index] = header
  }
  
  public mutating func update(key: String, value: String) {
    update(HTTPHeader(key: key, value: value))
  }
  
  public mutating func remove(key: String) {
    guard let index = headers.index(of: key) else { return }
    
    self.headers.remove(at: index)
  }
  
  private mutating func add(_ header: HTTPHeader) {
    self.headers.append(header)
  }
}

public extension HTTPHeaders {
  func header(_ header: HTTPHeader) -> Self {
    return self.headerAdded(header)
  }
  
  func header(key: String, value: String) -> Self {
    return self.headerAdded(HTTPHeader(key: key, value: value))
  }
  
  private func headerAdded(_ header: HTTPHeader) -> Self {
    var headers = self
    headers.update(header)
    
    return headers
  }
}

public extension Array where Element == HTTPHeader {
  func index(of key: String) -> Int? {
    return firstIndex { $0.key.lowercased() == key.lowercased() }
  }
}
