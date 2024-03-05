public protocol ViewModel: AnyObject {
  
  associatedtype CoordinatorType: Coordinator
  associatedtype Input
  associatedtype Output
  
  var input: Input { get set }
  var output: Output { get set }
  var coordinator: CoordinatorType? { get set }
  
  func transform()
}
