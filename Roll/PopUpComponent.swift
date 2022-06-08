//
//  PopUpComponent.swift
//  Roll
//
//  Created by Carolina Ortega on 07/06/22.
//

import SwiftUI

struct PopUpComponent: View {
    @Binding var isOpen: Bool
    var dataArray = ["4 faces", "6 faces", "8 faces", "10 faces", "12 faces", "20 faces"]
    @State private var selectedDice = "4 faces"
    
    var body: some View {
        VStack {
            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 35.0)
                .padding(.bottom, 10.0)
            
            Text("Number of sides")
                .font(.title2)
                .fontWeight(.semibold)
                .lineLimit(0)
            //Spacer()
            Picker("Select the number of sides", selection: $selectedDice) {
                ForEach(dataArray, id: \.self) {
                    Text($0)
                }
            }
            Text("Dice Color")
                .font(.title2)
                .fontWeight(.semibold)
                .lineLimit(0)
            
            VStack (alignment: .center) {
                HStack(alignment: .center, spacing: 10) {
                    SquareColorComponent(color: .red) {
                        print("Red")
                    }
                    SquareColorComponent(color: .orange) {
                        print("Orange")
                    }
                    SquareColorComponent(color: .yellow) {
                        print("Yellow")
                    }
                    SquareColorComponent(color: .green) {
                        print("Green")
                    }
                    SquareColorComponent(color: .teal) {
                        print("Light blue")
                    }
                    
                }
                .padding(.horizontal, 35.0)
                HStack(alignment: .center, spacing: 10) {
                    
                    SquareColorComponent(color: .blue) {
                        print("Blue")
                    }
                    SquareColorComponent(color: .indigo) {
                        print("Indigo")
                    }
                    SquareColorComponent(color: .purple) {
                        print("Purple")
                    }
                    SquareColorComponent(color: .white) {
                        print("White")
                    }
                    SquareColorComponent(color: .black) {
                        print("Black")
                    }
                    
                }
                
                
            }
            .cornerRadius(5.0)
            
            
            
            Button("Back") {
                isOpen = false
            }
            .font(.title3)
            .padding()
            .frame(width: 100, height: 100, alignment: .center)
        }
        .frame(width: 300, height: 400, alignment: .center)
        .background(.white.opacity(0.8))
        .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
    }
}

struct PopUpComponent_Previews: PreviewProvider {
    static var previews: some View {
        PopUpComponent(isOpen: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}
