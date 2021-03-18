import UIKit

class SecondViewController: UIViewController {
    
    
    let bigTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 380, height: 500 ))
    var note : ListNotes?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadNotes()
        self.view.backgroundColor = .systemBackground
        self.title = note?.title
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                        target: self,
                                        action: #selector(saveNotes))
        navigationItem.rightBarButtonItem = doneButton
        
        bigTextField.center = CGPoint(x: 205,y: 120)
        bigTextField.textAlignment = .natural
        bigTextField.font = bigTextField.font?.withSize(20)
        bigTextField.backgroundColor = .systemYellow
        bigTextField.textColor = .black
        bigTextField.placeholder = "Ваша заметка"
        self.view.addSubview(bigTextField)
        
        
    }
    @objc func saveNotes() {
        let newnote = bigTextField.text
        UserDefaults.standard.setValue(newnote, forKey: "NewNoteKeys")
        UserDefaults.standard.synchronize()
        
        let alertSucces = UIAlertController(title: "Заметка сохранена", message: .none, preferredStyle: .alert)
        
        
    }
    func loadNotes() {

        self.bigTextField.text = bigTextField.text
        guard let notesData = UserDefaults.standard.value(forKey: "NewNoteKeys") as? Data else {
            return
        }
        self.bigTextField.text = bigTextField.text
        print(bigTextField.text)
    }
}

