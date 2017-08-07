//
//  Response.swift
//  RepositorySample
//
//  Created by Yuya Hirayama on 2017/08/07.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation
import Himotoki

protocol ResponseDefinition {
  associatedtype Result

  var result: Result { get }

  init(json: Any) throws
}

struct SingleResponse<T: Decodable>: ResponseDefinition {
  typealias Result = T

  let result: Result

  init(json: Any) throws {
    result = try decodeValue(json)
  }
}

struct ArrayResponse<T: Decodable>: ResponseDefinition {
  typealias Result = [T]

  let result: Result

  init(json: Any) throws {
    result = try decodeArray(json)
  }
}

struct EmptyResponse: ResponseDefinition {
  typealias Result = Void

  let result: Result

  init(json: Any) throws {
    result = ()
  }
}
