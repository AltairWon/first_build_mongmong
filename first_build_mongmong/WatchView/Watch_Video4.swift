//
//  Watch_Video4.swift
//  first_build_mongmong
//
//  Created by HyokJun Won on 2021/11/03.
//

import SwiftUI
import AVKit
import MediaPlayer

struct Watch_Video4: View {
    @State var homeView = false
    @State var nextView = false
//    @ObservedObject var status = VideoStatus()
    
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
                playSound(sound: "Water_Fall_Bgm", type: "mp3")
                
            })
            .offset(x: -400, y: -140)
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
                Watch_Video5()
            }
            .offset(x: 390, y: 150)
            .zIndex(1.2)
            
            VideoPlayer4()
                .scaleEffect(1.1)
        }

    }
}


struct VideoPlayer4: UIViewRepresentable {
//    @Binding var isPlaying: Bool
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<VideoPlayer4>) {
    }
    
    func makeUIView(context: Context) -> UIView {
        let loopPlayer = LoopingPlayerUIView4(frame: .zero)
        loopPlayer.play()
        
        return loopPlayer
    }
    
    func stopUIView(context: Context) -> UIView {
        let stopPlayer = LoopingPlayerUIView4(frame: .zero)
        stopPlayer.stop()
        
        return stopPlayer
    }
}


class LoopingPlayerUIView4: UIView {
    let playerLayer = AVPlayerLayer()
    var playerLooper: AVPlayerLooper?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Load the resource
        let fileUrl = Bundle.main.url(forResource: "Water_Fall", withExtension: "mp4")!
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


