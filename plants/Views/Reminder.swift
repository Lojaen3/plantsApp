//
//  ReminderView.swift
//  plants
//
//  Created by Lojaen Jehad Ayash on 29/04/1447 AH.
//

import SwiftUI

struct ReminderView: View {
    @EnvironmentObject var viewModel: PlantViewModel
    @State private var selectedPlant: Plant?
    @State private var showAddSheet = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.black.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 20) {
                // 🌱 العنوان
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
                    .frame(height: 1.5)
                    .background(Color.gray.opacity(0.3))

                if viewModel.showAllDone {
                    // 🎉 شاشة "All Done"
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
                    // 💧 النص حسب حالة الري
                    Text(viewModel.wateredCount == 0
                         ? "Your plants are waiting for a sip 💦"
                         : "\(viewModel.wateredCount) of your plants feel loved today ✨")
                        .foregroundColor(.white)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal)
                        .padding(.top, 4)

                    // 🔘 progress bar
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: 10)
                            
                            Capsule()
                                .fill(Color("neongreen"))
                                .frame(width: CGFloat(viewModel.progress) * geometry.size.width, height: 10)
                                .animation(.easeInOut, value: viewModel.progress)
                        }
                    }
                    .frame(height: 10)
                    .padding(.horizontal)
                    
                    // 🌿 قائمة النباتات
                    if viewModel.plants.isEmpty {
                        Spacer()
                        Text("No plants yet 🌱")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                            .font(.subheadline)
                            .frame(maxWidth: .infinity)
                        Spacer()
                    } else {
                        List {
                            ForEach(viewModel.plants) { plant in
                                PlantRowView(
                                    plant: plant,
                                    isWatered: viewModel.wateredPlants.contains(plant.id),
                                    onToggle: { viewModel.toggleWater(for: plant) },
                                    onDelete: { viewModel.deletePlant(plant) }
                                )
                                .listRowBackground(Color.black) // يخلي الخلفية سوداء مثل التصميم
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    selectedPlant = plant
                                    viewModel.startEditing(plant)
                                }

                            }
                            .listRowSeparator(.hidden)
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                    }


                    Spacer()
                }
            }

            // 🔘 زر الإضافة (+)
            Button(action: {
                showAddSheet.toggle()
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
            .sheet(isPresented: $showAddSheet) {
                SetReminderView()
                    .environmentObject(viewModel)
                    .onAppear {
                        viewModel.startAddingNewPlant() // ← هنا نهيئ نبتة جديدة فارغة
                }
            }
        }

        // ✏️ صفحة تعديل الريمايندر
        .sheet(item: $selectedPlant) { _ in
            EditReminderView()
                .environmentObject(viewModel)
        }
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - 🌿 Plant Row View
struct PlantRowView: View {
    var plant: Plant
    var isWatered: Bool
    var onToggle: () -> Void
    var onDelete: () -> Void // ✅ أضفنا هذا

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 12) {
                Button(action: { onToggle() }) {
                    Image(systemName: isWatered ? "checkmark.circle.fill" : "circle")
                        .resizable()
                        .frame(width: 26, height: 26)
                        .foregroundColor(isWatered ? Color("neongreen") : .gray)
                }
                .buttonStyle(.plain)
                
                VStack(alignment: .leading, spacing: 8) {
                    // 📍 الموقع
                    HStack(spacing: 4) {
                        Image(systemName: "location")
                            .foregroundColor(.gray)
                        Text("in \(plant.room.rawValue)")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }

                    // 🌿 اسم النبتة
                    Text(plant.name)
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.semibold)

                    // ☀️💧 الإضاءة والماء (جنب بعض)
                    HStack(spacing: 10) {
                        HStack(spacing: 4) {
                            Image(systemName: "sun.max")
                            Text(plant.light.rawValue)
                        }
                        .foregroundColor(.lightyellow)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color("darkgray"))
                        .cornerRadius(10)

                        HStack(spacing: 4) {
                            Image(systemName: "drop")
                            Text(plant.waterAmount.rawValue)
                        }
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
            .padding(.vertical,10)
            Divider()
                .frame(height: 1)
                .background(Color.gray.opacity(0.3))
                .padding(.top, 10)
        }
        // ✅ هنا السحب للحذف
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive, action: onDelete) {
                Label("Delete", systemImage: "trash")
            }
            .tint(.red)
        }
    }
}

#Preview {
    ReminderView()
        .environmentObject(PlantViewModel())
}
