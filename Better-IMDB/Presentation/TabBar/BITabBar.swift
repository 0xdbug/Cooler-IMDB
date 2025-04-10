//
//  CustomTabBar.swift
//  Better-IMDB
//
//  Created by dbug on 4/9/25.
//


import UIKit
import RxSwift
import RxCocoa
import RxGesture

final class BITabBar: UIStackView {
    
    var itemTapped: Observable<Int> { itemTappedSubject.asObservable() }
    
    private lazy var customItemViews: [BIItemView] = [homeItem, bookmarkItem]
    
    private let homeItem = BIItemView(with: .home, index: 0)
    private let bookmarkItem = BIItemView(with: .bookmark, index: 1)
    
    private let itemTappedSubject = PublishSubject<Int>()
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(frame: .zero)
        
        setupHierarchy()
        setupProperties()
        bind()
        
        setNeedsLayout()
        layoutIfNeeded()
        selectItem(index: 0)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addArrangedSubview(homeItem)
        addArrangedSubview(bookmarkItem)
    }
    
    private func setupProperties() {
        distribution = .fillEqually
        alignment = .fill
        spacing = 0
        
        // Adding debug color
        // backgroundColor = .blue.withAlphaComponent(0.3)
        
        layer.cornerRadius = 30
        clipsToBounds = true
        
        customItemViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.clipsToBounds = true
        }
    }
    
    private func selectItem(index: Int) {
        customItemViews.forEach { $0.isSelected = $0.index == index }
        itemTappedSubject.onNext(index)
    }
    
    //MARK: - Bindings
    
    private func bind() {
        homeItem.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.selectItem(index: self.homeItem.index)
            }
            .disposed(by: disposeBag)
        
        bookmarkItem.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.selectItem(index: self.bookmarkItem.index)
            }
            .disposed(by: disposeBag)
    }
}
