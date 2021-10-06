 //
 //  ContentView.swift
 //  first_build_mongmong
 //
 //  Created by HyokJun Won on 2021/09/09.
 //
 
 import SwiftUI
 import AVKit
 
 struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink( destination: Watch1()){
                    Text("Watch Scene 1")
                }
                NavigationLink( destination: Watch2()){
                    Text("Watch Scene 2")
                }
                NavigationLink( destination: Watch3()){
                    Text("Watch Scene 3")
                }
            }
        }
        
        
        //make the background audio
//        .onAppear(perform: {
//            playSound(sound: "wave", type: "mp3")
//        })
    }
    
}
