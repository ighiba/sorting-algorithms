//
//  MainModuleAssembly.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 02.08.2023.
//

import Cocoa

class MainModuleAssembly {
    class func configureModule() -> NSViewController {
        let view = MainViewController()
        let viewModel = MainViewModel()

        view.viewModel = viewModel
        
        viewModel.sortFactory = SortAlgorithmsFactoryImpl()

        return view
    }
}
