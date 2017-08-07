//
//  Endpoint.swift
//  RepositorySample
//
//  Created by Yuya Hirayama on 2017/08/05.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation
import Himotoki
import Model
import APIKit

struct Endpoint {

  struct FollowingUsers: EndpointDefinition {
    typealias Response = ArrayResponse<User>
    static var path: String = "/user/following"
    var method: HTTPMethod = .get
  }
  
}

protocol EndpointDefinition {
  associatedtype Response: ResponseDefinition

  static var path: String { get }
  static var environment: Environment { get }

  var parameters: [String: Any] { get }
  var method: HTTPMethod { get }
}

extension EndpointDefinition {
  static var environment: Environment {
    return .production
  }

  var parameters: [String: Any] {
    return [:]
  }
}
