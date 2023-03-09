import UIKit

class AddDoing : UIViewController {
    var doing:[Day] = []
    var stringDate: String = ""
    var dateKey: String = ""
    
    let ud = UserDefaults.standard
    var arr:[String] = []
    
    @IBOutlet var txtDoing: UITextField!
    
    @IBOutlet var lblList: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        
//        if let DoingList = ud.stringArray(forKey: "arr") {
//            var List: String = ""
//            for i in 0..<DoingList.count {
//                List += (DoingList[i] + "\n")
//            }
//            lblList.text = List
//        }
        
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
    
    @IBAction func DatePicker(_ sender: UIDatePicker) {
        let DatePick = sender
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM월 dd일"
        
        stringDate = dateFormat.string(from: DatePick.date)
        
        dateFormat.dateFormat = "yyyyMMdd"
        dateKey = dateFormat.string(from: DatePick.date)
        
        //ud.set(stringDate, forKey: "DatePick")
        outputDoing()
    }
    
    
    @IBAction func onAdd(_ sender: Any) {
//        if let arr = ud.stringArray(forKey: "arr") {
//            self.arr = arr
//        }
//        arr.append(txtDoing.text!)
//
//        ud.set(arr, forKey: "arr")
//
//        viewWillAppear(true)
        
//        for i in 0..<doing.count {
//            if (checkKey(i: i) == true) {
//                    doing[i].addDoing(Doing: txtDoing.text!)
//            } else if (i == doing.count-1) {
//                doing.append(Day(key: dateKey, date: stringDate))
//                doing[i].addDoing(Doing: txtDoing.text!)
//            }
//        }
        let i = checkKey()
        if (i != -1) {
            doing[i].addDoing(Doing: txtDoing.text!)
        } else if (i == -1) {
            doing.append(Day(key: dateKey, date: stringDate))
            doing[doing.count-1].addDoing(Doing: txtDoing.text!)
        }
        
        ud.set(try? PropertyListEncoder().encode(doing), forKey: "day")
        
        outputDoing()
        
    }
    
    @IBAction func Submit(_ sender: Any) {
        ud.set(self.txtDoing.text, forKey: "Doing")
        
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func arrInit(_ sender: Any) {
//        if var arr = ud.stringArray(forKey: "arr") {
//            arr = []
//            ud.set(arr, forKey: "arr")
//        }
        doing = []
        ud.set(try? PropertyListEncoder().encode(doing), forKey: "day")
    }
    
    
}
