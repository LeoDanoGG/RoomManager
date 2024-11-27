import Foundation
/// Contiene valores para reservar las salas de reunion
class Room {
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
            return "Reserved."
        } else {
            return "Free."
        }
    }
    /// Formatea la fecha
    func RoomDateFormat(room: Room) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy HH:mm"
        let dateString = dateFormatter.string(from: room.date)
        return dateString
    }
    /// Dicta los participantes
    func DictPeople(room: Room) -> String {
        var text = "\n\tOccupied by: "
        for i in 0...room.people.count {
            if room.people.isEmpty {
                text = ""
            }
            else {
                if i <= room.people.count-2 {
                    text += room.people[i] + ", "
                } else if people.count > 3 {
                    text += "..."
                    break
                } else if i == room.people.count-1 {
                    text += room.people[i] + "."
                    break
                }
            }
        }
        return text
    }
}

