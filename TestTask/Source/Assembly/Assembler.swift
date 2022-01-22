//
//  Assembler.swift
//  TestTask
//
//  Created by Artem Muho on 23.01.2022.
//

import Foundation
import UIKit

class ModuleAssembler {
    
    class func modelAssembly() -> UIViewController {
        let view = ViewController()
        let presenter = Presenter()
        
        view.output = presenter
        presenter.view = view
        
        return view
    }
}
