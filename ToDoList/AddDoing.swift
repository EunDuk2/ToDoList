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
    @IBOutlet var lblList: UILabel!
    
    override func viewDidLoad() {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM월 dd일"
        
        stringDate = dateFormat.string(from: datePick.date)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

        DatePicker_()
        outputDoing()
        table.reloadData()
    }
    func test() {
        //var test:String?
        var test1:String = ""
        //test = String(doing.count)
//        if let tst = test {
//            lblList.text = tst
//        }
        for i in 0..<doing.count {
            test1 += doing[i].key!
        }
        lblList.text = test1
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
    
    func outputDoing() {
        doing = getDoing()
        
        if(checkKey() != -1) {
            lblList.text = doing[checkKey()].outputDoing()
        } else {
            lblList.text = ""
        }

        //test()
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

        outputDoing()
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
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
            //itemsImageFile.remove(at: (indexPath as NSIndexPath).row)
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
    

    @IBAction func onAdd(_ sender: Any) {

        let i = checkKey()
        if (i != -1) {
            doing[i].addDoing(Doing: txtDoing.text!)
        } else if (i == -1) {
            doing.append(Day(key: dateKey, date: stringDate))
            doing[doing.count-1].addDoing(Doing: txtDoing.text!)
        }
        
        sortDoing()
        ud.set(try? PropertyListEncoder().encode(doing), forKey: "day")
        
        outputDoing()
        table.reloadData()
        
        txtDoing.text = ""
    }
    
    @IBAction func Submit(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func arrInit(_ sender: Any) {
        ud.removeObject(forKey: "day")
        lblList.text = ""
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
    var hidden1 = false

    override func setEditing(_ editing: Bool, animated: Bool) {
            super.setEditing(editing, animated: animated)

            print("edit")
            if self.table.isEditing {

                        self.table.setEditing(false, animated: true)
                hidden1 = false
                    } else {

                        self.table.setEditing(true, animated: true)
                    hidden1 = true
                    }
            self.table.reloadData()

        }
    
}
