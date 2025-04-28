//
//  ViewController.swift
//  Better-IMDB
//
//  Created by dbug on 4/23/25.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    var viewModel: ViewModel?
    let disposeBag = DisposeBag()
    
    init(viewModel: ViewModel? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        makeUI()
    }
    
    func bindViewModel() {        
        viewModel?.error
            .subscribe(onNext: { [weak self] error in
                self?.showError(error)
            })
            .disposed(by: disposeBag)
    }
    
    func showError(_ error: Error) {
        let alert = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func makeUI() {
    }
}


