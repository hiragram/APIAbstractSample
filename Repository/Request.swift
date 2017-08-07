//
//  Request.swift
//  RepositorySample
//
//  Created by Yuya Hirayama on 2017/08/07.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation
import APIKit
import Himotoki

struct GenericRequest<Endpoint: EndpointDefinition>: Request {
  typealias Response = Endpoint.Response.Result
  var baseURL: URL = Endpoint.environment.url(forPath: "/")

  var path = Endpoint.path

  var parameters: Any?
  var method: HTTPMethod

  init(endpoint: Endpoint) {
    parameters = endpoint.parameters
    method = endpoint.method
  }

  func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Endpoint.Response.Result {
    guard let jsonDict = object as? [String: Any] else {
      fatalError()
    }
    guard let results = jsonDict["results"] as? [Any] else {
      fatalError()
    }
    return try Endpoint.Response.init(json: results).result
  }
}
