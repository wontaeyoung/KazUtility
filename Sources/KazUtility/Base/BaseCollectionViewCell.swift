import UIKit

open class BaseCollectionViewCell: UICollectionViewCell {
  
  public class var identifier: String {
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
  
  @available(*, unavailable)
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

