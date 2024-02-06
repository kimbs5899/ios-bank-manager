import Foundation

struct ConsoleTextView {

}

extension ConsoleTextView {
    func printInputMessage(input: CustomStringInput, inputTerminator: CustomStringInput? = nil) {
        print(input, terminator: inputTerminator?.description ?? "\n")
    }
    
    func printMenuMessage(menu: CustomStringPrintMenu, menuTerminator: CustomStringPrintMenu? = nil) {
        print(menu, terminator: menuTerminator?.description ?? "\n")
    }
}
