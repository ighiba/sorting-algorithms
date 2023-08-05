//
//  MainController.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 02.08.2023.
//

import Cocoa
import Combine

class MainViewController: NSViewController {
    
    // MARK: - Properties

    var viewModel: MainViewModel!

    var mainView = MainView()
    
    private var cancellables = Set<AnyCancellable>()

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureInputs()
        configurePopUpButton()
        configureActions()
        configureBindings()
            
        viewModel.viewDidLoad()
    }
    
    // MARK: - Methods
    
    func configureInputs() {
        mainView.inputContainer.arraySizeTextField.stringValue = "\(viewModel.arraySize)"
        mainView.inputContainer.delayTextField.stringValue = "\(viewModel.delay)"
    }
    
    func configurePopUpButton() {
        mainView.sortListPopUp.configure(selectedItem: viewModel.currentSortAlgorithm)
    }
    
    func configureActions() {
        mainView.inputContainer.arraySizeTextFieldDelegate = TextFieldDelegate { self.handleArraySizeChange($0) }
        mainView.inputContainer.delayTextFieldDelegate = TextFieldDelegate { self.handleDelayChange($0) }
        mainView.sortListPopUp.action = #selector(sortSelected)
        mainView.startButton.action = #selector(startButtonTapped)
        mainView.shuffleButton.action = #selector(shuffleButtonTapped)
    }
    
    func configureBindings() {
        viewModel.$sortChange
            .receive(on: DispatchQueue.main)
            .sink { [weak self] changes in
                let maxValue = self?.viewModel.arraySize ?? UInt16((changes.array.max() ?? 0))
                self?.mainView.sortingBarsView.update(withChange: changes, maxValue: maxValue)
            }
            .store(in: &cancellables)
        
        viewModel.$sortStatistics
            .receive(on: DispatchQueue.main)
            //.throttle(for: 0.05, scheduler: DispatchQueue.main, latest: true)
            .sink { [weak self] statistics in
                self?.mainView.sortStatisticsView.update(withStatistics: statistics)
            }
            .store(in: &cancellables)
        
        viewModel.$isSorting
            .receive(on: DispatchQueue.main)
            .map { !$0 }
            .sink { [weak self] isEnabled in
                self?.mainView.inputContainer.arraySizeTextField.isEnabled = isEnabled
                self?.mainView.inputContainer.delayTextField.isEnabled = isEnabled
                self?.mainView.sortListPopUp.isEnabled = isEnabled
                self?.mainView.startButton.isEnabled = isEnabled
                self?.mainView.shuffleButton.isEnabled = isEnabled
            }
            .store(in: &cancellables)
    }
}

// MARK: - Actions

extension MainViewController {
    func handleArraySizeChange(_ sender: NSTextField) {
        let text = sender.stringValue
        let minSize: UInt16 = 10
        var result = text.isEmpty ? minSize : UInt16(text) ?? minSize
        result = result >= minSize ? result : minSize
        viewModel.arraySize = result
    }
    
    func handleDelayChange(_ sender: NSTextField) {
        let text = sender.stringValue
        let minSize: UInt16 = 5
        var result = text.isEmpty ? minSize : UInt16(text) ?? minSize
        result = result >= minSize ? result : minSize
        viewModel.delay = result
    }
    
    @objc func sortSelected(_ sender: NSPopUpButton) {
        guard let title = sender.selectedItem?.title,
              let sort = SortAlgorithms(rawValue: title)
        else {
            return
        }
        viewModel.changeAlgorithm(sort)
    }
    
    @objc func startButtonTapped(_ sender: NSButton) {
        viewModel.start()
    }
    
    @objc func shuffleButtonTapped(_ sender: NSButton) {
        viewModel.shuffle()
    }
}
