import UIKit

open class BaseViewController: UIViewController {
  
  open class var identifier: String {
    return self.description()
  }
  
  // MARK: - Property
  public final var finishableKeyboardEditing: Bool
  
  // MARK: - Initializer
  public init(finishableKeyboardEditing: Bool = false) {
    self.finishableKeyboardEditing = finishableKeyboardEditing
    
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    LogManager.shared.log(with: Self.identifier, to: .local, level: .debug)
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
    
    if finishableKeyboardEditing { makeViewFinishableEditing() }
  }
  
  
  // MARK: - Method
  private final func makeViewFinishableEditing() {
    let gesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
    gesture.cancelsTouchesInView = false
    view.addGestureRecognizer(gesture)
  }
  
  @objc private final func viewDidTap(_ sender: UIGestureRecognizer) {
    view.endEditing(true)
  }
}
