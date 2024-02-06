import Foundation

struct Customer {

    let ticketNumber: Int
    let bankServices: BankBusiness
    
    init(numberTicket: Int, bankServices: BankBusiness) {
        self.ticketNumber = numberTicket
        self.bankServices = bankServices
    }
}
