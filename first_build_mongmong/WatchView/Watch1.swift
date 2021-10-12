//
//  Watch1.swift
//  first_build_mongmong
//
//  Created by HyokJun Won on 2021/10/06.
//

import SwiftUI
import AVKit

struct Watch1: View {
    @State var audioPlayer: AVAudioPlayer!
    @State var homeView  = false
    @State var nextView = false
    
    @State var currentTime = Time(ns: 0, sec: 0, min: 0, hr: 0)
    @State var receiver = Timer.publish(every: 0.2, on: .current, in: .default).autoconnect()
    @State var secondReceiver = Timer.publish(every: 0.02, on: .current, in: .default).autoconnect()
    @State var thirdReceiver = Timer.publish(every: 0.4, on: .current, in: .default).autoconnect()

    // Wave var
    @State var waveIndex: Int = 0
    @State var waveGoingDown: Bool = true
    @State var waveX: CGFloat = -100
    @State var waveY: CGFloat = -650
    @State var shadowOpacity: Double = 0

    // Carb and turtle var
    @State var crabOpacity: Double = 0
    @State var crabX: CGFloat = -450
    @State var crabIndex: Int = 0
    @State var turtleOpacity: Double = 0
    @State var turtleX: CGFloat = -300
    @State var turtleIndex: Int = 0

    // Fish var
    @State var fishIndex: Int = 0
    @State var flapIndex: Int = 0

    // Steps var
    @State var stepOpacity: Double = 0
    @State var stepOpacity2: Double = 0
    
    //clam and starfish var
    @State var clamIndex: Int = 1
    @State var starfishIndex: Int = 1
    
    //wave animation var
    @State private var isAnimated = false
    var animation: Animation {
        Animation.linear
    }

