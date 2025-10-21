//
//  plantsApp.swift
//  plants
//
//  Created by Lojaen Jehad Ayash on 27/04/1447 AH.
//

import SwiftUI

@main
struct plantsApp: App {
    @StateObject var viewModel = PlantViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .preferredColorScheme(.dark)
        }
    }
}
