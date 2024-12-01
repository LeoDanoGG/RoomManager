import UIKit
protocol RoomCellDelegate: AnyObject {
    func didTapReserveButton(in cell: RoomCellController)
}
class RoomCellController: UITableViewCell {
    @IBOutlet weak var roomNumber: UILabel!
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var roomState: UILabel!
    @IBOutlet weak var roomDate: UILabel!
    @IBOutlet weak var roomPeople: UILabel!
    @IBOutlet weak var roomReserve: UIButton!
    
    weak var delegate: RoomCellDelegate? // Delegado
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func reserveButtonTapped() {
            delegate?.didTapReserveButton(in: self)
        }
}
