import UIKit

public extension UINavigationController {
  
  func navigationLargeTitleEnabled() -> Self {
    self.navigationBar.prefersLargeTitles = true
    
    return self
  }
  
  func navigationBarHidden() -> Self {
    self.setNavigationBarHidden(true, animated: false)
    
    return self
  }
}
