import UIKit

public enum CoordinatorError: AppError {
  
  case unknownError(error: Error?)
  
  public var logDescription: String {
    switch self {
      case .unknownError(let error):
        return "알 수 없는 오류 발생 \(error?.localizedDescription ?? .defaultValue)"
    }
  }
  
  public var alertDescription: String {
    switch self {
      case .unknownError:
        return "알 수 없는 오류가 발생했어요. 문제가 지속되면 개발자에게 알려주세요."
    }
  }
}

public protocol CoordinatorDelegate: AnyObject {
  
  func coordinatorDidEnd(_ childCoordinator: Coordinator)
}

public protocol Coordinator: AnyObject {
  
  // MARK: - Property
  var navigationController: UINavigationController { get set }
  var delegate: CoordinatorDelegate? { get set }
  var childCoordinators: [Coordinator] { get set }
  
  
  // MARK: - Initialzier
  init(_ navigationController: UINavigationController)
  
  
  // MARK: - Method
  func start()
  func end()
  func push(_ viewController: UIViewController, animation: Bool)
  func pop(animation: Bool)
  func popToRoot(animation: Bool)
  func dismiss(animation: Bool)
  func emptyOut()
  func showErrorAlert(error: AppError)
  func showAlert(
    title: String,
    message: String,
    okTitle: String?,
    okStyle: UIAlertAction.Style,
    isCancelable: Bool,
    completion: (() -> Void)?
  )
}

// MARK: - View Navigation
public extension Coordinator {
  
  func end() {
    self.emptyOut()
    self.delegate?.coordinatorDidEnd(self)
  }
  
  func push(_ viewController: UIViewController, animation: Bool = true) {
    GCD.main {
      self.navigationController.pushViewController(viewController, animated: animation)
    }
  }
  
  func pop(animation: Bool = true) {
    GCD.main {
      self.navigationController.popViewController(animated: animation)
    }
  }
  
  func popToRoot(animation: Bool = true) {
    GCD.main {
      self.navigationController.popToRootViewController(animated: animation)
    }
  }
  
  func present(_ viewController: UIViewController, style: UIModalPresentationStyle = .automatic, animation: Bool = true) {
    viewController.modalPresentationStyle = style
    GCD.main {
      self.navigationController.present(viewController, animated: animation)
    }
  }
  
  func dismiss(animation: Bool = true) {
    GCD.main {
      self.navigationController.dismiss(animated: animation)
    }
  }
  
  func emptyOut() {
    self.childCoordinators.removeAll()
  }
  
  func showErrorAlert(error: Error) {
    guard let error = error as? AppError else {
      let coordinatorError = CoordinatorError.unknownError(error: error)
      LogManager.shared.log(with: coordinatorError, to: .local)
      showErrorAlert(error: coordinatorError)
      
      return
    }
    
    let alertController = UIAlertController(
      title: error.alertDescription,
      message: nil,
      preferredStyle: .alert
    )
      .setAction(title: "확인", style: .default)
    
    GCD.main {
      self.present(alertController)
    }
  }
  
  func showAlert(
    title: String,
    message: String,
    okTitle: String? = nil,
    okStyle: UIAlertAction.Style = .default,
    isCancelable: Bool = false,
    completion: (() -> Void)? = nil
  ) {
    var alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      .setAction(title: okTitle ?? "확인", style: okStyle, completion: completion)
      
    if isCancelable {
      alertController = alertController.setCancelAction()
    }
    
    GCD.main {
      self.present(alertController)
    }
  }
  
  func addChild(_ childCoordinator: Coordinator) {
    self.childCoordinators.append(childCoordinator)
  }
}
