 //
 //  ContentView.swift
 //  first_build_mongmong
 //
 //  Created by HyokJun Won on 2021/09/09.
 //
 
 import SwiftUI
 import AVKit
 
 struct ContentView: View {
    @State var audioPlayer: AVAudioPlayer!
    
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
                NavigationLink( destination: Watch_Video1()){
                    Text("Watch Scene 4")
                }
                NavigationLink( destination: Watch_Video2()){
                    Text("Watch Scene 5")
                }
            }
        }
        
        //make the background audio
        .onAppear {
            let sound = Bundle.main.path(forResource: "none", ofType: "mp3")
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            self.audioPlayer.volume = 0.8
            self.audioPlayer.play()
        }
    }
}
