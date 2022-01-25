//
//  Toolbar.swift
//  TestTask
//
//  Created by Artem Muho on 24.01.2022.
//

import UIKit

class Toolbar: UIView {
    
    //MARK: - Properties
    
    lazy var keyboardButton: UIButton = {
        let button = UIButton()
        button.tintColor = .lightGray
        button.setImage(UIImage(systemName: "keyboard"), for: .normal)
        return button
    }()
    
    lazy var fontChangeButton: UIButton = {
        let button = UIButton()
        button.tintColor = .lightGray
        button.setImage(UIImage(systemName: "character.cursor.ibeam"), for: .normal)
        return button
    }()
    
    lazy var textFontChangeView = TextFontChangeCollectionView()
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupHierarchy()
        setupLayot()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubview(keyboardButton)
        addSubview(fontChangeButton)
        addSubview(textFontChangeView)
    }
    
    private func setupLayot() {
        
        keyboardButton.translatesAutoresizingMaskIntoConstraints = false
        keyboardButton.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        keyboardButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
        
        fontChangeButton.translatesAutoresizingMaskIntoConstraints = false
        fontChangeButton.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        fontChangeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        
//        textFontChangeView.translatesAutoresizingMaskIntoConstraints = false
//        textFontChangeView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        textFontChangeView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        textFontChangeView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
//        textFontChangeView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
//        textFontChangeView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}

