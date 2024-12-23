![Build Status](https://icons.veryicon.com/128/System/Flat%20Retro%20Modern/rainbow%20apple%20logo.png)
# **ROOM MANAGER**
##### *Una app para gestionar reuniones*.
##### Developer: *Dano GG*
---
Una app que permite gestionar salas para hacer reuniones.
> La app está desarrollada en `Xcode` utilizando el lenguaje `Swift`.
Se compone de varias pantallas: la pantalla principal donde puedes ver la lista de salas (`MainScreenView`), una para mostrar todos los detalles de una sala, una para agregar una sala (`NewRoomView`) y una para reservar una sala (`ReserveRoomView`).

## Registros
Los registros que guardes se mostrarán con su nombre y Nº de sala, los ocupantes, su estado (libre o reservada) y su fecha de reserva.

## Objeto Room
Los registros se guardan mediante una clase llamada `Room`.
```
class Room : Codable {
    /* Atributos */
    var name: String = ""
    var number: Int = 0
    /// Participantes
    var people: [String] = []
    /// Fecha (Autocompletado)
    var date = Date()
    var reserved: Bool = false
    // Métodos de la clase
}
```
