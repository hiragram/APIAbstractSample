//
//  ViewController.swift
//  RepositorySample
//
//  Created by Yuya Hirayama on 2017/08/05.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import UIKit
import RxSwift

private var cellIdentifier = "Cell"

class ViewController: UIViewController {

  @IBOutlet private weak var tableView: UITableView! {
    didSet {
      tableView.delegate = self
      tableView.dataSource = self
      tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
      vm.dataUpdated.subscribe(onNext: { [weak self] (_) in
        self?.tableView.reloadData()
      }).disposed(by: bag)
    }
  }

  fileprivate let vm = ViewModel.init()
  private let bag = DisposeBag.init()

  override func viewDidLoad() {
    super.viewDidLoad()

    vm.fetch.subscribe().disposed(by: bag)
  }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return vm.users?.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let user = vm.users?.dropFirst(indexPath.row).first else {
      fatalError()
    }

    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) else {
      fatalError()
    }
    cell.textLabel?.text = user.name

    return cell
  }
}
