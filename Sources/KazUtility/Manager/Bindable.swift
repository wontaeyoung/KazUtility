public final class Bindable<T> {
  
  public typealias Completion = (T) -> Void
  public typealias Action = (thread: Thread, completion: Completion)
  
  public enum Thread {
    case main
    case global
  }
  
  // MARK: - Property
  private var value: T {
    didSet {
      guard let action else { return }
      
      switch action.thread {
        case .main:
          GCD.main { [weak self] in
            guard let self else { return }
            
            action.completion(value)
          }
          
        case .global:
          GCD.global { [weak self] in
            guard let self else { return }
            
            action.completion(value)
          }
      }
    }
  }
  
  public var current: T {
    return self.value
  }
  
  private var action: Action?
  
  
  // MARK: - Initializer
  public init(value: T) {
    self.value = value
  }
  
  
  // MARK: - Method
  public func set(_ value: T) {
    self.value = value
  }
  
  public func subscribe(thread: Thread = .main, completion: @escaping Completion) {
    completion(value)
    self.action = (thread, completion)
  }
}

public extension Bindable where T == Array<Entity> {
  func append(_ element: T.Element) {
    self.value.append(element)
  }
  
  func remove(at index: Int) {
    self.value.remove(at: index)
  }
  
  func update(_ element: T.Element, at index: Int) {
    guard self.value.indices ~= index else { return }
    
    self.value[index] = element
  }
  
  func element(at index: Int) -> T.Element? {
    guard self.value.indices ~= index else { return nil }
    
    return self.value[index]
  }
}

public extension Bindable where T == Dictionary<String, Entity> {
  func update(key: T.Key, value: T.Value) {
    self.value.updateValue(value, forKey: key)
  }
  
  func remove(key: T.Key) {
    self.value.removeValue(forKey: key)
  }
  
  func get(key: T.Key) -> T.Value? {
    guard let value = self.value[key] else { return nil }
    
    return value
  }
}

extension Bindable: ExpressibleByIntegerLiteral where T == Int {
  public convenience init(integerLiteral value: Int) {
    self.init(value: value)
  }
}

extension Bindable: ExpressibleByFloatLiteral where T == Double {
  public convenience init(floatLiteral value: Double) {
    self.init(value: value)
  }
}

extension Bindable: ExpressibleByBooleanLiteral where T == Bool {
  public convenience init(booleanLiteral value: Bool) {
    self.init(value: value)
  }
}

extension Bindable: ExpressibleByStringLiteral where T == String {
  public convenience init(stringLiteral value: String) {
    self.init(value: value)
  }
}

extension Bindable: ExpressibleByUnicodeScalarLiteral where T == String {
  public convenience init(unicodeScalarLiteral value: String) {
    self.init(value: value)
  }
}

extension Bindable: ExpressibleByExtendedGraphemeClusterLiteral where T == String {
  public convenience init(extendedGraphemeClusterLiteral value: String) {
    self.init(value: value)
  }
}
