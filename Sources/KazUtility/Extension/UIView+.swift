import UIKit

public extension UIView {
  func addSubviews(_ view: UIView...) {
    view.forEach { self.addSubview($0) }
  }
}

