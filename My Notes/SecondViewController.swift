import UIKit

class SecondViewController: UIViewController {
    
    
    let bigTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 350, height: 1600 ))
    var note : ListNotes?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadNotes()
        self.view.backgroundColor = .systemGray4
        self.title = note?.title
        
            let doneButton = UIBarButtonItem(title: "Готово",
                                             style:  .done,
                                             target: self,
                                             action: #selector(saveNotes))
                                          
        navigationItem.rightBarButtonItem = doneButton
        
        bigTextField.center = CGPoint(x: 180,y: 120)
        bigTextField.textAlignment = .natural
        bigTextField.font = bigTextField.font?.withSize(20)
        bigTextField.backgroundColor = .systemGray4
        bigTextField.textColor = .black
        bigTextField.font = UIFont(name: "Helvetica", size: 25)
        bigTextField.placeholder = "Ваша заметка"
        bigTextField.keyboardType = .default
        self.view.addSubview(bigTextField)
    }
    
    @objc func saveNotes() {
        guard let id = note?.id else { return }
        let newnote = bigTextField.text
        UserDefaults.standard.setValue(newnote, forKey: id)
        UserDefaults.standard.synchronize()
        
        let alertSucces = UIAlertController(title: "Заметка сохранена", message: .none, preferredStyle: .alert)
        alertSucces.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alertSucces, animated: true, completion: nil)
    }
    
    func loadNotes() {
        guard let id = note?.id else { return }
        guard let notesData = UserDefaults.standard.string(forKey: id) else {
            return
        }
        bigTextField.text = notesData
    }
}

