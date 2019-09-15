//
//  SideBarViewController.swift
//  SideBarDIY
//
//  Created by MC975-107 on 15/09/2019.
//  Copyright © 2019 comso. All rights reserved.
//

import UIKit

class SideBarViewController: UITableViewController {
    let titles = [
        "메뉴 01",
        "메뉴 02",
        "메뉴 03",
        "메뉴 04",
        "메뉴 05"
    ]
    let icons = [UIImage(named: "icon01"),
                 UIImage(named: "icon02"),
                 UIImage(named: "icon03"),
                 UIImage(named: "icon04"),
                 UIImage(named: "icon05")]
    override func viewDidLoad() {
        super.viewDidLoad()
        // 계정 표시할 레이블
        let accountLabel = UILabel()
        accountLabel.frame = CGRect(x: 10, y: 30, width: self.view.frame.width, height: 30)
        accountLabel.text = "p41155a@naver.com"
        accountLabel.textColor = .white
        accountLabel.font = UIFont.boldSystemFont(ofSize: 15)
        // 테이블 뷰 상단 뷰 정의
        let v = UIView()
        v.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70)
        v.backgroundColor = .brown
        v.addSubview(accountLabel)
        // 테이블 뷰 헤더 뷰 영역에 등록
        self.tableView.tableHeaderView = v
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 재사용 큐로부터 테이블 셀을 꺼내 온다.
        let id = "menucell" // 재사용 큐에 등록할 식별자
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
        // 재사용 큐에 menucell키로 등록된 테이블 뷰 셀이 없다면 새로 추가한다.
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.imageView?.image = self.icons[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        return cell
    }

}