    var body: some View {
        ZStack {
            //Main page and next page button
            Image("home_view")
                .scaleEffect(0.4)
                .offset(x: -360, y: -150)
                .onTapGesture {
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
                    self.nextView.toggle()
                }
                .fullScreenCover(isPresented: $nextView) {
                    Watch2()
                }
                .zIndex(1.2)
            
            Group {
                // Main clock
                Image("watch1_background")
                    .scaleEffect(0.40)
                    .offset(y: 15)
                    .zIndex(0.1)
                
                Image("wave")
                    .scaleEffect(x: 0.5, y: 0.33)
                    .offset(x: waveX, y: waveY)
                    .zIndex(0.9)

                Image("wave_shadow")
                    .scaleEffect(x: 0.5, y: 0.33)
                    .offset(y: -150)
                    .opacity(shadowOpacity)
                    .zIndex(0.2)

                Image("watch1_minute")
                    .offset(y: -150)
                    .scaleEffect(0.32)
                    .rotationEffect(.init(degrees: currentTime.minAngle()))
                    .zIndex(0.7)
                    .offset(y: 15)
                    .opacity(0.4)

                Image("crab\(crabIndex)")
                    .scaleEffect(0.3)
                    .offset(x: crabX, y: 200)
                    .opacity(crabOpacity)
                    .zIndex(6)

                Image("turtle\(turtleIndex)")
                    .scaleEffect(0.2)
                    .offset(x: turtleX, y: -100)
                    .opacity(turtleOpacity)
                    .zIndex(6)

                Image("fish-\(fishIndex)-\(flapIndex)")
                    .offset(y: -40)
                    .scaleEffect(0.25)
                    .rotationEffect(.init(degrees: currentTime.hrAngle()))
                    .zIndex(0.8)
                    .offset(y: 15)
            }

            ZStack {
                //the position of the image will be different if the orientation is portrait or landscape
                Image("clam_1_\(clamIndex)")
                    .scaleEffect(0.3)
                    .offset(x: 250, y: 150)
                
                Image("clam2")
                    .scaleEffect(0.4)
                    .offset(x: 225, y: 100)
                
                Image("starfish_\(starfishIndex)")
                    .scaleEffect(0.7)
                    .offset(x: 200, y: 120)
            }
            .zIndex(0.7)

            ZStack {
                Image("footstep")
                    .scaleEffect(0.23)
                    .offset(x: -350, y: 50)
                    .opacity(stepOpacity)

                Image("footstep")
                    .scaleEffect(0.23)
                    .offset(x: -250, y: 150)
                    .opacity(stepOpacity2)
            }
            .zIndex(2)

        }
        //make the background audio
        .onAppear {
            let sound = Bundle.main.path(forResource: "wave", ofType: "mp3")
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            self.audioPlayer.volume = 0.8
//            self.audioPlayer.play()
        }

        .onReceive(receiver, perform: { _ in
            let calendar = Calendar.current

            let ns = calendar.component(.nanosecond, from: Date())
            let sec = calendar.component(.second, from: Date())
            let min = calendar.component(.minute, from: Date())
            let hr = calendar.component(.hour, from: Date())

            self.currentTime = Time(ns: ns, sec: sec, min: min, hr: hr)

            fishIndex = currentTime.hr % 12

        })

        .onReceive(secondReceiver, perform: { _ in
            let secondInMili = currentTime.secondInMili()

            if secondInMili < 5000 {
                waveY = -650 + 350.0/5000*CGFloat(secondInMili)
            } else if secondInMili < 10000 {
                waveY = -300
            } else if secondInMili < 15000 {
                waveY = -300 - 350.0/5000*CGFloat(secondInMili-10000)
            } else {
                waveY = -650
            }

            let remainder = secondInMili % 2000
            if remainder < 1000 {
                waveX = -100 + 200/1000*CGFloat(remainder)
            } else {
                waveX = 100 - 200/1000*CGFloat(remainder-1000)
            }

            if secondInMili < 2500 || secondInMili > 12500 {
                crabOpacity = 0
            } else {
                crabOpacity = 1
            }

            if secondInMili < 2500 {
                crabX = -450
            } else if secondInMili < 12500 {
                crabX = -450 + 1000/10000*CGFloat(secondInMili-2500)
            } else {
                crabX = 100
            }

            if secondInMili < 15000 {
                turtleOpacity = 0
            } else {
                turtleOpacity = 1
            }

            if secondInMili < 15000 {
                turtleX = -300
            } else {
                turtleX = -300 + 500.0/45000*CGFloat(secondInMili-15000)
            }

            if secondInMili < 20000 {
                stepOpacity = 0
            } else if secondInMili < 21000 {
                stepOpacity = Double(secondInMili - 20000)/1000
            } else if secondInMili < 24000 {
                stepOpacity = 1
            } else if secondInMili < 25000 {
                stepOpacity = 1 - Double(secondInMili - 24000)/1000
            } else {
                stepOpacity = 0
            }

            if secondInMili < 24000 {
                stepOpacity2 = 0
            } else if secondInMili < 25000 {
                stepOpacity2 = Double(secondInMili - 24000)/1000
            } else if secondInMili < 28000 {
                stepOpacity2 = 1
            } else if secondInMili < 29000 {
                stepOpacity2 = 1 - Double(secondInMili - 28000)/1000
            } else {
                stepOpacity2 = 0
            }

            if secondInMili < 10000 {
                shadowOpacity = 0
            } else if secondInMili < 17000 {
                shadowOpacity = 1
            } else if secondInMili < 22000 {
                shadowOpacity = 1 - Double(secondInMili - 17000)/5000
            } else {
                shadowOpacity = 0
            }

        })
        .onReceive(thirdReceiver, perform: { _ in
            crabIndex = (crabIndex + 1) % 2
            turtleIndex = (turtleIndex + 1) % 2
            flapIndex = (flapIndex + 1) % 2
        })
        
        .onTapGesture {
            clamIndex = Int.random(in: 1...5)
            starfishIndex = Int.random(in: 1...5)
            
        }
    }
}
