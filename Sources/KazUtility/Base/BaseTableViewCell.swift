import UIKit

open class BaseTableViewCell: UITableViewCell {
  
  public class var identifier: String {
    return self.description()
  }
  
  open func setHierarchy() { }
  open func setAttribute() { }
  open func setConstraint() { }
  
  public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
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
