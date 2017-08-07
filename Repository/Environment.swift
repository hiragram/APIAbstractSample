//
//  Environment.swift
//  RepositorySample
//
//  Created by Yuya Hirayama on 2017/08/07.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation

enum Environment {
  case production
  case staging
  case mock

  private var baseURL: String {
    switch self {
    case .production:
      return "https://prod.hoge.jp"
    case .staging:
      return "https://stg.hoge.jp"
    case .mock:
      return "https://mock.hoge.jp"
    }
  }

  func url(forPath path: String) -> URL {
    return URL.init(string: baseURL + path)!
  }
}
