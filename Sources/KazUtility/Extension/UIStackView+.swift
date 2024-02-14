import UIKit

public extension UIStackView {
  func clear() {
    self.arrangedSubviews.forEach {
      self.removeArrangedSubview($0)
      $0.removeFromSuperview()
    }
  }
  
  func addArrangedSubviews(_ view: UIView...) {
    view.forEach {
      self.addArrangedSubview($0)
    }
  }
}
