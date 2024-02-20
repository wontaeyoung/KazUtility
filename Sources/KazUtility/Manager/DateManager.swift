import Foundation

public final class DateManager {
  
  public static let shared = DateManager()
  private init() { }
  
  private let locale = Locale(identifier: "ko_KR")
  private let timezone = TimeZone(identifier: "ko_KR")
  
  private lazy var formatter = DateFormatter().configured {
    $0.locale = locale
    $0.timeZone = timezone ?? .autoupdatingCurrent
  }
  
  private lazy var calendar = Calendar.current.configured {
    $0.locale = locale
    $0.timeZone = timezone ?? .autoupdatingCurrent
  }
}

public extension DateManager {
  
  enum Format: String {
    case HHmm = "HH:mm"
    case HHhour = "HH시"
    case EEEE = "EEEE"
    case yyyyMMdd = "yyyyMMdd"
    
    var format: String {
      return self.rawValue
    }
  }
}

// MARK: - String Format
public extension DateManager {
  
  func toString(with date: Date, format: Format) -> String {
    formatter.dateFormat = format.format
    formatter.timeZone = timezone
    
    return formatter.string(from: date)
  }
  
  func toString(with date: Date, formatString: String) -> String {
    formatter.dateFormat = formatString
    formatter.timeZone = timezone
    
    return formatter.string(from: date)
  }
  
  func unixTimestampToString(with interval: TimeInterval, format: Format) -> String {
    formatter.dateFormat = format.format
    formatter.timeZone = .current
    
    return formatter.string(from: Date(timeIntervalSince1970: interval))
  }
}

// MARK: - Compare Date
public extension DateManager {
  
  func getDateBetween(when date: Date, by day: Int = 1) -> (start: Date, end: Date) {
    let start = calendar.startOfDay(for: date)
    let end = calendar.date(byAdding: .day, value: day, to: start) ?? Date()
    
    return (start, end)
  }
}

// MARK: - Compare Date
public extension DateManager {
  
  func isDate(with interval: TimeInterval, by component: Calendar.Component, equalTo: Int) -> Bool {
    return calendar.component(component, from: Date(timeIntervalSince1970: interval)) == equalTo
  }
  
  func isDate(with date: Date, by component: Calendar.Component, equalTo: Int) -> Bool {
    return calendar.component(component, from: date) == equalTo
  }
  
  func isDate(with date: Date, by component: Calendar.Component..., equalTo: Int...) -> Bool {
    let min = min(component.count, equalTo.count)
    
    return !(0..<min)
      .map { calendar.component(component[$0], from: date) == equalTo[$0] }
      .contains(false)
  }
}
