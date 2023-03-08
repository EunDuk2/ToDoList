import UIKit

class AddDoing : UIViewController {
    let ud = UserDefaults.standard
    
    @IBOutlet var txtDoing: UITextField!
    
    @IBAction func DatePicker(_ sender: UIDatePicker) {
        let DatePick = sender
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM월 dd일"
        
        let StringDate = dateFormat.string(from: DatePick.date)
        ud.set(StringDate, forKey: "DatePick")
        
    }
    
    @IBAction func Submit(_ sender: Any) {
        ud.set(self.txtDoing.text, forKey: "Doing")
        
        self.presentingViewController?.dismiss(animated: true)
    }
    
}
