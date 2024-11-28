import UIKit
class NewRoomViewController : UIViewController {
    // Atributos
    var RoomList: [Room] = []
    @IBOutlet weak var NewRoomName: UITextField!
    @IBOutlet weak var NewRoomNumber: UITextField!
    @IBOutlet weak var NewRoomPeople: UITextView!
    @IBOutlet weak var Hint: UILabel!
    
    @IBOutlet weak var CheckParams: UIButton!
    // Métodos
    override func viewDidLoad() {
        super.viewDidLoad()
        Hint.text = ""
    }
    /// Crea una nueva sala
    func NewRoom(list: [Room]) {
        var newNumber = -1
        var newName = ""
        var peopleList = [String]()
        // Validar el numero
            newNumber = Validate(number: readLine()!)
            for n in 0...list.count-1 {
                if newNumber == list[n].number {
                    Hint.text = ("The room already exists.")
                    break
                }
            }
            if newNumber > 0 { }
        // Validar el nombre
        newName = readLine()!
        if newName.isEmpty {
            Hint.text = ("It needs a name.")
        } else { }
        // Validar los ocupantes
        var i = 0
        while true {
            i += 1
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
}
