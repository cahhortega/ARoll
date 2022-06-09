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
    @State var isPopUpOpen = false
    var arViewContainer = ARViewContainer()
    var body: some View {
        NavigationView {
            ZStack {
                ARViewContainer().ignoresSafeArea()
                VStack {
                    Text(" ")
                        .navigationBarItems(trailing:
                                                Button(action: {
                            print("Settings")
                            isPopUpOpen.toggle()
                        }, label: {
                            Text("Settings")
                                .foregroundColor(.blue)
                            Image(systemName: "gearshape.fill")
                                .foregroundColor(.blue)
                                .scaledToFit()
                        })
                        )
                    
                    
                }
                if isPopUpOpen {
                    PopUpComponent(isOpen: $isPopUpOpen)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct ARViewContainer: UIViewRepresentable {
    var button: UIButton = UIButton(type: .custom)
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
        
        //Adicionando toque
        arView.addSubview(button)
        button.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap)))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Roll! ", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 50
        button.titleLabel?.numberOfLines = 0
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.semanticContentAttribute = .forceRightToLeft
        
        button.setImage(UIImage(systemName: "dice.fill"), for: .normal)
        button.centerXAnchor.constraint(equalTo: arView.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: arView.centerYAnchor, constant: 300).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true

        

        return arView
        
    }
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, ARSessionDelegate {
        weak var view: ARView?
        var focusEntity: Entity?
        var diceEntity: ModelEntity?
        var planeId: UUID?
        var plane: AnchorEntity?
        
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            guard let view = self.view else { return }
            debugPrint("Ancoras adicionas na cena: ", anchors)
            self.focusEntity = FocusEntity(on: view, style: .classic(color: .yellow))
        }
        
        //Ação aparecer dado
        @objc func handleTap() {
            guard let view = self.view, let focusEntity = self.focusEntity else { return }
            
            if let diceEntity = self.diceEntity {
                // Rolagem do dado
                diceEntity.addForce([0, 4, 0], relativeTo: nil)
                diceEntity.addTorque([Float.random(in: 0 ... 0.4), Float.random(in: 0 ... 0.4), Float.random(in: 0 ... 0.4)], relativeTo: nil)
            } else {
                // Criando âncora
                let anchor = AnchorEntity()
                view.scene.anchors.append(anchor)
                
                // Adicionando o dado
                let number = UserDefaults().string(forKey: "number") ?? "4 faces"
                let diceEntity = try! ModelEntity.loadModel(named: "d\(number)-\(Dice.shared.colorDice)" )
                diceEntity.scale = [0.1, 0.1, 0.1]
                diceEntity.position = focusEntity.position
                
                // Adicionando a física
                let size = diceEntity.visualBounds(relativeTo: diceEntity).extents
                let boxShape = ShapeResource.generateBox(size: size)
                diceEntity.collision = CollisionComponent(shapes: [boxShape])
                diceEntity.physicsBody = PhysicsBodyComponent(massProperties: .init(shape: boxShape, mass: 50), material: nil, mode: .dynamic)
                
                // Adicionando o plano
                let planeMesh = MeshResource.generatePlane(width: 2, depth: 2)
                let material = SimpleMaterial(color: .init(white: 1, alpha: 0.1), isMetallic: false)
                let planeEntity = ModelEntity(mesh: planeMesh, materials: [material])
                planeEntity.position = focusEntity.position
                planeEntity.physicsBody = PhysicsBodyComponent(massProperties: .default, material: nil, mode: .static)
                planeEntity.collision = CollisionComponent(shapes: [.generateBox(width: 2, height: 0.001, depth: 2)])
                
                anchor.addChild(planeEntity)
                
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)
                
                
                self.diceEntity = diceEntity
                anchor.addChild(diceEntity)
            }
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
