//
//  SquareColorComponent.swift
//  Roll
//
//  Created by Carolina Ortega on 07/06/22.
//

import SwiftUI

struct SquareColorComponent: View {
    @State var color: Color?
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Rectangle()
                .foregroundColor(color)
                .cornerRadius(5)
                .frame(width: 40, height: 40)
                
        }
    }
}

struct SquareColorComponent_Previews: PreviewProvider {
    static var previews: some View {
        SquareColorComponent(color: .red) {
            print("Clicou")
        }
    }
}
