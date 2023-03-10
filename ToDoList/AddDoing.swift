import UIKit

class AddDoing : UIViewController {
    var doing:[Day] = []
    var stringDate: String = ""
    var dateKey: String = ""
    
    let ud = UserDefaults.standard
    var arr:[String] = []
    
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
    }
    
    func DatePicker_() {
        let DatePick = datePick
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyyMMdd"
        if let dk = DatePick?.date {
            dateKey = dateFormat.string(from: dk)
        }
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
        
    }
    
    @IBAction func Submit(_ sender: Any) {
        ud.set(self.txtDoing.text, forKey: "Doing")
        
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func arrInit(_ sender: Any) {
        doing = []
        ud.set(try? PropertyListEncoder().encode(doing), forKey: "day")
    }
    
    
}
