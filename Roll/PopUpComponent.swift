//
//  PopUpComponent.swift
//  Roll
//
//  Created by Carolina Ortega on 07/06/22.
//

import SwiftUI

struct PopUpComponent: View {
    @Binding var isOpen: Bool
    var dataArray = ["4 sides", "6 sides", "8 sides", "10 sides", "12 sides", "20 sides"]
    @AppStorage("number") var selectedDice: String = "4 sides"
    
    var body: some View {
        VStack {
            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 35.0)
                .padding(.bottom, 10.0)
                .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
            
            Text("Number of sides")
                .font(.title2)
                .fontWeight(.semibold)
                .lineLimit(0)
                .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)

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
                .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)

            
            VStack (alignment: .center) {
                HStack(alignment: .center, spacing: 10) {
                    SquareColorComponent(color: .red) {
                        Dice.shared.colorDice = "red"
                        print("red")
                    }
                    SquareColorComponent(color: .orange) {
                        Dice.shared.colorDice = "orange"
                        print("orange")
                    }
                    SquareColorComponent(color: .yellow) {
                        Dice.shared.colorDice = "yellow"
                        print("yellow")
                    }
                    SquareColorComponent(color: .green) {
                        Dice.shared.colorDice = "green"
                        print("green")
                    }
                    SquareColorComponent(color: .teal) {
                        Dice.shared.colorDice = "teal"
                        print("teal")
                    }
                    
                }
                .padding(.horizontal, 35.0)
                HStack(alignment: .center, spacing: 10) {
                    
                    SquareColorComponent(color: .blue) {
                        Dice.shared.colorDice = "blue"
                        print("blue")
                    }
                    SquareColorComponent(color: .indigo) {
                        Dice.shared.colorDice = "indigo"
                        print("indigo")
                    }
                    SquareColorComponent(color: .purple) {
                        Dice.shared.colorDice = "purple"
                        print("purple")
                    }
                    SquareColorComponent(color: .white) {
                        Dice.shared.colorDice = "white"
                        print("white")
                    }
                    SquareColorComponent(color: .black) {
                        Dice.shared.colorDice = "black"
                        print("black")
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
