public protocol ViewModelController: AnyObject {
  associatedtype ViewModelType = ViewModel
  
  var viewModel: ViewModelType { get }
}
