//
//  ViewModel.swift
//  RepositorySample
//
//  Created by Yuya Hirayama on 2017/08/07.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation
import Model
import RxSwift
import Repository

final class ViewModel {
  private let _users = Variable<[User]?>.init(nil)
  var users: [User]? {
    return _users.value
  }

  var fetch: Completable {
    return Repository.followingUsers()
      .do(onNext: { [weak self] (users) in
        self?._users.value = .some(users)
      })
      .asObservable()
      .flatMap { _ in Observable<Never>.empty() }
      .asCompletable()
  }

  var dataUpdated: Observable<Void> {
    return _users.asObservable().map { _ in () }
  }
}
