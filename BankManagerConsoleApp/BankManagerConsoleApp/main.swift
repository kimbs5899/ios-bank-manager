import Foundation

func openBank() {
    let bank = Bank(bankEmployeeCount: 3)
    let bankManager = BankManager(bank: bank)

    while bankManager.fetchIsRunning() {
        bankManager.startBusiness()
    }
}

openBank()
