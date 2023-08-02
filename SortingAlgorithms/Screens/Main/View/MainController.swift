//
//  MainController.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 02.08.2023.
//

import Cocoa
import Combine

class MainViewController: NSViewController {

    var viewModel: MainViewModel!

    var mainView = MainView()
    
    private var cancellables = Set<AnyCancellable>()

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.$array
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newArray in
                self?.mainView.sortingBarsView.update(withArray: newArray)
            }
            .store(in: &cancellables)
            
        viewModel.start()
    }
}
