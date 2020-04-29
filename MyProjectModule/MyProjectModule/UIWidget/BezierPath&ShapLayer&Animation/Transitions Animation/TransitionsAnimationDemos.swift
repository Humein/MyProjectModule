//
//  TransitionsAnimationDemos.swift
//  MyProjectModule
//
//  Created by XinXin on 2020/4/29.
//  Copyright © 2020 xinxin. All rights reserved.
//

import UIKit

class TransitionsAnimationDemos: UIViewController {
    lazy var listView: UITableView = {
        let tableView = UITableView.init(frame: self.view.frame, style:.plain)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "UITableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    fileprivate let items = ["SDPresentAViewController","SDPushAViewController","TabTransition"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(listView)
    }

}

extension TransitionsAnimationDemos: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
      return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.textColor  = .black
        cell.textLabel?.text = items[(indexPath as NSIndexPath).row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = items[(indexPath as NSIndexPath).row]
        if let vc = str.stringChangeToVC(){
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

