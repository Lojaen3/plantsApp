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
    
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 40) {
                    
                    // 🪴 Plant Name
                    HStack {
                        Text("Plant Name")
                            .foregroundColor(.white)
                        
                        TextField("", text: $viewModel.plant.name)
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
                            Picker("", selection: $viewModel.plant.room) {
                                ForEach(Room.allCases, id: \.self) { room in
                            Text(room.rawValue).tag(room)
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
                            Picker("", selection: $viewModel.plant.light) {
                                ForEach(Light.allCases, id: \.self) { option in
                                Text(option.rawValue).tag(option)
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
                            Label("Watering Days", systemImage: "drop")
                                .foregroundColor(.white)
                            Spacer()
                            Picker("", selection: $viewModel.plant.watering) {
                                ForEach(WateringFrequency.allCases, id: \.self) { option in
                                Text(option.rawValue).tag(option)
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
                            Picker("", selection: $viewModel.plant.waterAmount) {
                                ForEach(WaterAmount.allCases, id: \.self) { option in
                            Text(option.rawValue).tag(option)
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
                    Button(action: { dismiss() }) {
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
                        if viewModel.plant.name.trimmingCharacters(in: .whitespaces).isEmpty {
                            showAlert = true
                        } else {
                            viewModel.addPlant()
                            dismiss()
                        }
                    }) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color("neongreen"))
                }
            }
            .alert("Please enter a plant name", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
        }
    }
}


#Preview {
    SetReminderView()
        .environmentObject(PlantViewModel())
}

// Colors
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
