import UIKit
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, RoomCellDelegate {
    // Atributos
    var RoomList: [Room] = [
        Room(name: "Apps", number: 516, people: [], reserved: false),
        Room(name: "DAM", number: 408, people: ["Juan", "Javier", "Sergio", "Carlos"], reserved: true),
        Room(name: "Design", number: 311, people: ["Jessica"], reserved: false),
        Room(name: "Videogames 1", number: 520, people: [], reserved: true)
    ] // Lista de salas
    @IBOutlet weak var OnlyFreeRooms: UIButton!
    @IBOutlet weak var AddRoomButton: UIButton!
    var filtered: Bool = false
    @IBOutlet weak var RoomTable: UITableView!
    /* Métodos */
    // Conteo de celdas a mostrar
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return RoomList.count }
    // Celdas con datos
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomCell", for: indexPath) as! RoomCellController
        let room = RoomList[indexPath.row]
        cell.roomNumber?.text = "\(room.number)"
        cell.roomName?.text = room.name
        cell.roomState?.text = room.ShowState(room: RoomList[indexPath.item])
        cell.roomState?.textColor = room.reserved ? .red : .green
        // Si no se puede reservar
        if room.reserved {
            cell.roomDate?.text = room.RoomDateFormat(room: RoomList[indexPath.item])
        }
        cell.roomPeople?.text = room.DictPeople(room: RoomList[indexPath.item])
        cell.roomReserve?.isHidden = room.reserved
        // Asigna el delegado
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Obtener la sala seleccionada usando el índice de la fila
        let selectedRoom = RoomList[indexPath.row]
        
        // Realizar el segue pasando la sala seleccionada y su índice
        performSegue(withIdentifier: "ShowCellDetail", sender: (room: selectedRoom, index: indexPath.row))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Guardar los datos actualizados
        saveRoomsToFile(rooms: RoomList)
        RoomList = loadRoomsFromFile() // Recargar la lista
        RoomTable.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        RoomTable.register(UINib(nibName: "RoomCellController", bundle: nil), forCellReuseIdentifier: "RoomCell")
        RoomTable.delegate = self
        RoomTable.dataSource = self
        StartRooms()
    }
    /// Listado de salas disponibles y reservadas inicial
    func StartRooms() {
        // Intentar cargar los datos desde un archivo JSON
        RoomList = loadRoomsFromFile()
        RoomList.sort { $0.number < $1.number }
        RoomTable.reloadData()
    }
    /// Alternar entre filtar salas disponibles
    @IBAction func ToggleFreeRooms(_ sender: UIButton) {
        filtered.toggle() // Alternar entre filtrado y no filtrado
        if filtered {
            // Filtrar salas libres
            RoomList = RoomList.filter { !$0.reserved }
            OnlyFreeRooms.setTitle("Show all Rooms", for: .normal)
        } else {
            // Recargar todas las salas
            RoomList = loadRoomsFromFile()
            OnlyFreeRooms.setTitle("Show free Rooms", for: .normal)
        }
        RoomTable.reloadData()
    }
    /// Cambiar a pantalla de agregar sala
    @IBAction func GoToAddRoom(_ sender: UIButton) {
        GoToAddRoom()
    }
    func GoToAddRoom() {
        performSegue(withIdentifier: "AddRoom", sender: nil)
    }
    func didTapReserveButton(in cell: RoomCellController) {
        if let indexPath = RoomTable.indexPath(for: cell) {
            let selectedRoom = RoomList[indexPath.row]
            performSegue(withIdentifier: "ReserveRoom", sender: (room: selectedRoom, index: indexPath.row))
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ReserveRoom",
           let destinationVC = segue.destination as? ReserveRoomViewController,
           let data = sender as? (room: Room, index: Int) {
            destinationVC.selectedRoom = data.room
            destinationVC.index = data.index
            destinationVC.RoomList = RoomList // Pasar la lista completa si es necesario
        }
        else if segue.identifier == "ShowCellDetail",
                let destinationVC = segue.destination as? DetailRoomVController,
                let data = sender as? (room: Room, index: Int) {
            destinationVC.selectedRoom = data.room
            destinationVC.index = data.index
            destinationVC.RoomList = RoomList // Pasar la lista completa si es necesario
        }
    }
}
