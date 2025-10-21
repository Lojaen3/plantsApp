//
//  Plant.swift
//  plants
//
//  Created by Lojaen Jehad Ayash on 29/04/1447 AH.

import Foundation

struct Plant: Identifiable, Codable {
    let id: UUID = .init()
    var name: String
    var room: String
    var light: String
    var watering: String
    var waterAmount: String
}
