import UIKit

open class BaseTableViewCell: UITableViewCell {
  
  open class var identifier: String {
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
  
  deinit {
    LogManager.shared.log(with: Self.identifier, to: .local, level: .debug)
  }
  
  @available(*, unavailable)
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
