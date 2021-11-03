//
//  Watch_Video2.swift
//  first_build_mongmong
//
//  Created by HyokJun Won on 2021/10/08.
//

import SwiftUI
import AVKit
import MediaPlayer

struct Watch_Video2: View {
    @State var homeView  = false
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
                playSound(sound: "Rain_Bgm", type: "mp3")
                
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
                Watch3()
            }
            .offset(x: 390, y: 150)
            .zIndex(1.2)
            
            VideoPlayer2()
                .scaleEffect(x: 1.1, y: 1.1)
        }
    }
}

struct VideoPlayer2: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return LoopingPlayerUIView2(frame: .zero)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Do nothing here
    }
}

class LoopingPlayerUIView2: UIView {
    private var playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Load Video
        let fileUrl = Bundle.main.url(forResource: "Rain", withExtension: "mp4")!
        let playerItem = AVPlayerItem(url: fileUrl)
        
        // Setup Player
        let player = AVQueuePlayer(playerItem: playerItem)
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        
        // Loop
        playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)
        
        // Play
        player.play()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct LoopingPlayer_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayer2()
    }
}
