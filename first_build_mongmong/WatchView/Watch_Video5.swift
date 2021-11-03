//
//  Watch_Video5.swift
//  first_build_mongmong
//
//  Created by HyokJun Won on 2021/11/03.
//

import SwiftUI
import AVKit
import MediaPlayer

struct Watch_Video5: View {
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
                .offset(x: -400, y: -140)
                .onTapGesture {
                    audioPlayer?.stop()
                    playSound2(sound: "Click", type: "mp3")
                    self.homeView.toggle()
                }
                .fullScreenCover(isPresented: $homeView) {
                    MainView()
                }
                .onAppear(perform: {
                    playSound(sound: "Wave_Bgm", type: "mp3")

                })
                .zIndex(1.2)

//            Image("next_view")
//                .scaleEffect(0.4)
//                .offset(x: 360, y: 150)
//                .onTapGesture {
//                    audioPlayer?.stop()
//                    playSound2(sound: "Click", type: "mp3")
//                    self.nextView.toggle()
//                }
//                .fullScreenCover(isPresented: $nextView) {
//                }
//                .zIndex(1.2)
            
            VideoPlayer5()
                .scaleEffect(1.1)
            
//            Button(action: {
//                self.homeView.toggle()
//            }) {
//                Image("home_view")
//
//            }
//            .fullScreenCover(isPresented: $homeView) {
//                MainView()
//
//            }
        }

    }
}


struct VideoPlayer5: UIViewRepresentable {
//    @Binding var isPlaying: Bool
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<VideoPlayer5>) {
    }
    
    func makeUIView(context: Context) -> UIView {
        let loopPlayer = LoopingPlayerUIView5(frame: .zero)
        loopPlayer.play()
        
        return loopPlayer
    }
    
    func stopUIView(context: Context) -> UIView {
        let stopPlayer = LoopingPlayerUIView5(frame: .zero)
        stopPlayer.stop()
        
        return stopPlayer
    }
}


class LoopingPlayerUIView5: UIView {
    let playerLayer = AVPlayerLayer()
    var playerLooper: AVPlayerLooper?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Load the resource
        let fileUrl = Bundle.main.url(forResource: "Wave", withExtension: "mp4")!
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