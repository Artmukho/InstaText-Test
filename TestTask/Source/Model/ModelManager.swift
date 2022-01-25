//
//  ModelManager.swift
//  TestTask
//
//  Created by Artem Muho on 25.01.2022.
//

import Foundation

protocol CellManager {
    static func takeData() -> [Cells]
}

//extension CellManager {
//    func takeCellData() -> [Cells] {
//        let cells = [Cells(discripton: "Название", size: 24),
//                     Cells(discripton: "Заголовок", size: 18),
//                     Cells(discripton: "Подзаголовок", size: 14),
//                     Cells(discripton: "Основной текст", size: 14),
//                     Cells(discripton: "Дополнительный текст", size: 12)]
//        return cells
//    }
//}
