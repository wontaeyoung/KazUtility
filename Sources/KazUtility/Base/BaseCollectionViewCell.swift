import UIKit

open class BaseCollectionViewCell: UICollectionViewCell {
  
  open class var identifier: String {
    return self.description()
  }
  
  open func setHierarchy() { }
  open func setAttribute() { }
  open func setConstraint() { }
  
  public override init(frame: CGRect) {
    
    super.init(frame: frame)
    
    backgroundColor = .clear
    contentView.backgroundColor = .clear
    
    setHierarchy()
    setAttribute()
    setConstraint()
  }
  
  deinit {
    LogManager.shared.log(with: Self.identifier, to: .local, level: .debug)
  }
  
  @available(*, unavailable)
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

