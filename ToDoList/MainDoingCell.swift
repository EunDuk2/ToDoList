import UIKit

protocol TableViewCellDelegate: AnyObject {
    func didTapButton(index: Int?, button: UIButton?, isCheck: Bool?)
}

class MainDoingCell: UITableViewCell {
    var index: Int?
    var isCheck: Bool?
    
    weak var delegate: TableViewCellDelegate?
    
    @IBOutlet var btnCheck: UIButton!
    @IBOutlet var lblDoing: UILabel!
    
    @IBAction func onCheckButton(_ sender: UIButton) {
        self.delegate?.didTapButton(index: index, button: btnCheck, isCheck: isCheck)
    }
    
}
