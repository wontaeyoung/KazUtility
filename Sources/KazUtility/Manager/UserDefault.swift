import Foundation

@propertyWrapper
public struct UserDefault<T: Codable> {
  
  private let key: any UserDefaultKey
  private let defaultValue: T
  private let userDefault: UserDefaults
  
  public init(
    key: any UserDefaultKey,
    defaultValue: T,
    userDefault: UserDefaults = .standard
  ) {
    self.key = key
    self.defaultValue = defaultValue
    self.userDefault = userDefault
  }
  
  public var wrappedValue: T {
    get {
      guard
        let data = userDefault.data(forKey: key.name),
        let value = try? JsonCoder.shared.decode(to: T.self, from: data)
      else {
        return defaultValue
      }
      
      return value
    }
    set {
      let data: Data? = try? JsonCoder.shared.encode(from: newValue)
      
      userDefault.setValue(data, forKey: key.name)
    }
  }
}

public protocol UserDefaultKey where Self: RawRepresentable, Self.RawValue == String {
  var name: String { get }
}

public extension UserDefaultKey {
  var name: String {
    return self.rawValue
  }
}
