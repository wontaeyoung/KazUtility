import Foundation

public struct HTTPParameter {
  
  public typealias Value = any CustomStringConvertible
  
  public let key: String
  public let value: Value
  
  public var queryItem: URLQueryItem {
    return URLQueryItem(name: key, value: value.description)
  }
}

public struct HTTPParameters {
  
  // MARK: - Property
  public var current: [URLQueryItem] {
    return self.parameters.map { $0.queryItem }
  }
  
  private var parameters: [HTTPParameter]
  
  // MARK: - Initializer
  public init() {
    self.parameters = []
  }
  
  public init(_ parameter: HTTPParameter) {
    self.parameters = [parameter]
  }
  
  public init(_ parameterList: [HTTPParameter]) {
    self.parameters = parameterList
  }
  
  public init(_ parameterDictionary: [String: HTTPParameter.Value]) {
    self.parameters = parameterDictionary.map { HTTPParameter(key: $0.key, value: $0.value) }
  }
  
  
  // MARK: - Method
  public mutating func update(_ parameter: HTTPParameter) {
    guard let index = parameters.index(of: parameter.key) else {
      self.add(parameter)
      return
    }
    
    self.parameters[index] = parameter
  }
  
  public mutating func update(key: String, value: HTTPParameter.Value) {
    update(HTTPParameter(key: key, value: value))
  }
  
  public mutating func remove(key: String) {
    guard let index = parameters.index(of: key) else { return }
    
    self.parameters.remove(at: index)
  }
  
  private mutating func add(_ parameter: HTTPParameter) {
    self.parameters.append(parameter)
  }
}

// MARK: - Funtional Stream
public extension HTTPParameters {
  func parameter(_ parameter: HTTPParameter) -> Self {
    return self.parameterAdded(parameter)
  }
  
  func parameter(key: String, value: HTTPParameter.Value) -> Self {
    return self.parameterAdded(HTTPParameter(key: key, value: value))
  }
  
  private func parameterAdded(_ parameter: HTTPParameter) -> Self {
    var parameters = self
    parameters.update(parameter)
    
    return parameters
  }
}

public extension Array where Element == HTTPParameter {
  func index(of key: String) -> Int? {
    return firstIndex { $0.key.lowercased() == key.lowercased() }
  }
}
