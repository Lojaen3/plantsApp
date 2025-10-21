//
//  SetReminderView.swift
//  plants
//
//  Created by Lojaen Jehad Ayash on 28/04/1447 AH.
//

import SwiftUI

struct SetReminderView: View {
    @EnvironmentObject var viewModel: PlantViewModel
    @Environment(\.dismiss) var dismiss
    
    let rooms = ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"]
    let lightOptions = ["Full Sun", "Partial Sun", "Low Light"]
    let wateringOptions = [
        "Every day", "Every 2 days", "Every 3 days",
        "Once a week", "Every 10 days", "Every 2 weeks"
    ]
    let waterOptions = ["20-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 40) {
                    
                    // 🪴 Plant Name
                    HStack {
                        Text("Plant Name")
                            .foregroundColor(.white)
                        
                        TextField("", text: $viewModel.plantName)
                            .foregroundColor(Color("neongreen"))
                            .tint(Color("neongreen"))
                            .multilineTextAlignment(.leading)
                            .disableAutocorrection(true)
                    }
                    .padding()
                    .background(Color.lightGray)
                    .cornerRadius(25)
                    .padding(.top, 20)
                    
                    
                    // 🏡 Room , Light
                    VStack(spacing: 0) {
                        HStack {
                            Label("Room", systemImage: "location")
                                .foregroundColor(.white)
                            Spacer()
                            Picker("", selection: $viewModel.room) {
                                ForEach(rooms, id: \.self) { room in
                                    Text(room)
                                }
                            }
                            .pickerStyle(.menu)
                            .tint(.gray)
                        }
                        .padding(.vertical, 10)
                        
                        Divider().background(Color.gray.opacity(0.5))
                        
                        HStack {
                            Label("Light", systemImage: "sun.max")
                                .foregroundColor(.white)
                            Spacer()
                            Picker("", selection: $viewModel.light) {
                                ForEach(lightOptions, id: \.self) { option in
                                    Text(option)
                                }
                            }
                            .pickerStyle(.menu)
                            .tint(.gray)
                        }
                        .padding(.vertical, 10)
                    }
                    .padding(.horizontal)
                    .background(Color.lightGray)
                    .cornerRadius(20)
                    
                    // 💧 Watering Days, Water
                    VStack(spacing: 0) {
                        HStack {
                            Label("Watering Days", systemImage: "calendar")
                                .foregroundColor(.white)
                            Spacer()
                            Picker("", selection: $viewModel.watering) {
                                ForEach(wateringOptions, id: \.self) { option in
                                    Text(option)
                                }
                            }
                            .pickerStyle(.menu)
                            .tint(.gray)
                        }
                        .padding(.vertical, 10)
                        
                        Divider().background(Color.gray.opacity(0.5))
                        
                        HStack {
                            Label("Water Amount", systemImage: "drop")
                                .foregroundColor(.white)
                            Spacer()
                            Picker("", selection: $viewModel.waterAmount) {
                                ForEach(waterOptions, id: \.self) { option in
                                    Text(option)
                                }
                            }
                            .pickerStyle(.menu)
                            .tint(.gray)
                        }
                        .padding(.vertical, 10)
                    }
                    .padding(.horizontal)
                    .background(Color.lightGray)
                    .cornerRadius(20)
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .background(Color.darkGray.ignoresSafeArea())
            .navigationTitle("Set Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.darkGray, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                
                // ❌ Cancel
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color("darkgray"))
                }
                
                // ✅ Save
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        viewModel.addPlant()
                        dismiss()
                    }) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color("neongreen"))
                }
            }
        }
    }
}

#Preview {
    SetReminderView()
        .environmentObject(PlantViewModel())
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255.0
        let g = Double((int >> 8) & 0xFF) / 255.0
        let b = Double(int & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }

    static let lightGray = Color(hex: "#2C2C2E")
    static let darkGray = Color(hex: "#1C1C1E")
}
