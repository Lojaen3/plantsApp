//
//  SetReminder.swift
//  plants
//
//  Created by Lojaen Jehad Ayash on 28/04/1447 AH.
//

import SwiftUI

struct SetReminderView: View {
    @State private var plantName: String = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Set Reminder")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)

                // Placeholder for future content
                HStack { }
                    .frame(width: 388, height: 59)

                Spacer()
            }
            .padding(.top, 30)
            .padding(.horizontal)
            .background(Color.darkGray)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                // ❌ زر الإغلاق على اليسار
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        // أكشن عند الضغط على الإكس (مثلاً إغلاق الشاشة)
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                            .background(Circle().fill(Color.lightGray))
                    }
                }

                // ✅ زر الحفظ على اليمين
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        // أكشن عند الضغط على الصح (مثلاً حفظ التذكير)
                    }) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                            .background(Circle().fill(Color.lightGray))
                    }
                }
            }
        }
    }
}

#Preview {
    SetReminderView()
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
