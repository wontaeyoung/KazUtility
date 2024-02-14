import UIKit

public extension UIViewController {
  func hideBackTitle() -> Self {
    self.navigationItem.backButtonTitle = ""
    return self
  }
  
  func navigationTitle(with title: String) -> Self {
    self.navigationItem.title = title
    return self
  }
}
