import UIKit

public extension String {
  
  static func combineWithLineBreaks(_ strings: String...) -> Self {
    return strings.joined(separator: "\n")
  }
  
  var asMarkdownRedneredAttributeString: NSAttributedString? {
    guard let data = self.data(using: .utf8) else {
      return nil
    }
    
    let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
      .documentType: NSAttributedString.DocumentType.html,
      .characterEncoding: String.Encoding.utf8.rawValue
    ]
    
    return try? NSAttributedString(data: data, options: options, documentAttributes: nil)
  }
  
  func colorAttributed(rangeText: String, color: UIColor) -> NSAttributedString {
    let attributedString = NSMutableAttributedString(string: self)
    
    attributedString.addAttribute(
      .foregroundColor,
      value: color,
      range: (self as NSString).range(of: rangeText)
    )
    
    return attributedString
  }
  
  var dollorToRounded: String {
    guard self.prefix(1) == "$" else { return self }
    guard let currency = Double(self.dropFirst()) else { return self}
    
    return "$" + currency.toRoundedDollar
  }
}
