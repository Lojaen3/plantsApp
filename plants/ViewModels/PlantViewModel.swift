//
//  PlantViewModel.swift
//  plants
//
//  Created by Lojaen Jehad Ayash on 29/04/1447 AH.
//

import SwiftUI
import Combine

final class PlantViewModel: ObservableObject {
    // 🌱 النبتة الحالية (للإضافة أو التعديل)
    @Published var plant = Plant()

    // 🌿 جميع النباتات
    @Published var plants: [Plant] = []

    // 💧 النباتات التي تم ريّها
    @Published var wateredPlants: Set<UUID> = []

    // 🪴 حالات الواجهة
    //@Published var showAddPlantSheet = false
    @Published var didAddPlant = false
    @Published var showAllDone = false
    @Published var editingPlant: Plant?

    //  الحسابات
    var wateredCount: Int {
        wateredPlants.count
    }

    var progress: Double {
        guard !plants.isEmpty else { return 0 }
        return Double(wateredCount) / Double(plants.count)
    }

    var allDone: Bool {
        !plants.isEmpty && wateredCount == plants.count
    }

    // دوال CRUD

    /// إضافة نبتة جديدة
    func addPlant() {
        // إذا المستخدم كان يعدل نبتة، نحدثها بدل الإضافة
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index] = plant
        } else {
            plants.append(plant)
        }
        // ✅ تحديث الإشعارات تلقائيًا
        NotificationManager.shared.scheduleNotifications(for: plants)
        showAllDone = false
        didAddPlant = true
        resetPlant()
    }

    /// تحديث نبتة موجودة
    func updatePlant() {
        guard let index = plants.firstIndex(where: { $0.id == plant.id }) else { return }
        plants[index] = plant
    }

    /// حذف نبتة
    func deletePlant(_ plant: Plant) {
        plants.removeAll { $0.id == plant.id }
        // ✅ تحديث الإشعارات تلقائيًا بعد الحذف
            NotificationManager.shared.scheduleNotifications(for: plants)
    }

    /// بدء التعديل على نبتة
    func startEditing(_ existingPlant: Plant) {
        plant = existingPlant
        editingPlant = existingPlant
    }

    /// إعادة تعيين النبتة الحالية
    private func resetPlant() {
        plant = Plant() // يعيدها للوضع الافتراضي
        editingPlant = nil
    }

    // منطق الري
    func toggleWater(for plant: Plant) {
        if wateredPlants.contains(plant.id) {
            wateredPlants.remove(plant.id)
        } else {
            wateredPlants.insert(plant.id)
        }
        checkAllDone()
    }

    //  التحقق من اكتمال الري
    private func checkAllDone() {
        if allDone {
            withAnimation {
                showAllDone = true
                plants.removeAll()
                wateredPlants.removeAll()
                resetPlant()
            }
        }
    }
}
