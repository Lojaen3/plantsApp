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
    @State private var showSetReminder = false
    @State private var showAllDone = false


    // عدد النباتات المسقاة
    var wateredCount: Int {
        wateredPlants.count
    }

    // نسبة التقدم
    var progress: Double {
        guard !viewModel.plants.isEmpty else { return 0 }
        return Double(wateredCount) / Double(viewModel.plants.count)
    }

    // هل كل النباتات تم ريّها؟
    var allDone: Bool {
        !viewModel.plants.isEmpty && wateredCount == viewModel.plants.count
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
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
                if showAllDone {
                    // شاشة All Done 🎉
                    VStack(spacing: 20) {
                        Spacer()
                        Image("plant2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 220, height: 220)
                        Text("All Done! 🎉")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text("All Reminders Completed")
                            .foregroundColor(.gray)
                            .font(.system(size: 19))
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.bottom, 60)

                } else {
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
                        Text("No plants yet 🌱")
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

            // 🔘 زر الإضافة (+)
            Button(action: {
                showSetReminder.toggle()
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 28))
                    .foregroundColor(.white)
                    .fontWeight(.medium)
            }
            .buttonStyle(.glassProminent)
            .tint(Color("neongreen"))
            .controlSize(.large)
            .clipShape(Circle())
            .padding(.trailing, 25)
            .padding(.bottom, 25)
            //show sheet
            .sheet(isPresented: $showSetReminder, onDismiss: {
                showAllDone = false
            }) {
                SetReminderView()
                    .environmentObject(viewModel)
            }

        }
        // 💡 هنا منطق إعادة التعيين بعد All Done
        .onChange(of: wateredPlants) {
                if wateredPlants.count == viewModel.plants.count && !viewModel.plants.isEmpty {
                    withAnimation {
                        showAllDone = true // نعرض شاشة All Done
                        viewModel.plants.removeAll()
                        wateredPlants.removeAll()
                    }
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
        HStack(alignment: .center, spacing: 12) {
            // الزر على اليسار
            Button(action: { onToggle() }) {
                Image(systemName: isWatered ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .frame(width: 26, height: 26)
                    .foregroundColor(isWatered ? Color("neongreen") : .gray)
            }

            // كل المعلومات على شكل عمود
            VStack(alignment: .leading, spacing: 6) {
                // الموقع
                Label("in \(plant.room)", systemImage: "location")
                    .foregroundColor(.gray)
                    .font(.subheadline)

                // اسم النبتة
                Text(plant.name)
                    .foregroundColor(.white)
                    .font(.title3)
                    .fontWeight(.semibold)

                // الضوء والماء
                HStack(spacing: 10) {
                    Label(plant.light, systemImage: "sun.max")
                        .foregroundColor(.lightyellow)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color("darkgray"))
                        .cornerRadius(10)

                    Label(plant.waterAmount, systemImage: "drop")
                        .foregroundColor(.lightblue)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color("darkgray"))
                        .cornerRadius(10)
                }
            }
            Spacer()
        }
        .padding(.vertical, 8)
        .overlay(
            Divider()
                .background(Color.gray.opacity(0.3)),
            alignment: .bottom
        )
    }
}

#Preview {
    ReminderView()
        .environmentObject(PlantViewModel())
}
