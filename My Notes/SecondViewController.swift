import UIKit

class SecondViewController: UIViewController {
    
    let bigTextField = UITextField(frame: CGRect(x: 0, y: 0, width: .max, height: .max ))
        
    var note : ListNotes?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.title = note?.title
        
        bigTextField.center = CGPoint(x: 50,y: 0)
        bigTextField.textAlignment = .center
        bigTextField.font = bigTextField.font?.withSize(20)
        bigTextField.backgroundColor = .clear
        bigTextField.text = "Hello"
        bigTextField.textColor = .blue
        self.view.addSubview(bigTextField)
        
    
        
  
    }

}

