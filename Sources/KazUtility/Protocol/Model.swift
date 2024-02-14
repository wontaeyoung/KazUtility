public protocol DTO: DefaultValueProvidable {
  associatedtype EntityType: Entity
  
  func toEntity() -> EntityType
}

public protocol Entity { }
