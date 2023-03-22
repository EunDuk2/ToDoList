// 이모티콘 단축키: ctrl + command + spacebar
import UIKit

class AddDoing : UIViewController, UITableViewDataSource, UITableViewDelegate {

    var doing:[Day] = []
    var stringDate: String = ""
    var dateKey: String = ""
    
    let ud = UserDefaults.standard
    var arr:[String] = []
    
    @IBOutlet var table: UITableView!
    @IBOutlet var txtDoing: UITextField!
    @IBOutlet var datePick: UIDatePicker!
    
    override func viewDidLoad() {
        setKeyboardObserver()
        txtDoing.delegate = self
        
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM월 dd일"
        
        stringDate = dateFormat.string(from: datePick.date)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DatePicker_()
        table.reloadData()
        
    }
    
    func checkKey() -> Int {
        for i in 0..<doing.count {
            if(doing[i].key == dateKey) {
                return i
            }
        }
        return -1
    }
    
    func getDoing() -> [Day] {
        guard let savedData = ud.value(forKey: "day") as? Data,
                    let loadDoing = try? PropertyListDecoder().decode([Day].self, from: savedData) else { return [] }
                    return loadDoing
    }
    
    func sortDoing() {
        doing.sort(by: {$0.key! < $1.key!})
    }
    
    @IBAction func DatePicker(_ sender: UIDatePicker) {
        let DatePick = sender
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM월 dd일"
        
        stringDate = dateFormat.string(from: DatePick.date)
        
        dateFormat.dateFormat = "yyyyMMdd"
        dateKey = dateFormat.string(from: DatePick.date)

        table.reloadData()
    }
    
    func DatePicker_() {
        let DatePick = datePick
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyyMMdd"
        if let dk = DatePick?.date {
            dateKey = dateFormat.string(from: dk)
        }
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        doing = getDoing()
        
        if (checkKey() != -1) {
            return doing[checkKey()].doingList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.doing[checkKey()].doingList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoingCell") as! DoingCell
        
        cell.lblDoing?.text = row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            doing[checkKey()].doingList.remove(at: (indexPath as NSIndexPath).row)
            doing[checkKey()].checkButton.remove(at: (indexPath as NSIndexPath).row)
            
            ud.set(try? PropertyListEncoder().encode(doing), forKey: "day")

            tableView.deleteRows(at: [indexPath], with: .fade)

        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
    
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let itemToMove = doing[checkKey()].doingList[(fromIndexPath as NSIndexPath).row]
        
        doing[checkKey()].doingList.remove(at: (fromIndexPath as NSIndexPath).row)
        
        doing[checkKey()].doingList.insert(itemToMove, at: (to as NSIndexPath).row)
        ud.set(try? PropertyListEncoder().encode(doing), forKey: "day")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let du = self.storyboard?.instantiateViewController(withIdentifier: "DoingUpdate") as? DoingUpdate else {
                    return
                }
        du.index = indexPath.row
        du.date = checkKey()
        
        du.modalPresentationStyle = .fullScreen
        self.present(du, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

    @IBAction func onAdd(_ sender: Any) {

        let i = checkKey()
        if (i != -1) {
            doing[i].addDoing(Doing: txtDoing.text!)
            doing[i].addButton(ButtonText: "🟩")
        } else if (i == -1) {
            doing.append(Day(key: dateKey, date: stringDate))
            doing[doing.count-1].addDoing(Doing: txtDoing.text!)
            doing[doing.count-1].addButton(ButtonText: "🟩")
        }
        
        sortDoing()
        ud.set(try? PropertyListEncoder().encode(doing), forKey: "day")
        
        table.reloadData()
        
        txtDoing.text = ""
    }
    
    @IBAction func Submit(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func arrInit(_ sender: Any) {
        ud.removeObject(forKey: "day")
    }
    
    @IBAction func edit(_ sender: UIBarButtonItem) {
        if table.isEditing {
            sender.title = "Edit"
            table.setEditing(false, animated: true)
        } else {
            sender.title = "Done"
            table.setEditing(true, animated: true)
        }
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
            super.setEditing(editing, animated: animated)

            print("edit")
            if self.table.isEditing {

                        self.table.setEditing(false, animated: true)
                    } else {

                        self.table.setEditing(true, animated: true)
                    }
            self.table.reloadData()

        }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension AddDoing: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // TextField 비활성화
        return true
    }
}

extension UIViewController {
    
    func setKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object:nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
          if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                  let keyboardRectangle = keyboardFrame.cgRectValue
                  let keyboardHeight = keyboardRectangle.height
              UIView.animate(withDuration: 1) {
                  self.view.window?.frame.origin.y -= keyboardHeight
              }
          }
      }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.window?.frame.origin.y != 0 {
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                    let keyboardRectangle = keyboardFrame.cgRectValue
                    let keyboardHeight = keyboardRectangle.height
                UIView.animate(withDuration: 1) {
                    self.view.window?.frame.origin.y += keyboardHeight
                }
            }
        }
    }
}
