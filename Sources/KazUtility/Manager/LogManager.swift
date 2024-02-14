import Foundation
import os

@available(iOS 14.0, *)
public final class LogManager {
  
  public enum LogCategory: String {
    case network = "Network"
    case local = "Local"
    
    public static let bundleID: String = Bundle.main.bundleIdentifier ?? ""
    
    public var category: String {
      return self.rawValue
    }
  }
  
  // MARK: - Singleton
  public static let shared = LogManager()
  private init() { }
  
  
  // MARK: - Property
  private lazy var networkLogger = Logger(subsystem: LogCategory.bundleID, category: LogCategory.network.category)
  private lazy var localLogger = Logger(subsystem: LogCategory.bundleID, category: LogCategory.local.category)
  
  public func log(with error: AppError, to logTarget: LogCategory, level: OSLogType = .error) {
    let message = error.logDescription
        
    switch logTarget {
      case .network:
        networkLogger.log(level: level, "\(message)")
        
      case .local:
        localLogger.log(level: level, "\(message)")
    }
  }
}