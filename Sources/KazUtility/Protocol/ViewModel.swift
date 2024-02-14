public protocol ViewModel {
  associatedtype CoordinatorType: Coordinator
  
  var coordinator: CoordinatorType? { get set }
}
