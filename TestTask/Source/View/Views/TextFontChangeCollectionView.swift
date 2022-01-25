//
//  TextFontChangeCollectionView.swift
//  TestTask
//
//  Created by Artem Muho on 25.01.2022.
//

import UIKit

class TextFontChangeCollectionView: UICollectionView {
    
    var cells: Array<Model> = {
        var cells = [Model]()
        cells.append(Model(text: "Название", font: UIFont.systemFont(ofSize: 24, weight: .bold)))
        cells.append(Model(text: "Заголовок", font: UIFont.systemFont(ofSize: 18, weight: .bold)))
        cells.append(Model(text: "Подзаголовок", font: UIFont.systemFont(ofSize: 14, weight: .semibold)))
        cells.append(Model(text: "Основной текст", font: UIFont.systemFont(ofSize: 14, weight: .regular)))
        cells.append(Model(text: "Дополнительный текст", font: UIFont.systemFont(ofSize: 12, weight: .regular)))
        return cells
    }()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        delegate = self
        dataSource = self
        backgroundColor = .white
        register(TextFontChangeCollectionViewCell.self, forCellWithReuseIdentifier: TextFontChangeCollectionViewCell.identifier)
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(cells: [Model]) {
        self.cells = cells
    }
}

extension TextFontChangeCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension TextFontChangeCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: TextFontChangeCollectionViewCell.identifier, for: indexPath) as! TextFontChangeCollectionViewCell
        cell.label.text = cells[indexPath.row].text
        cell.label.font = cells[indexPath.row].font
        return cell
    }
}

extension TextFontChangeCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 50)
    }
}

struct Model {
    var text: String
    var font: UIFont

}
