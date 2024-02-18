//
//  OnboardingCollectionViewCell.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/17/24.
//

import UIKit

import SnapKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let imageView = UIImageView()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    private func setLayout() {
        self.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Custom Methods
    
    func bindData(with image: UIImage) {
        imageView.image = image
        print(image)
    }
}
