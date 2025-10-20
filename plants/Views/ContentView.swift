//
//  ContentView.swift
//  plants
//
//  Created by Lojaen Jehad Ayash on 27/04/1447 AH.

import SwiftUI

struct ContentView: View {
    @State private var isPresented: Bool = false
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                // Header
                VStack {
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
                    
                }
                
                Spacer()
                
                // Main content
                VStack(spacing: 30) {
                    VStack(spacing: 20) {
                        Image("plant")
                    }
                    
                    VStack(spacing: 20) {
                        Text("Start your plant journey!")
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        
                        Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                            .font(.system(size: 16))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 45)
                            .foregroundStyle(.gray)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    isPresented.toggle()
                    // Action for setting plant reminder
                }) {
                    Text("Set Plant Reminder")
                        .foregroundColor(.white )
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.neongreen)
                        .cornerRadius(25)
                        .padding(.horizontal, 50)
                    
                }
                .sheet(isPresented: $isPresented){
                    SetReminderView()
                }
                .padding(.bottom, 130)
                
            }
        }
    }
}
#Preview {
    ContentView()
}
