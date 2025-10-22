//
//  ContentView.swift
//  plants
//
//  Created by Lojaen Jehad Ayash on 27/04/1447 AH.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: PlantViewModel
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
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
                                .foregroundStyle(.oil)
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        isPresented.toggle()
                    }) {
                        Text("Set Plant Reminder")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                            .padding()
                            .frame(width:290, height: 40)
                    }
                    .buttonStyle(.glassProminent)
                    .tint(Color("neongreen"))
                    .sheet(isPresented: $isPresented) {
                        SetReminderView()
                            .environmentObject(viewModel)
                    }
                    .padding(.bottom, 130)
                }
            }
            //navigation
            .navigationDestination(isPresented: $viewModel.didAddPlant) {
                ReminderView()
                    .environmentObject(viewModel)
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(PlantViewModel())
}
