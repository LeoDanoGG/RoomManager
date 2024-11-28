import UIKit
class NewRoomViewController : UIViewController {
    // Atributos
    var RoomList: [Room] = []
    var newNumber = -1
    var newName = ""
    var peopleList = [String]()
    var newState = false
    @IBOutlet weak var NewRoomName: UITextField!
    @IBOutlet weak var NewRoomNumber: UITextField!
    @IBOutlet weak var NewRoomPeople: UITextView!
    @IBOutlet weak var NewRoomState: UISwitch!
    @IBOutlet weak var Hint: UILabel!
    
    @IBOutlet weak var CheckParams: UIButton!
    // Métodos
    override func viewDidLoad() {
        super.viewDidLoad()
        RoomList = loadRoomsFromFile()
    }
    // Métodos pararegistrar los datos
    @IBAction func CheckNewValues(_ sender: UIButton) {
        Hint.text = ""
        newNumber = ValidateNumber(number: NewRoomNumber.text!)
        newName = ValidateName(name: NewRoomName.text!)
        newState = NewRoomState.isOn
        peopleList = ReadPeople(input: NewRoomPeople.text!)
        if (Hint.text == "") {
            NewRoom(list: RoomList)
            Hint.text = "The new room has been added."
        }
        // Esquema de la sala
        print("=================")
        print(newName)
        print(newNumber)
        print(newState)
        print("-----------------")
        print(peopleList)
        print("=================")
    }
    
    // Métodos para crear la sala
    /// Crea una nueva sala
    func NewRoom(list: [Room]) {
        var newRoom = Room(name: newName, number: newNumber, people: peopleList ,reserved: newState)
        var new = list
        new.append(newRoom)
    }
    /// Recoge a los ocupantes en una lista
    func ReadPeople(input: String) -> [String] {
        var peopleList = [String]()
        peopleList = input.split(separator: ", ").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        peopleList = input.split(separator: "\n").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        return peopleList
    }
    /// Valida que el dato introducido por el usuario sea valido
    /// Devuelve el valor numerico
    func ValidateNumber(number: String) -> Int {
        if number.isEmpty {
            Hint.text = ("No room number introduced.")
        } else {
            if number.contains(",") || number.contains(".") {
                Hint.text = ("Only integer. Try again.")
            } else {
                for n in number {
                    if n.isLetter || n.isSymbol {
                        Hint.text = ("Only numbers. Try again.")
                    } else {
                        for n in 0...RoomList.count-1 {
                            if Int(number)! == RoomList[n].number {
                                Hint.text = ("The room already exists.")
                                return -1
                            } else {
                                return Int(number)!
                            }
                        }
                        return Int(number)!
                    }
                }
            }
        }
        return -1
    }
    /// Valida que el dato introducido por el usuario sea valido
    /// Devuelve el nombre
    func ValidateName(name: String) -> String {
        if name.isEmpty {
            Hint.text = ("It needs a name.")
        } else {
            return name
        }
        return name
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
}
