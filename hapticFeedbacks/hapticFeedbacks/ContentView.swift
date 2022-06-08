//
//  ContentView.swift
//  hapticFeedbacks
//
//  Created by Carolina Ortega on 03/06/22.
//

import SwiftUI

func simpleSuccess() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.error)
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "dice.fill")
                .padding(.bottom, 1.0)
                .foregroundColor(Color.white)
            Text("Roll!")
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .onTapGesture(perform: simpleSuccess)
                .foregroundColor(Color.white)
        }
        .padding(.horizontal, 22.0)
        .padding(.vertical, 15.0)
        .background(Color.blue)
        .cornerRadius(/*@START_MENU_TOKEN@*/40.0/*@END_MENU_TOKEN@*/)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
