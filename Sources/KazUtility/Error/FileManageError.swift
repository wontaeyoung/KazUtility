enum FileManageError: AppError {
  
  static let contactDeveloperMessage: String = "문제가 지속되면 개발자에게 문의해주세요."
  
  case imageToDataFailed
  case writeDataFailed(error: Error)
  case createDirectoryFailed(error: Error)
  
  var logDescription: String {
    switch self {
      case .imageToDataFailed:
        return "파일 시스템 : 이미지 데이터 변환 실패"
        
      case .writeDataFailed(let error):
        return "파일 시스템 : 데이터 쓰기 실패 \(error.localizedDescription)"
        
      case .createDirectoryFailed(let error):
        return "파일 시스템 : 디렉토리 생성 실패 \(error.localizedDescription)"
    }
  }
  
  var alertDescription: String {
    switch self {
      case .imageToDataFailed:
        return "이미지 저장에 실패했어요. \(Self.contactDeveloperMessage)"
        
      case .writeDataFailed:
        return "데이터 저장에 실패했어요. \(Self.contactDeveloperMessage)"
        
      case .createDirectoryFailed:
        return "폴더를 만들지 못했어요. \(Self.contactDeveloperMessage)"
    }
  }
}
