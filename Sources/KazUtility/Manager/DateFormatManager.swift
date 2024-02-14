import Foundation

public final class DateFormatManager {
  
  public static let shared = DateFormatManager()
  private init() { }
  
  private let locale = Locale(identifier: "ko_KR")
  private lazy var formatter = DateFormatter().configured { $0.locale = locale }
  private lazy var calendar = Calendar.current.configured { $0.locale = locale }
  
  public func unixTimestampToString(with interval: TimeInterval, format: Format) -> String {
    formatter.dateFormat = format.format
    formatter.timeZone = .current
    
    return formatter.string(from: Date(timeIntervalSince1970: interval))
  }
  
  public func isDate(with interval: TimeInterval, by component: Calendar.Component, equalTo: Int) -> Bool {
    return calendar.component(component, from: Date(timeIntervalSince1970: interval)) == equalTo
  }
}

public extension DateFormatManager {
  
  enum Format: String {
    case HHmm = "HH:mm"
    case HHhour = "HH시"
    case EEEE = "EEEE"
    
    var format: String {
      return self.rawValue
    }
  }
}
