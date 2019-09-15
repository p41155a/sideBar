//
//  FrontViewController.swift
//  SideBarDIY
//
//  Created by MC975-107 on 15/09/2019.
//  Copyright © 2019 comso. All rights reserved.
//

import UIKit

class FrontViewController: UIViewController {
    // 사이드 바 오픈 기능을 위임할 델리게이트
    var delegate: RevealViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        // 사이드 바 오픈용 버튼 정의
        let btnSideBar = UIBarButtonItem(image: UIImage(named: "sidemenu.png"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(moveSide))
        // 버튼을 내비게이션 바의 왼쪽 영역에 추가
        self.navigationItem.leftBarButtonItem = btnSideBar
        // 제스처 정의 (사이드 바 열기)
        let dragLeft = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(moveSide(_:)))
        dragLeft.edges = UIRectEdge.left // 시작 모서리 왼쪽으로
        self.view.addGestureRecognizer(dragLeft) // 뷰에 제스처 객체를 등록
        // 제스처 정의 (사이드 바 닫기)
        let dragRight = UISwipeGestureRecognizer(target: self, action: #selector(moveSide(_:)))
        dragRight.direction = .left  // 인식할 방향은 왼쪽
        self.view.addGestureRecognizer(dragRight) // 뷰에 제스처 객체를 등록
    }
    // 사용자의 액션에 따라 델리게이트 메소드를 호출한다.
    @objc func moveSide(_ sender: Any) {
        if sender is UIScreenEdgePanGestureRecognizer {
            self.delegate?.openSideBar(nil)
        } else if sender is UISwipeGestureRecognizer {
            self.delegate?.closeSideBar(nil)
        } else if sender is UIBarButtonItem {
            if self.delegate?.isSideBarShowing == false {
                self.delegate?.openSideBar(nil) // 사이드 바 열기
            } else {
                self.delegate?.closeSideBar(nil) // 사이드 바 닫기
            }
        }
    }
}
