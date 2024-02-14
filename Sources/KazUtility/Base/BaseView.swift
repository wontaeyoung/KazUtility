import UIKit

open class BaseView: UIView {
  
  // MARK: - Initializer
  public override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.backgroundColor = .clear
    
    setHierarchy()
    setAttribute()
    setConstraint()
  }
  
  @available(*, unavailable)
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) BaseView")
  }
  
  // MARK: - Method
  open func setHierarchy() { }
  open func setAttribute() { }
  open func setConstraint() { }
}
