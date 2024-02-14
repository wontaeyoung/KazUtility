public final class Bindable<T> {
  
  typealias Completion = (T) -> Void
  typealias Action = (thread: Thread, completion: Completion)
  
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
  func set(_ value: T) {
    self.value = value
  }
  
  func subscribe(thread: Thread = .main, completion: @escaping Completion) {
    completion(value)
    self.action = (thread, completion)
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
