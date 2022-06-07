//
//  ContentView.swift
//  Roll
//
//  Created by Carolina Ortega on 07/06/22.
//

import SwiftUI
import RealityKit
import ARKit
import FocusEntity

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
        
        //Adicionando overlay
        let overlay = ARCoachingOverlayView()
        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlay.session = session
        overlay.goal = .horizontalPlane
        arView.addSubview(overlay)
        
        //Implementando o delegate
        context.coordinator.view = arView
        session.delegate = context.coordinator
        
        return arView
        
    }
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, ARSessionDelegate {
        weak var view: ARView?
        var focusEntity: FocusEntity?

        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            guard let view = self.view else { return }
            debugPrint("Âncoras na cena: ", anchors)
            self.focusEntity = FocusEntity(on: view, style: .classic(color: .yellow))
        }
    }
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
