import Foundation

public final class NotificationManager {
  
  public static let shared = NotificationManager()
  private init() { }
  
  private let center = NotificationCenter.default
  private var observers: [ObjectIdentifier: NSObjectProtocol] = [:]
  
  public func add(
    _ observer: AnyObject,
    key: any NotificationNameKey,
    target: Any? = nil,
    action: @escaping (Notification) -> Void
  ) {
    let identifier = ObjectIdentifier(observer)
    let notificationName = NSNotification.Name(key.name)
    
    let token = center.addObserver(forName: notificationName, object: target, queue: nil) { notification in
      action(notification)
    }
    
    observers.updateValue(token, forKey: identifier)
  }
  
  public func remove(_ observer: AnyObject) {
    let identifier = ObjectIdentifier(observer)
    
    guard let token = observers[identifier] else {
      LogManager.shared.log(with: NotificationError.tokenNotFound(identifier: identifier), to: .local)
      return
    }
    
    observers.removeValue(forKey: identifier)
    center.removeObserver(token)
  }
  
  public func post(
    key: any NotificationNameKey,
    from sender: Any? = nil,
    with notificationInfo: [any NotificationInfoKey]? = nil
  ) {
    let notificationName = NSNotification.Name(key.name)
    var userInfo: [String: Any] = [:]
    
    notificationInfo?.forEach {
      userInfo.updateValue($0.item.value, forKey: $0.item.key)
    }
    
    center.post(name: notificationName, object: sender, userInfo: userInfo)
  }
}

public protocol NotificationNameKey where Self: RawRepresentable, Self.RawValue == String {
  var name: String { get }
}

public extension NotificationNameKey {
  var name: String {
    return self.rawValue
  }
}

public protocol NotificationInfoKey {
  
  var item: (key: String, value: Any) { get }
}

public enum NotificationError: AppError {
  case tokenNotFound(identifier: ObjectIdentifier)
  
  public var logDescription: String {
    switch self {
      case let .tokenNotFound(identifier):
        return "식별자에 해당하는 옵저버 토큰을 찾을 수 없습니다.\n식별자 : \(identifier.debugDescription)"
    }
  }
  
  public var alertDescription: String {
    return ""
  }
}
