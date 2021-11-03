//
//  Watch_Video1.swift
//  first_build_mongmong
//
//  Created by HyokJun Won on 2021/10/07.
//

import SwiftUI
import AVKit
import MediaPlayer

struct Watch_Video1: View {
    @State var homeView = false
    @State var nextView = false
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            //Main page and next page button
            Button(action: {
                playSound2(sound: "Click", type: "mp3")
                audioPlayer?.stop()
                self.homeView.toggle()
            }) {
                Image("home_view")
                    .scaleEffect(0.3)
            }
            .fullScreenCover(isPresented: $homeView) {
                MainView()
                
            }
            .onAppear(perform: {
                playSound(sound: "Bell_Bgm", type: "mp3")
                
            })
            .offset(x: -350, y: -140)
            .zIndex(1.2)
            
            Button(action: {
                playSound2(sound: "Click", type: "mp3")
                audioPlayer?.stop()
                self.nextView.toggle()
            }) {
                Image("next_view")
                    .scaleEffect(0.4)
            }
            .fullScreenCover(isPresented: $nextView) {
                Watch2()
            }
            .offset(x: 350, y: 150)
            .zIndex(1.2)
            
            VideoPlayer()
                .scaleEffect(1.1)
        }

    }
}


struct VideoPlayer: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<VideoPlayer>) {
    }
    
    func makeUIView(context: Context) -> UIView {
        let loopPlayer = LoopingPlayerUIView(frame: .zero)
        loopPlayer.play()
        
        return loopPlayer
    }
    
    func stopUIView(context: Context) -> UIView {
        let stopPlayer = LoopingPlayerUIView(frame: .zero)
        stopPlayer.stop()
        
        return stopPlayer
    }
}


class LoopingPlayerUIView: UIView {
    let playerLayer = AVPlayerLayer()
    var playerLooper: AVPlayerLooper?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Load the resource
        let fileUrl = Bundle.main.url(forResource: "Bell", withExtension: "mp4")!
        let asset = AVAsset(url: fileUrl)
        let item = AVPlayerItem(asset: asset)
        
        // Setup the player
        let player = AVQueuePlayer()
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        
        // Create a new player looper with the queue player and template item
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
//        playerLooper
        // Start the movie
    }
    
    func play() {
        self.playerLayer.player?.play()
    }
    
    func pause() {
        self.playerLayer.player?.pause()
    }
    
    func stop() {
        self.playerLayer.player?.pause()
        self.playerLayer.player?.seek(to: CMTime.init(seconds: 0, preferredTimescale: 1))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    
    override func removeFromSuperview() {
        playerLayer.player?.pause()
    }
}
