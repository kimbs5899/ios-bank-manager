import Foundation

final class BankManager {
    
    private var bank: Bank
    private var view: ConsoleTextView = ConsoleTextView()
    private var isRunning: Bool = true
    private let depositSemaphore = DispatchSemaphore(value: 2)
    private let loanSemaphore = DispatchSemaphore(value: 1)
    private let group1 = DispatchGroup()
    private let group2 = DispatchGroup()

    
    
    init(bank: Bank) {
        self.bank = bank
    }
}

// MARK: - BankManager Method
extension BankManager {
    
    func startBusiness() {
        printMenu()
        switchMenu(userInput())
    }
    
    private func printMenu() {
        view.printMenuMessage(menu: CustomStringPrintMenu.printMenuText, menuTerminator: CustomStringPrintMenu.isEmptyText)
    }
    
    
    private func switchMenu(_ input: String) {
        guard let menu = InputNumber(rawValue: input) else {
            view.printInputMessage(input: CustomStringInput.wrongInputMessage)
            startBusiness()
            return
        }
        
        switch menu {
        case .one:
            bank.enqueueCustomer()
            while !bank.fetchCustomerIsEmpty() {
                if bank.fetchCustomerWaitingList().peek()?.bankServices == .deposit {
                        self.depositBanker()
                        self.depositBanker()
                } else {
                        self.loanBanker()
                }
            }
            
            group1.wait()
            group2.wait()
            view.printMenuMessage(menu: CustomStringPrintMenu.resultBusiness(bank.fetchCustomerCount(), bank.fetchTime()))
            formIsRunning()
        case .two:
            view.printInputMessage(input: CustomStringInput.bankClose)
            formIsRunning()
        }
    }
    
    private func dequeueCustomer() {
        bank.dequeueCustomer()
    }
    
    private func depositBanker() {
        guard let customer = bank.customerPeek() else {
            return
        }

        depositSemaphore.wait()
        performDepositBusiness(for: customer, with: customer.bankServices)
    }
    
    private func performDepositBusiness(for customer: Customer, with service: BankBusiness) {
        self.group1.enter()
        view.printMenuMessage(menu: CustomStringPrintMenu.startCustomerBusiness(customer.ticketNumber, service.rawValue))
        dequeueCustomer()
        bank.addProcessTime(BusinessHour.deposit)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.7  , execute: { [weak self] in
            guard let self = self else {
                return
            }
            
            DispatchQueue.global().async(group: self.group1) {
                self.view.printMenuMessage(menu: CustomStringPrintMenu.endCustomerBusiness(customer.ticketNumber, service.rawValue))
                self.depositSemaphore.signal()
                self.group1.leave()
                }
            })
        }
                                          
    private func loanBanker() {
        guard let customer = bank.customerPeek() else {
            return
        }
        
        loanSemaphore.wait()
        performLoanBusiness(for: customer, with: customer.bankServices)
    }
    
    private func performLoanBusiness(for customer: Customer, with service: BankBusiness) {
        self.group2.enter()
        view.printMenuMessage(menu: CustomStringPrintMenu.startCustomerBusiness(customer.ticketNumber, service.rawValue))
        dequeueCustomer()
        bank.addProcessTime(BusinessHour.laon)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.1  , execute: { [weak self] in
            guard let self = self else {
                return
            }
            DispatchQueue.global().async(group: self.group2) {
                self.view.printMenuMessage(menu: CustomStringPrintMenu.endCustomerBusiness(customer.ticketNumber, service.rawValue))
                self.loanSemaphore.signal()
                self.group2.leave()
            }
        })
    }
    
    private func userInput() -> String {
        guard let userInput = readLine() else {
            return CustomStringPrintMenu.isEmptyText.description
        }
        return userInput
    }
    
    private func workProcessTime(_ time: TimeInterval) {
        Thread.sleep(forTimeInterval: time)
        
    }
    
    func fetchIsRunning() -> Bool {
        return isRunning
    }
    
    func formIsRunning() {
        isRunning.toggle()
    }
}
