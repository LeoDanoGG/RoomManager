import UIKit
class DetailRoomVController: UIViewController {
    // Atributos
    var RoomList = [Room]()
    var index: Int?
    var selectedRoom: Room?
    // Componentes
    @IBOutlet weak var roomNumber: UILabel!
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var roomState: UILabel!
    @IBOutlet weak var roomDate: UILabel!
    @IBOutlet weak var roomPeople: UITextView!
    @IBOutlet weak var roomReserve: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RoomList = loadRoomsFromFile()
        // Cargar datos de la sala seleccionada
        if selectedRoom != nil {
            if let room = selectedRoom {
                roomNumber.text = "\(room.GetNumber(room: room.self))"
                roomName.text = room.name
                roomState.text = room.ShowState(room: room.self)
                roomState.textColor = room.reserved ? .red : .green
                // Si no se puede reservar
                if room.reserved {
                    roomDate.text = room.RoomDateFormat(room: room.self)
                }
                roomPeople.text = room.ListPeople(room: room.self)
                roomReserve.isHidden = room.reserved
            }
        }
    }
    /// Lleva a la pantalla de reservar
    @IBAction func ReserveRoom(_ sender: UIButton) {
        Reserve()
    }
    func Reserve() {
        let selectedRoom = RoomList[index ?? 0]
            performSegue(withIdentifier: "ReserveRoom", sender: (room: selectedRoom, index: index))
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ReserveRoom",
           let destinationVC = segue.destination as? ReserveRoomViewController,
           let data = sender as? (room: Room, index: Int) {
            destinationVC.selectedRoom = data.room
            destinationVC.index = data.index
            destinationVC.RoomList = RoomList // Pasar la lista completa si es necesario
        }
    }
}

