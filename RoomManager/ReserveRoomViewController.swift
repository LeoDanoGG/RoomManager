import UIKit

class ReserveRoomViewController: UIViewController {
    // Atributos
    var RoomList = [Room]()
    var index: Int?
    var selectedRoom: Room?
    // Componentes
    @IBOutlet weak var RoomNumber: UITextField!
    @IBOutlet weak var RoomName: UITextField!
    @IBOutlet weak var PeopleList: UITextView!
    @IBOutlet weak var Hint: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RoomList = loadRoomsFromFile()
        // Cargar datos de la sala seleccionada
        if let room = selectedRoom {
            RoomNumber.text = "\(room.number)"
            RoomName.text = room.name
            PeopleList.text = room.ListPeople(room: room.self)
        }
    }
    
    // Volver a la pantalla principal
    @IBAction func GoHome(_ sender: UIButton) {
        GoHome()
    }
    
    func GoHome() {
        performSegue(withIdentifier: "HomeFromReserve", sender: nil)
    }
    
    // Reservar una sala
    @IBAction func Reserve(_ sender: UIButton) {
        guard let index = index else { return }
        
        // Actualizar el estado de la sala en la lista
        RoomList[index].reserved = true
        RoomList[index].people = selectedRoom?.people ?? [] // Actualizar ocupantes si aplica
        
        // Guardar los cambios
        saveRoomsToFile(rooms: RoomList)
        
        // Actualizar el mensaje de confirmación
        Hint.text = "The room \(RoomList[index].number) (\(RoomList[index].name)) has been reserved."
    }
}
