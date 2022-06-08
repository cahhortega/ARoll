//
//  ContentView.swift
//  pocPickerSwiftUI
//
//  Created by Carolina Ortega on 03/06/22.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedDice = "4 faces"
    var dataArray = ["4 faces", "6 faces", "8 faces", "10 faces", "12 faces", "20 faces"]

    var body: some View {
        VStack(alignment: .center) {
            Picker("Selecione o número de faces", selection: $selectedDice) {
                ForEach(dataArray, id: \.self) {
                    Text($0)
                }
            }
            .padding(.horizontal, 100.0)
            .padding(.vertical, 10)
        }
            .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.937))
            .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
            .accentColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
            .offset(y: -340)
            
            
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
