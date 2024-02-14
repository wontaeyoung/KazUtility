//
//  NetworkManager.swift
//  KazWeather
//
//  Created by 원태영 on 2/9/24.
//

import Foundation

public final class HTTPClient {
  
  // MARK: - Singleton
  public static let shared = HTTPClient()
  private init() { }
  
  // MARK: - Method
  public func callRequest<T: DTO>(
    responseType: T.Type,
    router: any Router
  ) async -> Result<T.EntityType, HTTPError> {
    
    let successStatusRange = 200...299
    
    guard let request = try? router.asURLRequest() else {
      return .failure(.invalidURL)
    }
    
    guard let (data, response) = try? await URLSession.shared.data(for: request) else {
      return .failure(.requestFailed)
    }
    
    guard let response = response as? HTTPURLResponse else {
      return .failure(.invalidResponse)
    }
    
    guard successStatusRange ~= response.statusCode else {
      return .failure(.unexceptedResponse(status: response.statusCode))
    }
    
    guard let result = try? JsonCoder.shared.decode(to: responseType, from: data) else {
      return .failure(.dataDecodingFailed)
    }
    
    let entity = result.toEntity()
    return .success(entity)
  }
}

