import Foundation

final class BankManager {
    
    private var bank: Bank
//    private var view: ConsoleTextView = ConsoleTextView()
    private var isRunning: Bool = true
    private let depositSemaphore = DispatchSemaphore(value: 2)
    private let loanSemaphore = DispatchSemaphore(value: 1)
    private let depositGroup = DispatchGroup()
    private let loanGroup = DispatchGroup()

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
//        view.printMenuMessage(menu: CustomStringPrintMenu.printMenuText, menuTerminator: CustomStringPrintMenu.isEmptyText)
    }
    
    
    private func switchMenu(_ input: String) {
        guard let menu = InputNumber(rawValue: input) else {
//            view.printInputMessage(input: CustomStringInput.wrongInputMessage)
            startBusiness()
            return
        }
        
        switch menu {
        case .one:
            bank.enqueueCustomer()
            bankBusinessProcess()
            
            depositGroup.wait()
            loanGroup.wait()
            
//            view.printMenuMessage(menu: CustomStringPrintMenu.resultBusiness(bank.fetchCustomerCount(), bank.fetchTime()))
            formIsRunning()
        case .two:
//            view.printInputMessage(input: CustomStringInput.bankClose)
            formIsRunning()
        }
    }
    
    private func bankBusinessProcess() {
        while !bank.fetchCustomerIsEmpty() {
            checkBusinessService()
        }
    }
    
    private func checkBusinessService() {
        if bank.fetchCustomerWaitingList().peek()?.bankServices == .deposit {
            self.banker(semphore: self.depositSemaphore, group: self.depositGroup, usedTime: BusinessHour.deposit)
            self.banker(semphore: self.depositSemaphore, group: self.depositGroup, usedTime: BusinessHour.deposit)
        } else {
            self.banker(semphore: self.loanSemaphore, group: self.loanGroup, usedTime: BusinessHour.loan)
        }
    }
    
    private func dequeueCustomer() {
        bank.dequeueCustomer()
    }
                                          
    private func banker(semphore: DispatchSemaphore, group: DispatchGroup, usedTime: TimeInterval) {
        guard let customer = bank.customerPeek() else {
            return
        }
        
        semphore.wait()
        performBusiness(semphore: semphore, group: group, for: customer, with: customer.bankServices, usedTime: usedTime)
    }
    
    private func performBusiness(semphore: DispatchSemaphore, group: DispatchGroup, for customer: Customer, with service: BankBusiness, usedTime: TimeInterval) {
        group.enter()
        
//        view.printMenuMessage(menu: CustomStringPrintMenu.startCustomerBusiness(customer.ticketNumber, service.rawValue))
        dequeueCustomer()
        bank.addProcessTime(BusinessHour.loan)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + usedTime , execute: { [weak self] in
            guard let self = self else {
                return
            }
            
            DispatchQueue.global().async(group: self.loanGroup) {
//                self.view.printMenuMessage(menu: CustomStringPrintMenu.endCustomerBusiness(customer.ticketNumber, service.rawValue))
                semphore.signal()
                group.leave()
            }
        })
    }
    
    private func userInput() -> String {
        guard let userInput = readLine() else {
            return CustomStringPrintMenu.isEmptyText.description
        }
        return userInput
    }
    
    func fetchIsRunning() -> Bool {
        return isRunning
    }
    
    func formIsRunning() {
        isRunning.toggle()
    }
}
