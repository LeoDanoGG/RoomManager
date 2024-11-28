import UIKit
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
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
    // Métodos
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return RoomList.count }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomCell", for: indexPath) as! RoomCellController
        let room = RoomList[indexPath.row]
        
        cell.roomNumber?.text = "\(room.number)"
        cell.roomName?.text = room.name
        cell.roomState?.text = room.ShowState(room: RoomList[indexPath.item])
        if room.reserved {
            cell.roomState?.textColor = .red
        } else {
            cell.roomState?.textColor = .green
        }
        if room.reserved {
            cell.roomDate?.text = room.RoomDateFormat(room: RoomList[indexPath.item])
        }
        cell.roomPeople?.text = room.DictPeople(room: RoomList[indexPath.item])
        
        // Configuración de botón (ejemplo)
        cell.roomReserve?.isHidden = room.reserved
        
        return cell
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Guardar los datos actualizados
        saveRoomsToFile(rooms: RoomList)
        RoomList = loadRoomsFromFile() // Recargar la lista para sincronización
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
    /*
    /// Metodo para reservar una sala
    func RoomSelector(list: [Room]) {
        var freeList = [String] ()
        for r in list {
            if !r.reserved {
                freeList.append(String(r.number) + " (\(r.name))")
            }
        }
        print("Which room do you want to reserve?\nFree: \(freeList)") // Muestra solo las salas libres
        var index: String = readLine()! // Captura el dato introducido por el usuario
        var numindex = Exists(input: index, list: list)
        if numindex > -1 {
            list[numindex].reserved = true            var i = 0
            var peopleList = [String]()
            // Si la sala esta vacia
            if list[numindex].people.isEmpty {
                print("Who has reserved?")
                while true {
                    i += 1
                    print("Tell me the name(s) \(i):\n(Enter for skip)")
                    guard let member = readLine(),
                          member.isEmpty == false else {
                        break
                    }
                    peopleList.append(member)
                    continue
                }
                list[numindex].people = peopleList
                RoomList(list: list)
            // Si la sala esta ocupada
            } else {
                print("You have reserved the room, but someone is there.\nDo you want to evacuate the room?")
                var answer = readLine()!
                // Si se decide evacuar la sala
                if answer.first?.uppercased() == "S" {
                    print("In process...")
                    list[numindex].people = [] // vacia la lista de ocupantes
                    sleep(1)
                    RoomList(list: list)
                // Reserva sin vaciar la lista de ocupantes
                } else {
                    RoomList(list: list)
                }
            }
        }
    }
    
    /// Listado de salas registradas
    func ListOfRooms(list: [Room]) {
        print("List of saved rooms:")
        for s in list {
            var text: String = "-" + String(s.number) + " (\(s.name))" + "\n\tState: " + s.ShowState(room: s) + s.DictPeople(room: s)
            if s.reserved {
                text += "\n\t" + s.RoomDateFormat(room: s)
            }
            print(text)
        }
        print("Do you want to reserve one of the rooms?")
        var answer = readLine()!
        if answer.first?.uppercased() == "S" {
            RoomSelector(list: list)
        }
        print("Do you want to add one room?")
        answer = readLine()!
        if answer.first?.uppercased() == "S" {
            NewRoom(list: list)
        }
    }
    */
}
