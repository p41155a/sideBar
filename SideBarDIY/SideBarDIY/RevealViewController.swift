//
//  RevealViewController.swift
//  SideBarDIY
//
//  Created by MC975-107 on 15/09/2019.
//  Copyright © 2019 comso. All rights reserved.
//

import UIKit

class RevealViewController: UIViewController {
    var contentVC: UIViewController?// 콘텐츠를 담당할 뷰 컨트롤러
    var sideVC: UIViewController?   // 사이드 바를 담당할 뷰 컨트롤러
    var isSideBarShowing = false    // 사이드 바가 열려 있는지 여부
    let SLIDE_TIME = 0.3            // 사이드 바 열고 닫는데 거리는 시간
    let SIDEBAR_WIDTH: CGFloat = 260// 사이드 바 너비
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
    }
    // 초기 화면 설정
    func setupView() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_front") as? UINavigationController {
            self.contentVC = vc // 읽어온 컨트롤러를 클래스 전체에서 참조할 수 있도록 contentVC 속성에 저장한다.
            self.addChild(vc) // _프론트 컨트롤러를 메인 컨트롤러의 자식 뷰 컨트롤러로 등록
            // 프론트 컨트롤러의 델리게이트 변수에 참조 정보를 넣어준다
            let frontVC = vc.viewControllers[0] as? FrontViewController
            frontVC?.delegate = self
            self.view.addSubview(vc.view)
            vc.didMove(toParent: self) // _프론트 컨트럴로엣 부모 뷰 컨트롤러가 바뀌었음을 알려준다.
        }
    }
    
    // 사이드 바의 뷰를 읽어옴
    func getSideView() {
        if self.sideVC == nil {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_rear") {
                self.sideVC = vc
                self.addChild(vc)
                self.view.addSubview(vc.view)
                vc.didMove(toParent: self)
                self.view.bringSubviewToFront((self.contentVC?.view)!) // _프론트 컨트롤러의 뷰를 제일 위로 올린다.
            }
        }
        
    }
    
    // 콘텐츠 뷰에 그림자 효과를 줌
    func setShadowEffect(shadow: Bool, offset: CGFloat) {
        if(shadow) {
            self.contentVC?.view.layer.cornerRadius = 10
            self.contentVC?.view.layer.shadowOpacity = 0.8 // 그림자 투명도
            self.contentVC?.view.layer.shadowColor = UIColor.black.cgColor
            self.contentVC?.view.layer.shadowOffset = CGSize(width: offset, height: offset) //그림자 크기
        } else {
            self.contentVC?.view.layer.cornerRadius = 0.0
            self.contentVC?.view.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
    }
    
    // 사이드 바를 염
    func openSideBar(_ complete: ( () -> Void)? ) {
        self.getSideView() // 사이드 바 뷰를 읽어옴
        self.setShadowEffect(shadow: true, offset: -2) // 그림자 효과를 줌
        // 애니메이션 옵션
        let options = UIView.AnimationOptions(arrayLiteral: [.curveEaseInOut, .beginFromCurrentState])
        // 애니메이션 실행
        UIView.animate(
            withDuration: TimeInterval(self.SLIDE_TIME), // 애니메이션 실행시간
            delay: TimeInterval(0),
            options: options,
            animations: {
                self.contentVC?.view.frame = CGRect(x: self.SIDEBAR_WIDTH, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            },
           completion: {    // 애니메이션 완료 후 실행해야 할 내용
            if $0 == true { // 첫번 째 매개변수의 값이 true라면(애니메이션이 정상적으로 종료 되었다면)
                // ↑ 클로저에서 매개변수의 선언을 생략하는 간소화 문법
                // ↑  completion에 들어갈 함수 구문은 반드시 Bool 형태의 매개변수를 가져야한다.
                self.isSideBarShowing = true // 열림 상태로 플래그를 변경
                complete?() // openSideBar(_:)의 매개변수 complete변수에 저장되 있다가 애니메이션이 완료된 후에 호출
                // 완료 후 실행할 내용이 없을 경우에 nil 값을 전달하게 된다. nil이 전달될 수 있도록 옵셔널 체인이 쓰여진것을 볼 수 있다.
            }
        })
    }
    
    // 사이드 바를 닫음
    func closeSideBar(_ complete: ( () -> Void)? ) {
        // 애니메이션 옵션을 정의
        let options = UIView.AnimationOptions(arrayLiteral: [.curveEaseInOut, .beginFromCurrentState])
        // 애니메이션 실행
        UIView.animate(withDuration: TimeInterval(self.SLIDE_TIME),
           delay: 0,
           options: options,
           animations: {
            // 옆으로 밀려난 콘텐츠 뷰를 제자리로 복귀
            self.contentVC?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            },
           completion: {
            if $0 == true {
                self.sideVC?.view.removeFromSuperview() // 사이드 바 뷰를 제거
                self.sideVC = nil
                self.isSideBarShowing = false // 닫힘 상태로 플래그 변경
                self.setShadowEffect(shadow: false, offset: 0) // 그림자 효과 제거
                complete?()
            }
        })
    }
}
