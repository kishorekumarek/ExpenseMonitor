//
//  KSELoginViewController.swift
//  KSExpenseMonitor
//
//  Created by Kishore Kumar Elanchezhiyan on 31/05/19.
//  Copyright © 2019 KiSh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import TransitionButton
import RxSwift
import RxCocoa

class KSELoginViewController: UIViewController, KSEViewControllerType {
   
    typealias ViewModel = KSELoginViewModel
    var viewModel: KSELoginViewModel!
    let disposeBag = DisposeBag()


    @IBOutlet weak var emailField: SkyFloatingLabelTextField!
    @IBOutlet weak var submitButton: TransitionButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func bindViewModel() {
        let submitDriver = submitButton.rx.tap.debounce(1.0, scheduler: MainScheduler.instance).map { self.emailField.text }.filter { ($0 ?? "").isValidEmail() }.map{ text -> String in text! }.asDriver(onErrorJustReturn: "")
        let input = KSELoginViewModel.Input(submitTrigger: submitDriver)
        let output = viewModel.transform(input: input)
        output.result.drive (onNext: { result in
            self.handleSubmitResult(result)
        }).disposed(by: disposeBag)
    }
    
    func handleSubmitResult(_ result: KSResult<KSPerson>) {
        switch result {
        case .success( _):
            print("Validation Success, will load events or signup")
            submitButton.stopAnimation(animationStyle: .expand, revertAfterDelay: 1.0, completion: nil)
        case .error( let error):
            print("Validation failed")
            submitButton.stopAnimation(animationStyle: .shake, revertAfterDelay: 1.0, completion: nil)
            view.showToast(error)
        case .loading:
            submitButton.startAnimation()
            
        }
    }
}

