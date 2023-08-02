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
        
        configurePopUpButton()
        configureActions()
        
        viewModel.$array
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newArray in
                self?.mainView.sortingBarsView.update(withArray: newArray)
            }
            .store(in: &cancellables)
            
        //viewModel.viewDidLoad()
    }
    
    func configurePopUpButton() {
        mainView.sortListPopUp.configure(selectedItem: viewModel.selectedSortAlgorithm)
    }
    
    func configureActions() {
        mainView.sortListPopUp.action = #selector(sortSelected)
        mainView.startButton.action = #selector(startButtonTapped)
        mainView.shuffleButton.action = #selector(shuffleButtonTapped)
    }
}

extension MainViewController {
    @objc func sortSelected(_ sender: NSPopUpButton) {
        guard let title = sender.selectedItem?.title,
              let sort = SortAlgorithms(rawValue: title)
        else {
            return
        }
        print("\(sort.rawValue)")
    }
    
    @objc func startButtonTapped(_ sender: NSButton) {
        viewModel.start()
    }
    
    @objc func shuffleButtonTapped(_ sender: NSButton) {
        viewModel.shuffle()
    }
}
