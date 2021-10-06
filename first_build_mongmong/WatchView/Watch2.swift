//
//  Watch2.swift
//  first_build_mongmong
//
//  Created by HyokJun Won on 2021/10/06.
//

import SwiftUI
import AVKit

struct Watch2: View {
    @State var audioPlayer: AVAudioPlayer!

    @State var currentTime = Time(ns: 0, sec: 0, min: 0, hr: 0)
    @State var receiver = Timer.publish(every: 0.2, on: .current, in: .default).autoconnect()
    @State var secondReceiver = Timer.publish(every: 0.3, on: .current, in: .default).autoconnect()
    @State var thirdReceiver = Timer.publish(every: 0.4, on: .current, in: .default).autoconnect()

    //branch minute var
    @State var xPos: CGFloat = 0
    @State var yPos: CGFloat = 0
    @State var xMinute: CGFloat = 0
    @State var yMinute: CGFloat = 0
    @State var branchIndex: Int = 1
    var branchCount = 3
    @State var branchOpacity: Double = 1;
    
    //mushroom var
    @State var mushroomOn: Bool = false
    @State var mushroomIndex = Int.random(in: 1...3)
    @State var mushroomX: CGFloat = -100
    @State var mushroomY: CGFloat = 150
    //let mushroomIndex = Int.getUniqueRandomNumbers(min: 1, max: 3, count: 100)
    
    //bird var
    @State var birdX: CGFloat = 0
    @State var birdY: CGFloat = 50
    @State var birdID: Double = 0
    let birdIndex = Int.random(in: 1...3)
    @State var birdFlyIndex: Int = 0
    @State var xTarget: CGFloat = 10
    @State var yTarget: CGFloat = 10
    var bridCount = 4
    
    var body: some View {
        ZStack {

            // Main clock
            Image("watch2_background")
                .zIndex(0)
                .scaleEffect(0.5)
                .opacity(1)
                .offset(y: 15)
                .zIndex(0)
            
            Image("watch2_leaf")
                .scaleEffect(0.50)
                .offset(y: 15)
                .zIndex(0.2)
            
            Image("watch2_hour")
                .offset(y: -40)
                .scaleEffect(0.5)
                .rotationEffect(.init(degrees: currentTime.hrAngle()))
                .zIndex(0.8)
                .offset(y: 15)
        
            Image("watch2_min-1")
                .offset(y: -30)
                .scaleEffect(0.32)
                .rotationEffect(.init(degrees: currentTime.minAngle()))
                .zIndex(2)
                .offset(y: 10)
                .opacity(branchOpacity)

            Image("watch2_min-2")
                .offset(y: -55)
                .scaleEffect(0.32)
                .rotationEffect(.init(degrees: currentTime.minAngle()))
                .zIndex(2)
                .offset(y: 8)
                .opacity(branchOpacity)

            Image("watch2_min-3")
                .offset(y: -150)
                .scaleEffect(0.32)
                .rotationEffect(.init(degrees: currentTime.minAngle()))
                .zIndex(2)
                .offset(y: 10)
                .opacity(branchOpacity)
            
            //mushroom Image
            Image("mushroom-\(mushroomIndex)")
                .offset(x: mushroomX, y: mushroomY)
                .scaleEffect(0.5)
                .zIndex(1.0)
                .opacity(mushroomOn ? 0 : 1)
            
            //bird Image
            ForEach(1..<bridCount) { index in
                Image("bird-\(index)-\(birdFlyIndex)")
                    .scaleEffect(0.3)
                    .rotationEffect(.init(degrees: 90+birdID))
                    .offset(x: birdX, y: birdY)
                    .zIndex(2.4)
            }
        }
        
        //make the background audio
        .onAppear {
            let sound = Bundle.main.path(forResource: "bird", ofType: "mp3")
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            self.audioPlayer.volume = 0.8
//            self.audioPlayer.play()
        }
        
        .onReceive(receiver, perform: { _ in
            let calender = Calendar.current
            
            let ns = calender.component(.nanosecond, from: Date())
            let sec = calender.component(.second, from: Date())
            let min = calender.component(.minute, from: Date())
            let hr  = calender.component(.hour, from: Date())
            
            self.currentTime = Time(ns: ns, sec: sec, min: min, hr: hr)
            
            xMinute = CGFloat(120 * cos((currentTime.minAngle() - 70) * Double.pi / 180))
            yMinute = CGFloat(210 * cos((currentTime.minAngle() - 150) * Double.pi / 210))
        })
        
        .onReceive(secondReceiver) { _ in
            if currentTime.sec == 0 {
                branchOpacity = 1
            }
            
            if distance(x: birdX, y: birdY) > 150 {
                birdX *= 0.8
                birdY *= 0.8
                birdID = Double.random(in: 0..<360)
            }
            
            if currentTime.sec > 50 || branchOpacity == 0 {
                birdX = xMinute
                birdY = yMinute
            }
            
            self.birdX += CGFloat(10 * cos(birdID * Double.pi / 180))
            self.birdY += CGFloat(5 * sin(birdID * Double.pi / 180))
        }
        
        .onReceive(thirdReceiver) { _ in
            if currentTime.sec == 58 {
                branchOpacity = 0
            }
            birdFlyIndex = (birdFlyIndex + 1) % 2

        }
        
        .onTapGesture {
            if mushroomOn {
                mushroomOn = false
            } else {
                mushroomOn = true
                mushroomIndex = Int.random(in: 1...6)
                mushroomX = CGFloat.random(in: -100...100)
                mushroomY = CGFloat.random(in: -150...150)
            }
        }

    }
    
    
    func branchPosition(minutePosition: CGFloat, index: Int) -> CGFloat {
        return minutePosition / CGFloat(branchCount) * CGFloat(index)
    }
    
    func distance(x: CGFloat, y: CGFloat) -> Double {
        return sqrt(Double(pow(x, 2)) + Double(pow(y, 2)))
    }
}
