//
//  Model.swift
//  TestTask
//
//  Created by Artem Muho on 21.01.2022.
//

import Foundation

struct Cells: CellManager {
    var discripton: String
    var size: Int
    
    static func takeData() -> [Cells] {
        let cells = [Cells(discripton: "Название", size: 24),
                         Cells(discripton: "Заголовок", size: 18),
                         Cells(discripton: "Подзаголовок", size: 14),
                         Cells(discripton: "Основной текст", size: 14),
                         Cells(discripton: "Дополнительный текст", size: 12)]
        return cells
        }
}
