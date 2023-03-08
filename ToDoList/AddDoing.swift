import UIKit

class AddDoing : UIViewController {
    let ud = UserDefaults.standard
    
    @IBOutlet var lblTest: UILabel!
    
    
    @IBAction func DatePicker(_ sender: UIDatePicker) {
        let DatePick = sender
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM월 dd일"
        
        let StringDate = dateFormat.string(from: DatePick.date)
        ud.set(StringDate, forKey: "DatePick")
        
        lblTest.text = dateFormat.string(from: DatePick.date)
    }
    
    @IBAction func Submit(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
}
