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
    
    // MARK: - Methods
    
    func configurePopUpButton() {
        mainView.sortListPopUp.configure(selectedItem: viewModel.selectedSortAlgorithm)
    }
    
    func configureActions() {
        mainView.sortListPopUp.action = #selector(sortSelected)
        mainView.startButton.action = #selector(startButtonTapped)
        mainView.shuffleButton.action = #selector(shuffleButtonTapped)
    }
    
    func configureBindings() {
        viewModel.$sortChange
            .receive(on: DispatchQueue.main)
            .sink { [weak self] changes in
                self?.mainView.sortingBarsView.update(withChange: changes)
            }
            .store(in: &cancellables)
        
        let buttonsIsEnabledPublisher = viewModel.$isSorting
            .receive(on: DispatchQueue.main)
            .map { !$0 }
        
        buttonsIsEnabledPublisher
            .sink { [weak self] isEnabled in
                self?.mainView.sortListPopUp.isEnabled = isEnabled
                self?.mainView.startButton.isEnabled = isEnabled
                self?.mainView.shuffleButton.isEnabled = isEnabled
            }
            .store(in: &cancellables)
    }
}

// MARK: - Actions

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
