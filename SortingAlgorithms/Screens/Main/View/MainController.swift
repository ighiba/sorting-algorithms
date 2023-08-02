//
//  MainController.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 02.08.2023.
//

import Cocoa

class MainViewController: NSViewController {

    var viewModel: MainViewModelDelegate! {
        didSet {
            // Implement handlers if exists
        }
    }

    var mainView = MainView()

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

