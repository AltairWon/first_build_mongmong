//
//  Watch_Video1.swift
//  first_build_mongmong
//
//  Created by HyokJun Won on 2021/10/07.
//

import SwiftUI
import AVKit

struct Watch_Video1: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Watch_Video1>) {
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
