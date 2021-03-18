import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var firstTableView = UITableView(frame: .zero, style: .plain)
    let identifier = "MyCell"
    var notes = [ListNotes(title :"Список дел" ,
                           id : UUID().uuidString)] {
        didSet {
            firstTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Ваши заметки"
        
        createTable()
        firstTableView.reloadData()

        
        
        view.addSubview(firstTableView)
    }
    
    func createTable() {
        self.firstTableView.frame = view.bounds
        firstTableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        
        
        self.firstTableView.delegate = self
        self.firstTableView.dataSource = self
        
        firstTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(firstTableView)
        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(addNote))
        navigationItem.leftBarButtonItem = addButton
        loadData()
    }
    @objc func addNote() {
        let alert = UIAlertController(title: "Новая заметка",
                                      message: "Введите текст новой заметки",
                                      preferredStyle: .alert)
        alert.addTextField { textField in
            textField.keyboardType = .default
            textField.placeholder = "Новая заметка"
        }
        alert.addAction(UIAlertAction(title: "Отменить",
                                      style: .cancel,
                                      handler: { _ in
                                        return
                                      }))
        alert.addAction(UIAlertAction(title: "Добавить",
                                      style: .default,
                                      handler: { [weak self] _ in
                                        guard let self = self,
                                              let textField = alert.textFields?.first,
                                              let text = textField.text else {
                                            return
                                        }
                                        let note = ListNotes(title: text,
                                                         id: UUID().uuidString)
                                        self.notes.append(note)
                                        self.saveData()
                                      }))
        present(alert, animated: true, completion: nil)
    }
    func saveData() {
        if let encoded = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.setValue(encoded, forKey: "NotesKeys")
        }
    }
    
    func loadData() {
        guard let notesData = UserDefaults.standard.value(forKey: "NotesKeys") as? Data else {
            return
        }
        
        guard let notes = try? JSONDecoder().decode([ListNotes].self, from: notesData) else {
            return
        }
        self.notes = notes
        
    }
   
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        let note = notes[indexPath.row]
        
        cell.textLabel?.text = note.title
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notes[indexPath.row]
        let secondVC = SecondViewController()
        secondVC.note = note
        navigationController?.pushViewController(secondVC, animated: true)
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let editAction = UIContextualAction(style: .normal,
                                            title: "Изменить") { (action, view, handler) in
            let alert = UIAlertController(title: "Редактирование заметки",
                                          message: "Введите текст заметки",
                                          preferredStyle: .alert)
            alert.addTextField { textField in
                textField.keyboardType = .default
                textField.placeholder = self.notes[indexPath.row].title
            }
            alert.addAction(UIAlertAction(title: "Отменить",
                                          style: .cancel,
                                          handler: { _ in
                                            return
                                          }))
            alert.addAction(UIAlertAction(title: "Изменить",
                                          style: .default,
                                          handler: { [weak self] _ in
                                            guard let self = self,
                                                  let textField = alert.textFields?.first,
                                                  let text = textField.text else {
                                                return
                                            }
                                            let newnote = ListNotes(title: text,
                                                             id: UUID().uuidString)
                                            self.notes[indexPath.row] = newnote
                                            self.saveData()
                                          }))
            self.present(alert, animated: true, completion: nil)
        }
        editAction.backgroundColor = .systemGreen
        let configuration = UISwipeActionsConfiguration(actions: [editAction])
        return configuration
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] (action, view, handler) in
            self?.notes.remove(at: indexPath.row)
            self?.saveData()
        }
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}



