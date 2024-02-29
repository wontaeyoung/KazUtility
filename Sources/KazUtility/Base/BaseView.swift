import UIKit

open class BaseView: UIView {
  
  open class var identifier: String {
    return self.description()
  }
  
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
  
  deinit {
    LogManager.shared.log(with: Self.identifier, to: .local, level: .debug)
  }
  
  // MARK: - Method
  open func setHierarchy() { }
  open func setAttribute() { }
  open func setConstraint() { }
}
