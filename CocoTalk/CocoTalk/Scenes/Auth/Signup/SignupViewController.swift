//
//  SignupViewController.swift
//  CocoTalk
//
//  Created by byunghak on 2022/01/10.
//

import UIKit
import SnapKit
import Then
import RxSwift

class SignupViewController: UIViewController {
    
    // MARK: - UI Properties
    private let lblHello = UILabel().then {
        $0.text = "HELLO WORLD!!"
        $0.font = .systemFont(ofSize: 36)
    }
    
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(lblHello)
        lblHello.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: - Helper
}