//
//  MultiplePosterView.swift
//  Better-IMDB
//
//  Created by dbug on 4/9/25.
//

import UIKit

class MultiplePosterView: UIView {
    let scaleFactor = 0.9
    
    var posters: [UIImage] = []
    var posterViews: [UIImageView] = []
    let posterWidth: CGFloat = 220
    let posterHeight: CGFloat = 330 // temp
    
    init(frame: CGRect, posters: [UIImage] = []) {
        self.posters = posters
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    
    private func setupView() {
        for (index, image) in posters.enumerated() {
            let posterView = createPosters(with: image, at: index)
            posterViews.append(posterView)
            addSubview(posterView)
        }
        setupConstraints()
    }
    
    private func createPosters(with image: UIImage, at index: Int) -> UIImageView {
        let containerView = UIImageView()
        containerView.backgroundColor = .clear
        
        let posterView = UIImageView(image: image)
        posterView.contentMode = .scaleAspectFill
        posterView.clipsToBounds = true
        posterView.layer.cornerRadius = 25
        
        containerView.addSubview(posterView)
        
        posterView.frame = containerView.bounds
        posterView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        containerView.layer.shadowOpacity = 0.3
        containerView.layer.shadowRadius = 6
        
        return containerView
    }
    
    private func setupConstraints() {
        guard !posterViews.isEmpty else { return }
        
        for (index, posterView) in posterViews.enumerated() {
            let isMainPoster = index == 0
            let width = isMainPoster ? posterWidth : posterWidth * scaleFactor
            let height = isMainPoster ? posterHeight : posterHeight * scaleFactor
            
            posterView.snp.makeConstraints { make in
                make.width.equalTo(width)
                make.height.equalTo(height)
                
//                make.bottom.equalToSuperview().offset(-8)
                
                if index == 0 {
                    make.left.equalToSuperview()
                } else {
                    let leftOffset = posterWidth - (CGFloat(index) * 80)
                    make.left.equalToSuperview().offset(leftOffset)
                    make.centerY.equalToSuperview()
                }
                
                posterView.layer.zPosition = CGFloat(posterViews.count - index)
            }
        }
        
        snp.makeConstraints { make in
            let totalWidth = posterWidth + CGFloat(posterViews.count - 1) * (posterWidth * scaleFactor - 80)
            make.width.equalTo(totalWidth)
            make.height.equalTo(posterHeight)
        }
    }
    
    func updatePosters(_ newPosters: [UIImage]) {
        for posterView in posterViews {
            posterView.removeFromSuperview()
        }
        
        posterViews.removeAll()
        posters = newPosters
        
        setupView()
    }
}
