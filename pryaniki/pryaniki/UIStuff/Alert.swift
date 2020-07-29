import Foundation
import UIKit

class CustomAlert {
    func show(inView view: UIViewController, message: String) {
        
        let alert = UIAlertController(title: "Selected item info",
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .cancel,
                                   handler: nil)
        alert.addAction(action)
        
        view.present(alert, animated: true)
    }
    
    deinit {
        print("CustomAlert deinit")
    }
}
