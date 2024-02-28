public protocol ViewModel: AnyObject {
  
  associatedtype CoordinatorType: Coordinator
  associatedtype Input
  associatedtype Output
  
  var coordinator: CoordinatorType? { get set }
  
  func transform()
}
