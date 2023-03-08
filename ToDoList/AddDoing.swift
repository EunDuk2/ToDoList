import UIKit

class AddDoing : UIViewController {
    let ud = UserDefaults.standard
    var arr:[String] = []
    
    @IBOutlet var txtDoing: UITextField!
    
    @IBOutlet var lblList: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        // let DatePick = ud.string(forKey: "DatePick")
//        let Doing = ud.string(forKey: "Doing")
//
//        lblList.text = Doing
        
        if let DoingList = ud.stringArray(forKey: "arr") {
            lblList.text = DoingList[4]
            // 여기까지 함
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
        
        // 옵셔널 바인딩
        if let DoingList = ud.stringArray(forKey: "arr") {
            lblList.text = DoingList[1]
        }
        
    }
    
    @IBAction func Submit(_ sender: Any) {
        ud.set(self.txtDoing.text, forKey: "Doing")
        
        self.presentingViewController?.dismiss(animated: true)
    }
    
}
