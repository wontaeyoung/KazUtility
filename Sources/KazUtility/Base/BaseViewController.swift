import UIKit

open class BaseViewController: UIViewController {
  
  // MARK: - Property
  final public var finishableKeyboardEditing: Bool
  
  
  // MARK: - Initializer
  public init(finishableKeyboardEditing: Bool = false) {
    self.finishableKeyboardEditing = finishableKeyboardEditing
    
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - Life Cycle
  open func setHierarchy() { }
  open func setAttribute() { }
  open func setConstraint() { }
  open func bind() { }
  
  open override func viewDidLoad() {
    
    super.viewDidLoad()
    
    view.backgroundColor = .systemBackground
    
    setHierarchy()
    setAttribute()
    setConstraint()
    bind()
    makeViewFinishableEditing()
  }
  
  
  // MARK: - Method
  final private func makeViewFinishableEditing() {
    let gesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
    gesture.cancelsTouchesInView = false
    view.addGestureRecognizer(gesture)
  }
  
  @objc final private func viewDidTap(_ sender: UIGestureRecognizer) {
    if finishableKeyboardEditing { view.endEditing(true) }
  }
}
