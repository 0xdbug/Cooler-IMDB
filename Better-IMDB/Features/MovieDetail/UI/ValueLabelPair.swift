//
//  ValueLabelPair.swift
//  Better-IMDB
//
//  Created by dbug on 4/12/25.
//
import UIKit
import SnapKit

class ValueLabelPair: UIView {
    private let containerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 2
        return stack
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    public var value: String = "" {
        didSet {
            valueLabel.text = value
        }
    }
    
    public var type: String = "" {
        didSet {
            typeLabel.text = type
        }
    }
        
    init(value: String = "", type: String = "") {
        self.value = value
        self.type = type
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    
    private func setupUI() {
        backgroundColor = .clear
        
        containerStack.addArrangedSubview(valueLabel)
        containerStack.addArrangedSubview(typeLabel)
        
        addSubview(containerStack)
        
        valueLabel.text = value
        typeLabel.text = type
        
        containerStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
