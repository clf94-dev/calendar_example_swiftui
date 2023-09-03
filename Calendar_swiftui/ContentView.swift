//
//  ContentView.swift
//  Calendar_swiftui
//
//  Created by Carmen Lucas on 3/9/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ZStack{
                Circle()
                    .foregroundStyle(.gray)
                    .opacity(0.5)
                Image(systemName: "calendar")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
            }.frame(width: 110)
            Text("Calendly course")
                .font(.title)
                .bold()
            
            Rectangle()
                .frame(height:1)
            VStack{
                Text("Select a Day")
                    .font(.title2)
                    .bold()
                
                HStack{
                    Spacer()
                    Button{
                            print("backwards")
                    } label:{
                        Image(systemName: "lessthan")
                            .resizable()
                            .scaledToFill()
                        .frame(width: 16, height: 28)
                    }
                    Spacer()
                    Text("September 2023")
                    Spacer()
                    Button{
                        
                    } label: {
                        Image(systemName: "greaterthan")
                            .resizable()
                            .scaledToFill()
                        .frame(width: 16, height: 28)
                    }
                    Spacer()
                }
            }
           
        }
        
    }
}

#Preview {
    ContentView()
}
