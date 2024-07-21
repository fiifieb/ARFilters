//
//  ARView.swift
//  ARFilters
//
//  Created by Fiifi Botchway on 7/21/24.
//

import SwiftUI
import ARKit


struct ARView: UIViewRepresentable {
    func makeUIView(context: Context) -> ARSCNView {
        let arView = ARSCNView()
        arView.delegate = context.coordinator
        
        let configuration = ARWorldTrackingConfiguration()
        arView.session.run(configuration)
        
        return arView
    }

    func updateUIView(_ uiView: ARSCNView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, ARSCNViewDelegate {
        var parent: ARView

        init(_ parent: ARView) {
            self.parent = parent
        }

        func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
            guard let faceAnchor = anchor as? ARFaceAnchor else { return nil }
            let node = SCNNode()
            
            // Add 3D content 
            let hatNode = SCNNode(geometry: SCNSphere(radius: 0.1))
            hatNode.position = SCNVector3(faceAnchor.transform.columns.3.x, faceAnchor.transform.columns.3.y + 0.1, faceAnchor.transform.columns.3.z)
            node.addChildNode(hatNode)
            
            return node
        }
    }

}


#Preview {
    ARView()
}
