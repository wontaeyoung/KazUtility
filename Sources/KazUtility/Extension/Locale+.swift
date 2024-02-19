import Foundation

extension Locale {
  enum Identifier: String {
    case kr = "ko_KR"
    case us = "en_US"
    
    var code: String {
      return self.rawValue
    }
  }
  
  static let kr = Locale(identifier: Identifier.kr.code)
  static let us = Locale(identifier: Identifier.us.code)
}
