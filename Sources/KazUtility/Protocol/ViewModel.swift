public protocol ViewModel: AnyObject {
  associatedtype CoordinatorType: Coordinator
  
  var coordinator: CoordinatorType? { get set }
}
