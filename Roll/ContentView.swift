//
//  ContentView.swift
//  Roll
//
//  Created by Carolina Ortega on 07/06/22.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView: View {
    var body: some View {
        return ARViewContainer().ignoresSafeArea()
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView()
        
        //Começar a sessão
        let session = arView.session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        session.run(config)
        
        //adicionando overlay
        let overlay = ARCoachingOverlayView()
        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlay.session = session
        overlay.goal = .horizontalPlane
        arView.addSubview(overlay)
        
        return arView
        
    }
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
