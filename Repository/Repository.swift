//
//  Repository.swift
//  RepositorySample
//
//  Created by Yuya Hirayama on 2017/08/07.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation
import RxSwift
import Model
import APIKit
import Result

public struct Repository {
  fileprivate static func request<Endpoint: EndpointDefinition>(_ endpoint: Endpoint) -> Single<Endpoint.Response.Result> {
    return Single.create(subscribe: { (observer) -> Disposable in
      let request = GenericRequest.init(endpoint: endpoint)
      let task = Session.send(request, callbackQueue: nil, handler: { (result) in
        switch result {
        case .success(let response):
          observer(.success(response))
        case .failure(let error):
          observer(.error(error))
        }
      })

      return Disposables.create {
        task?.cancel()
      }
    })
  }
}

public extension Repository {
  static func followingUsers() -> Single<[User]> {
    let endpoint = Endpoint.FollowingUsers.init()
    return request(endpoint)
  }
}
