import UIKit

class DoingUpdate: UIViewController {
    var index:Int?
    var date: Int?
    var doing:[Day] = []
    let ud = UserDefaults.standard
    
    @IBOutlet var txtUpdate: UITextField!
    
    override func viewDidLoad() {
        
        getSavedData()
    }
    
    func getSavedData() {
        doing = getDoing()
        
        txtUpdate.text = doing[date!].doingList[index!]
    }
    
    func getDoing() -> [Day] {
        guard let savedData = ud.value(forKey: "day") as? Data,
                    let loadDoing = try? PropertyListDecoder().decode([Day].self, from: savedData) else { return [] }
                    return loadDoing
    }
    
    
    @IBAction func onUpdate(_ sender: Any) {
        if let temp = txtUpdate.text {
            doing[date!].doingList[index!] = temp
        }
        
        ud.set(try? PropertyListEncoder().encode(doing), forKey: "day")
        
        self.presentingViewController?.dismiss(animated: true)
    }
}
