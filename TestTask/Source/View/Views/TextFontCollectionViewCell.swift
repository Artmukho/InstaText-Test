//
//  TextFontCollectionViewCell.swift
//  TestTask
//
//  Created by Artem Muho on 25.01.2022.
//

import UIKit

class TextFontChangeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TextFontChangeCollectionView"
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            layer.shadowColor = isSelected ? UIColor.purple.cgColor : UIColor.lightGray.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        layer.cornerRadius = 15
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 0)
        layer.shadowOpacity = 0.2
        backgroundColor = .white
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHierarchy() {
        addSubview(label)
    }
    
    func setupLayout() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
