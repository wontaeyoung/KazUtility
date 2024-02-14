public protocol ViewModelController {
  associatedtype ViewModelType = ViewModel
  
  var viewModel: ViewModelType { get }
}
