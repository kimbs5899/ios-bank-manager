import Foundation

struct Bank {
    
    private let bankEmployeeCount: Int
    private var businessHour: Double = 0.0
    
    private let customerCount: Int = Int.random(in: 10...30)
    private let customerWaitingList: Queue = Queue<Customer>()

    init(bankEmployeeCount: Int) {
        self.bankEmployeeCount = bankEmployeeCount
    }
}

// MARK: - Bank Method
extension Bank {
    
    private func createCustomer(_ number: Int) -> Customer {
        let custoemr = Customer(numberTicket: number, bankServices: BankBusiness.allCases.randomElement() ?? .deposit)
        return custoemr
    }
    
    func enqueueCustomer() {
        for number in 1...fetchCustomerCount() {
            customerWaitingList.enqueue(data: createCustomer(number))
        }
    }
    
    func dequeueCustomer() {
        customerWaitingList.dequeue()
    }
    
    func fetchCustomerWaitingList() -> Queue<Customer> {
        return customerWaitingList
    }
    
    func fetchCustomerCount() -> Int {
        return customerCount
    }
    
    func customerPeek() -> Customer? {
        return customerWaitingList.peek()
    }
    
    func fetchCustomerIsEmpty() -> Bool {
        return customerWaitingList.isEmpty()
    }
    
    func fetchTime() -> Double {
        return businessHour.formatTimeToDecimalPlaces(2)
    }
    
    mutating func addProcessTime(_ time: TimeInterval) {
        businessHour += Double(time)
    }
}
