import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // Atributos
    var RoomList: [Room] = [] // Lista de salas
    @IBOutlet weak var RoomTable: UITableView!
    // Métodos
    override func viewDidLoad() {
        super.viewDidLoad()
        StartRooms()
        RoomList.register(UITableViewCell.self, forCellReuseIdentifier: "RoomCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RoomList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomCell", for: indexPath)
                
                let model = RoomList[indexPath.row]
                
                var listContentConfiguration = UIListContentConfiguration.cell()
                listContentConfiguration.text = model.name
                
                cell.contentConfiguration = listContentConfiguration
                return cell
    }
    /// Listado de salas disponibles y reservadas inicial
    func StartRooms() {
        var room516 = Room(name: "Apps", number: 516, people: [], reserved: false)
        RoomList.append(room516)
        room516 = Room(name: "DAM", number: 408, people: ["Juan", "Javier"], reserved: true)
        RoomList.append(room516)
        room516 = Room(name: "Design", number: 311, people: ["Jessica"], reserved: false)
        RoomList.append(room516)
        room516 = Room(name: "Videogames 1", number: 520, people: [], reserved: true)
        RoomList.append(room516)
        
        //ListOfRooms(list: RoomManager)
    }/*
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
            list[numindex].reserved = true
            var i = 0
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
    /// Crea una nueva sala
    func NewRoom(list: [Room]) {
        var newNumber = -1
        var newName = ""
        var peopleList = [String]()
        // Validar el numero
        while true {
            print("Which is the room number?")
            newNumber = Validate(number: readLine()!)
            for n in 0...list.count-1 {
                if newNumber == list[n].number {
                    print("The room already exists.")
                    break
                }
            }
            if newNumber > 0 {
                break
            }
        }
        // Validar el nombre
        while true {
            print("Which is the room name?")
            newName = readLine()!
            if newName.isEmpty {
                print("It needs a name.")
            } else {
                break
            }
        }
        // Validar los ocupantes
        print("Who is going to be there?")
        var i = 0
        while true {
            i += 1
            print("Tell me the name(s) \(i):\n(Enter to skip)")
            guard let member = readLine(),
                  member.isEmpty == false else {
                break
            }
            peopleList.append(member)
            continue
        }
        var newRoom = Room(name: newName, number: newNumber, people: peopleList ,reserved: false)
        var new = list
        new.append(newRoom)
        RoomList(list: new)
    }
    /// Valida que el dato introducido por el usuario sea valido
    /// Devuelve el valor numerico
    func Validate(number: String) -> Int {
        if number.isEmpty {
            print("No value introduced.")
        } else {
            if number.contains(",") || number.contains(".") {
                print("Only integer. Try again.")
            } else {
                for n in number {
                    if n.isLetter || n.isSymbol {
                        print("I only accept numbers Try again.")
                    } else {
                        let num = Int(number)
                        return num ??  -1
                    }
                }
            }
        }
        return -1
    }
    /// Busca la sala especificada por numero o nombre
    /// Devuelve su posicion
    func Exists(input: String, list: [Room]) -> Int {
        for n in 0...list.count-1 {
            if input.lowercased() == list[n].name.lowercased() {
                return n
            } else if Int(input) == list[n].number {
                return n
            }
        }
        return -1
    }
     */
}
