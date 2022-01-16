//
//  PasswordViewController.swift
//  CocoTalk
//
//  Created by byunghak on 2022/01/10.
//

import UIKit
import SnapKit
import Then
import RxSwift

class PasswordViewController: UIViewController {
    
    // MARK: - UI Properties
    private let lblNewAccount = UILabel().then {
        $0.text = "새로운 코코톡계정을 생성합니다"
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.textAlignment = .center
    }
    
    private let lblMyAccount = UILabel().then {
        $0.text = "내 코코톡 계정"
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .secondaryLabel
        $0.textAlignment = .center
    }
    
    private let lblPhoneNumber = UILabel().then {
        $0.text = "000-0000-0000"
        $0.font = .systemFont(ofSize: 24)
        $0.textAlignment = .center
    }
    
    private let textFieldPassword = UITextField().then {
        $0.placeholder = "비밀번호 (8자 이상)"
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.spellCheckingType = .no
        $0.textContentType = .password
        $0.isSecureTextEntry = true
    }
    
    private let textFieldConfirmPassword = UITextField().then {
        $0.placeholder = "비밀번호 확인 (8자 이상)"
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.spellCheckingType = .no
        $0.textContentType = .password
        $0.isSecureTextEntry = true
    }
    
    private let lblWarning = UILabel().then {
        $0.text = "비밀번호가 일치하지 않습니다."
        $0.textColor = .systemRed
        $0.font = .systemFont(ofSize: 14)
        $0.isHidden = false
    }
    
    private let btnConfirm = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.backgroundColor = .systemBlue
    }
    
    // MARK: - Properties
    var bag = DisposeBag()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureView()
        configureSubviews()
        bindRx()
    }
    
    // MARK: - Helper
}

// MARK: - BaseViewController
extension PasswordViewController {
    func configureView() {
        [lblNewAccount, lblMyAccount, lblPhoneNumber, textFieldPassword, textFieldConfirmPassword, lblWarning, btnConfirm].forEach {
            view.addSubview($0)
        }
    }
    
    func configureSubviews() {
        lblNewAccount.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
        }
        
        lblMyAccount.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(lblNewAccount.snp.bottom).offset(30)
        }
        
        lblPhoneNumber.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(lblMyAccount.snp.bottom).offset(8)
        }
        
        textFieldPassword.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(lblPhoneNumber.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(30)
        }
        
        textFieldConfirmPassword.snp.makeConstraints {
            $0.top.equalTo(textFieldPassword.snp.bottom).offset(8)
            $0.leading.trailing.height.equalTo(textFieldPassword)
        }
        
        lblWarning.snp.makeConstraints {
            $0.leading.trailing.equalTo(textFieldPassword)
            $0.top.equalTo(textFieldConfirmPassword.snp.bottom).offset(8)
        }
        
        btnConfirm.snp.makeConstraints {
            $0.top.equalTo(textFieldConfirmPassword.snp.bottom).offset(50)
            $0.leading.trailing.equalTo(textFieldPassword)
            $0.height.equalTo(44)
        }
    }
}

// MARK: - Bindable
extension PasswordViewController {
    func bindRx() {
        bindButton()
    }
    
    func bindButton() {
        btnConfirm.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let self = self,
                      let navigationController = self.navigationController  else {
                          return
                      }
                let vc = NewProfileViewController()
                navigationController.pushViewController(vc, animated: true)
            }).disposed(by: bag)
    }
}