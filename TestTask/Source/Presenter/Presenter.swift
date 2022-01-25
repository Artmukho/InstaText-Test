//
//  Presenter.swift
//  TestTask
//
//  Created by Artem Muho on 21.01.2022.
//

import Foundation


class Presenter: ViewOutput {
    
    var view: ViewInput?
    var model: CellManager?
    
    func saveButtonAction() {
        view?.selectDisabled()
        view?.prepareTextToImage()
        view?.takePicture()
        view?.editEnabled()
    }
}
