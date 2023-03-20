import UIKit

protocol TableViewCellDelegate: AnyObject {
    func didTapButton(cellIndex: Int?, button: UIButton?)
}

class MainDoingCell: UITableViewCell {
    var index: Int?
    
    weak var delegate: TableViewCellDelegate?
    
    @IBOutlet var btnCheck: UIButton!
    @IBOutlet var lblDoing: UILabel!
    
    @IBAction func onCheckButton(_ sender: UIButton) {
        self.delegate?.didTapButton(cellIndex: index, button: btnCheck)
    }
    
}
