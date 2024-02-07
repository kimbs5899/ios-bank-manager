import UIKit

class ViewController: UIViewController {

    let testView: UIView = MainView() as UIView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = testView
        view.backgroundColor = .white
    }


}

