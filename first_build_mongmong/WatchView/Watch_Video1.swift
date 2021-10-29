//
//  Watch_Video1.swift
//  first_build_mongmong
//
//  Created by HyokJun Won on 2021/10/07.
//

import SwiftUI
import AVKit
import MediaPlayer

class VideoStatus: ObservableObject {
//    var isPlaying = true {
//        didSet {
//            if isPlaying {
//                player?.player?.play()
//            } else {
//                player?.player?.pause()
//            }
//        }
//    }
//
//    var player: AVPlayerLayer?
//    var isPlaying = false
}

struct Watch_Video1: View {
    @State var homeView = false
    @State var nextView = false
//    @ObservedObject var status = VideoStatus()
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            //Main page and next page button
            Image("home_view")
                .scaleEffect(0.3)
                .offset(x: -360, y: -140)
                .onTapGesture {
                    playSound2(sound: "click", type: "mp3")
                    self.homeView.toggle()
                }
                .fullScreenCover(isPresented: $homeView) {
                    MainView()
                }
                .zIndex(1.2)

            Image("next_view")
                .scaleEffect(0.4)
                .offset(x: 360, y: 150)
                .onTapGesture {
                    playSound2(sound: "click", type: "mp3")
                    self.nextView.toggle()
                }
                .fullScreenCover(isPresented: $nextView) {
                    Watch2()
                }
                .zIndex(1.2)
            
            VideoPlayer()
                .scaleEffect(1.1)
            
            Button(action: {
                self.homeView.toggle()
            }) {
                Image("home_view")
                
            }
            .fullScreenCover(isPresented: $homeView) {
                MainView()
                
            }
        }

    }
}


struct VideoPlayer: UIViewRepresentable {
//    @Binding var isPlaying: Bool
    
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
        let fileUrl = Bundle.main.url(forResource: "Wind", withExtension: "mp4")!
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
