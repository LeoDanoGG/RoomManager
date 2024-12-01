import Foundation
extension Room {}
/* Funciones para gestionar listas */
/// Guarda los datos
func saveRoomsToFile(rooms: [Room]) {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    if let encodedData = try? encoder.encode(rooms) {
        let fileURL = getDocumentsDirectory().appendingPathComponent("rooms.json")
        try? encodedData.write(to: fileURL)
    }
}
/// Carga los datos
func loadRoomsFromFile() -> [Room] {
    let fileURL = getDocumentsDirectory().appendingPathComponent("rooms.json")
    if let data = try? Data(contentsOf: fileURL) {
        let decoder = JSONDecoder()
        if let decodedRooms = try? decoder.decode([Room].self, from: data) {
            return decodedRooms
        }
    }
    // Si no hay archivo, inicializa con datos predeterminados
    return [
        Room(name: "Apps", number: 516, people: [], reserved: false),
        Room(name: "DAM", number: 408, people: ["Juan", "Javier", "Sergio", "Carlos"], reserved: true),
        Room(name: "Design", number: 311, people: ["Jessica"], reserved: false),
        Room(name: "Videogames 1", number: 520, people: [], reserved: true)
    ]
}
/// Obtiene la URL de guardado
func getDocumentsDirectory() -> URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
}

/// Contiene valores para reservar las salas de reunion
class Room : Codable {
    /* Atributos */
    var name: String = ""
    var number: Int = 0
    /// Participantes
    var people: [String] = []
    /// Fecha (Autocompletado)
    var date = Date()
    var reserved: Bool = false
    
    /* Contructores */
    init() {
        // Constructor vacio
    }
    init(name: String, number: Int, people: [String], date: Date = Date(), reserved: Bool) {
        // Constructor parametrizado
        self.name = name
        self.number = number
        self.people = people
        self.date = date
        self.reserved = reserved
    }
    
    /* Funciones propias */
    /// Muestra el estado libre o reservada
    func ShowState(room: Room) -> String {
        if room.reserved {
            return "Reserved"
        } else {
            return "Free"
        }
    }
    /// Formatea la fecha
    func RoomDateFormat(room: Room) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy HH:mm"
        var dateString = ""
        if reserved { dateString = dateFormatter.string(from: room.date) }
        return dateString
    }
    /// Dicta los participantes
    func DictPeople(room: Room) -> String {
        var text = "Occupied by:\n"
        for i in 0...room.people.count {
            if room.people.isEmpty {
                text += "Anyone."
            }
            else {
                if i <= room.people.count-2 {
                    text += room.people[i] + ", "
                } else if people.count > 3 {
                    text += "... +\(room.people.count-3)"
                    break
                } else if i == room.people.count-1 {
                    text += room.people[i] + "."
                    break
                }
            }
        }
        return text
    }
    /// Dicta los participantes
    func ListPeople(room: Room) -> String {
        var text = ""
        for i in 0...room.people.count {
            if room.people.isEmpty {
                text += "Anyone."
            }
            else {
                if i <= room.people.count-2 { text += room.people[i] + ", \n" }
                else if i == room.people.count-1 {
                    text += room.people[i] + "."
                    break
                }
            }
        }
        return text
    }
    func GetNumber(room: Room) -> Int {
        return room.number
    }
}

