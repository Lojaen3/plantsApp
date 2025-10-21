//
//  PlantViewModel.swift
//  plants
//
//  Created by Lojaen Jehad Ayash on 29/04/1447 AH.
//

import SwiftUI
import Combine

import Foundation

final class PlantViewModel: ObservableObject {
    @Published var plantName: String = ""
    @Published var room: String = "Bedroom"
    @Published var light: String = "Full Sun"
    @Published var watering: String = "Every day"
    @Published var waterAmount: String = "20-50 ml"

    @Published var plants: [Plant] = []
    @Published var showAddPlantSheet = false
    @Published var didAddPlant: Bool = false


    func addPlant() {
        let newPlant = Plant(
            name: plantName,
            room: room,
            light: light,
            watering: watering,
            waterAmount: waterAmount
        )

        plants.append(newPlant)
        didAddPlant = true
        clearFields()
        showAddPlantSheet.toggle()
    }

    private func clearFields() {
        plantName = ""
        room = ""
        light = ""
        watering = ""
        waterAmount = ""
    }
}
