//
//  CurrencyExchangeViewController.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/15/22.
//

import UIKit
import Combine

class CurrencyExchangeViewController: UIViewController {

    // MARK: IBOutlets
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var sellExchangeView: ExchangeView!
    @IBOutlet weak var receiveExchangeView: ExchangeView!
    
    // MARK: Properties
    
    public var exchangePublisher = PassthroughSubject<Void, Never>()
    
    private var viewModel: CurrencyExchangeViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupExchangeViews()
        setupCallbacks()
        setupBindings()
    }
    
    // MARK: Methods
    
    public func fill(viewModel: CurrencyExchangeViewModel) {
        self.viewModel = viewModel
    }
    
    func setupExchangeViews() {
        sellExchangeView.setupViews(forType: .sell, currency: .eur)
        receiveExchangeView.setupViews(forType: .receive, currency: .usd)
    }
    
    func setupCallbacks() {
        sellExchangeView.currencySelectionCallback = { [weak self] _ in
            guard let self = self else { return }
            let list = CurrencyType.allCases
            self.presentActionSheet(currencies: list) { currency in
                self.sellExchangeView.select(currency: currency)
                self.calculateExchange()
            }
        }
        
        receiveExchangeView.currencySelectionCallback = { [weak self] _ in
            guard let self = self else { return }
            let list = CurrencyType.allCases
            self.presentActionSheet(currencies: list) { currency in
                self.receiveExchangeView.select(currency: currency)
                self.calculateExchange()
            }
        }
    }
    
    private func setupBindings() {
        viewModel?.exchangeCalculationPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] model in
                guard let self = self, let amount = model.amount else { return }
                self.receiveExchangeView.set(amount: amount)
            })
            .store(in: &cancellables)
        
        viewModel?.exchangeExecutionPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] transaction in
                guard let self = self else { return }
                self.presentAlert(message: transaction.description, title: "Currency converted")
                self.exchangePublisher.send()
                self.receiveExchangeView.clear()
                self.sellExchangeView.clear()
            })
            .store(in: &cancellables)
        
        viewModel?.errorPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] errorMessage in
                guard let self = self else { return }
                self.presentAlert(message: errorMessage)
            })
            .store(in: &cancellables)
        
        sellExchangeView.textField
            .textPublisher
            .receive(on: DispatchQueue.main)
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] text in
                guard let self = self else { return }
                self.viewModel?.calculateExchange(amount: text.asDouble,
                                                  fromType: self.sellExchangeView.currencyType,
                                                  toType: self.receiveExchangeView.currencyType)
            }
            .store(in: &cancellables)
    }
    
    private func presentAlert(message: String, title: String? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(.init(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    private func presentActionSheet(currencies: [CurrencyType], onSelect: @escaping (CurrencyType) -> Void) {
        let actionSheetController = UIAlertController(title: nil,
                                                      message: "Select the currency",
                                                      preferredStyle: .actionSheet)
        
        currencies.forEach { currency in
            let action = UIAlertAction(title: currency.rawValue, style: .default) { _ in
                onSelect(currency)
            }
            actionSheetController.addAction(action)
        }
        
        actionSheetController.addAction(.init(title: "Cancel", style: .destructive, handler: nil))
        
        present(actionSheetController, animated: true)
    }
    
    private func calculateExchange() {
        guard let sellInputText = sellExchangeView.textField.text else { return }
        let amount = sellInputText.asDouble
        let fromType = sellExchangeView.currencyType
        let toType = receiveExchangeView.currencyType
        viewModel?.calculateExchange(amount: amount, fromType: fromType, toType: toType)
    }

    private func executeExchange() {
        guard let sellInputText = sellExchangeView.textField.text else { return }
        let amount = sellInputText.asDouble
        let fromType = sellExchangeView.currencyType
        let toType = receiveExchangeView.currencyType
        viewModel?.submitExchange(amount: amount, fromType: fromType, toType: toType)
    }
        
    // MARK: IBActions
    
    @IBAction private func submitButtonTapped(_ sender: UIButton) {
        executeExchange()
    }
}
