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
        configureBindings()
            
        viewModel.viewDidLoad()
    }
    
    func configurePopUpButton() {
        mainView.sortListPopUp.configure(selectedItem: viewModel.selectedSortAlgorithm)
    }
    
    func configureActions() {
        mainView.sortListPopUp.action = #selector(sortSelected)
        mainView.startButton.action = #selector(startButtonTapped)
        mainView.shuffleButton.action = #selector(shuffleButtonTapped)
    }
    
    func configureBindings() {
        viewModel.$array
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newArray in
                self?.mainView.sortingBarsView.update(withArray: newArray)
            }
            .store(in: &cancellables)
        
        let buttonsIsEnabledPublisher = viewModel.$isSorting
            .receive(on: DispatchQueue.main)
            .map { !$0 }
            .share()
        
        buttonsIsEnabledPublisher
            .assign(to: \.isEnabled, on: mainView.startButton)
            .store(in: &cancellables)
        
        buttonsIsEnabledPublisher
            .assign(to: \.isEnabled, on: mainView.shuffleButton)
            .store(in: &cancellables)
        
        buttonsIsEnabledPublisher
            .assign(to: \.isEnabled, on: mainView.sortListPopUp)
            .store(in: &cancellables)
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
