//
//  ContentView.swift
//  PersistenceAR
//
//  Created by Mohammad Azam on 6/12/22.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
    
    @StateObject private var vm = ViewModel()
    
    var body: some View {
        VStack {
            
            HStack {
                Text(vm.worldMapStatus.rawValue)
                    .font(.largeTitle)
            }.frame(maxWidth: .infinity, maxHeight: 60)
                .background(.blue)
            
            ARViewContainer(vm: vm).edgesIgnoringSafeArea(.all)
            HStack {
                Button("SAVE") {
                    vm.onSave()
                }.buttonStyle(.borderedProminent)
                
                Button("CLEAR") {
                    vm.onClear()
                }.buttonStyle(.bordered)
                
            }
        }.alert("ARWorldMap has been saved!", isPresented: $vm.isSaved) {
            Button(role: .cancel, action: { }) {
                Text("OK")
            }
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    let vm: ViewModel
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.onTap)))
        context.coordinator.arView = arView
        arView.session.delegate = context.coordinator
        
        vm.onSave = {
            context.coordinator.saveWorldMap()
        }
        
        vm.onClear = {
            context.coordinator.clearWorldMap()
        }
        
        context.coordinator.loadWorldMap()
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(vm: vm)
    }
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
