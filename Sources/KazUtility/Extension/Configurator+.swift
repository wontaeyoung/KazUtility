import UIKit

public protocol Configurator { }

public extension Configurator where Self: Any {
  
  mutating func configure(_ apply: (inout Self) -> Void) {
    apply(&self)
  }
  
  func configured(_ apply: (inout Self) -> Void) -> Self {
    var configurableSelf = self
    apply(&configurableSelf)
    
    return configurableSelf
  }
}

public extension Configurator where Self: AnyObject {
  
  func configure(_ apply: (Self) -> Void) {
    apply(self)
  }
  
  func configured(_ apply: (Self) -> Void) -> Self {
    apply(self)
    return self
  }
}

extension NSObject: Configurator { }
extension Array: Configurator { }
extension Dictionary: Configurator { }
extension Set: Configurator { }

@available(iOS 15.0, *)
extension UIButton.Configuration: Configurator { }
extension URLRequest: Configurator { }

extension HTTPHeader: Configurator { }
extension HTTPHeaders: Configurator { }
extension HTTPParameter: Configurator { }
extension HTTPParameters: Configurator { }

extension Calendar: Configurator { }

extension UIListContentConfiguration: Configurator { }
extension UICollectionLayoutListConfiguration: Configurator { }
extension UIBackgroundConfiguration: Configurator { }
