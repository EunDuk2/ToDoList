import UIKit

class AddDoing : UIViewController {
    let ud = UserDefaults.standard
    var arr:[String] = []
    
    @IBOutlet var txtDoing: UITextField!
    
    @IBOutlet var lblList: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let DoingList = ud.stringArray(forKey: "arr") {
            var List: String = ""
            for i in 0..<DoingList.count {
                List += (DoingList[i] + "\n")
            }
            lblList.text = List
        }
        
    }
    
    @IBAction func DatePicker(_ sender: UIDatePicker) {
        let DatePick = sender
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM월 dd일"
        
        let StringDate = dateFormat.string(from: DatePick.date)
        ud.set(StringDate, forKey: "DatePick")
        
    }
    
    
    @IBAction func onAdd(_ sender: Any) {
        if let arr = ud.stringArray(forKey: "arr") {
            self.arr = arr
        }
        arr.append(txtDoing.text!)
        
        ud.set(arr, forKey: "arr")
        
        viewWillAppear(true)
        
    }
    
    @IBAction func Submit(_ sender: Any) {
        ud.set(self.txtDoing.text, forKey: "Doing")
        
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func arrInit(_ sender: Any) {
        if var arr = ud.stringArray(forKey: "arr") {
            arr = []
            ud.set(arr, forKey: "arr")
        }
    }
    
    
}
