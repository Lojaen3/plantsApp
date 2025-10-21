//
//  ReminderView.swift
//  plants
//
//  Created by Lojaen Jehad Ayash on 29/04/1447 AH.
//

import SwiftUI

struct ReminderView: View {
    @EnvironmentObject var viewModel: PlantViewModel
    @State private var wateredPlants: Set<UUID> = []

    // عدد النباتات المسقاة
    var wateredCount: Int {
        wateredPlants.count
    }

    // نسبة التقدم
    var progress: Double {
        guard !viewModel.plants.isEmpty else { return 0 }
        return Double(wateredCount) / Double(viewModel.plants.count)
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 20) {
                
                // العنوان
                HStack {
                    Text("My Plants 🌱")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)

                Divider()
                    .frame(height: 2)
                    .background(Color.gray.opacity(0.3))

                // النص المتغير حسب الري
                Text(wateredCount == 0 ?
                     "Your plants are waiting for a sip 💦" :
                        "\(wateredCount) of your plants feel loved today ✨")
                    .foregroundColor(.white)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal)
                    .padding(.top, 4)

                // progress bar
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 10)
                    Capsule()
                        .fill(Color("neongreen"))
                        .frame(width: CGFloat(progress) * UIScreen.main.bounds.width * 0.9, height: 10)
                        .animation(.easeInOut, value: progress)
                }
                .padding(.horizontal)

                // قائمة النباتات
                if viewModel.plants.isEmpty {
                    Spacer()
                    Text("No plants yet 🌱\nAdd some from Set Reminder!")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity)
                    Spacer()
                } else {
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(viewModel.plants) { plant in
                                PlantRowView(
                                    plant: plant,
                                    isWatered: wateredPlants.contains(plant.id),
                                    onToggle: {
                                        if wateredPlants.contains(plant.id) {
                                            wateredPlants.remove(plant.id)
                                        } else {
                                            wateredPlants.insert(plant.id)
                                        }
                                    }
                                )
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                    }
                }

                Spacer()
            }
        }
    }
}

// MARK: - Plant Row View
struct PlantRowView: View {
    var plant: Plant
    var isWatered: Bool
    var onToggle: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            // الموقع
            Label("in \(plant.room)", systemImage: "location")
                .foregroundColor(.gray)
                .font(.subheadline)

            HStack {
                // زر الري
                Button(action: { onToggle() }) {
                    Image(systemName: isWatered ? "checkmark.circle.fill" : "circle")
                        .resizable()
                        .frame(width: 22, height: 22)
                        .foregroundColor(isWatered ? Color("neongreen") : .gray)
                }

                // اسم النبتة
                Text(plant.name)
                    .foregroundColor(.white)
                    .font(.title3)
                    .fontWeight(.semibold)

                Spacer()
            }

            // تفاصيل الضوء والماء
            HStack(spacing: 10) {
                Label {
                    Text(plant.light)
                        .foregroundColor(.lightyellow)
                } icon: {
                    Image(systemName: "sun.max")
                        .foregroundColor(.lightyellow)
                }
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color(hex: "#2C2C2E"))
                .cornerRadius(8)

                Label {
                    Text(plant.waterAmount)
                        .foregroundColor(.lightblue)
                } icon: {
                    Image(systemName: "drop")
                        .foregroundColor(.lightblue)
                }
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color(hex: "#2C2C2E"))
                .cornerRadius(8)
            }
        }
        .padding(.vertical, 6)
        .overlay(
            Divider()
                .background(Color.gray.opacity(0.3))
                .padding(.top, 45),
            alignment: .bottom
        )
    }
}

#Preview {
    ReminderView()
        .environmentObject(PlantViewModel())
}
