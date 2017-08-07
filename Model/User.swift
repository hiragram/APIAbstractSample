//
//  User.swift
//  RepositorySample
//
//  Created by Yuya Hirayama on 2017/08/05.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation
import Himotoki

public struct User: Decodable {
  var id: Int
  var name: String

  public static func decode(_ e: Extractor) throws -> User {
    return try User.init(
      id: e <| "id",
      name: e <| "name"
    )
  }
}
