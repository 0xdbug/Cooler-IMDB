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
    
    let isLoading = BehaviorRelay(value: false)
    let error = PublishSubject<Error>()
    
    init(viewModel: ViewModel? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeUI() {
        
    }
    
    func updateUI() {
        
    }
}

