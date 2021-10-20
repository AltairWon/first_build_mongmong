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
    @State var homeView  = false
    @State var nextView = false
    
    var body: some View {
        ZStack {
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
                    audioPlayer?.stop()
                    self.nextView.toggle()
                }
                .fullScreenCover(isPresented: $nextView) {
                    Watch2()
                }
                .zIndex(1.2)
            
            VideoPlayer()
                .scaleEffect(x: 1.1, y: 1.1)
        }
    }
}


struct VideoPlayer: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<VideoPlayer>) {
    }
    
    func makeUIView(context: Context) -> UIView {
        return LoopingPlayerUIView(frame: .zero)
    }
}


class LoopingPlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    
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
        
        // Start the movie
        player.play()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}
