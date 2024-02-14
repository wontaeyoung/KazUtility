import UIKit

public extension UIViewController {
  func hideBackTitle() -> Self {
    self.navigationItem.backButtonTitle = ""
    return self
  }
  
  func navigationTitle(with title: String, displayMode: UINavigationItem.LargeTitleDisplayMode) -> Self {
    self.navigationItem.title = title
    self.navigationItem.largeTitleDisplayMode = displayMode
    return self
  }
}
