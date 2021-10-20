//
//  Watch2.swift
//  first_build_mongmong
//
//  Created by HyokJun Won on 2021/10/06.
//

import SwiftUI
import AVKit

struct Watch2: View {
    @State var homeView  = false
    @State var nextView = false

    @State var currentTime = Time(ns: 0, sec: 0, min: 0, hr: 0)
    @State var receiver = Timer.publish(every: 0.2, on: .current, in: .default).autoconnect()
    @State var secondReceiver = Timer.publish(every: 0.05, on: .current, in: .default).autoconnect()
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
    @State var bird1X: CGFloat = -50
    @State var bird1Y: CGFloat = -50
    
    @State var bird2X: CGFloat = -350
    @State var bird2Y: CGFloat = -150
    
    @State var bird3X: CGFloat = -150
    @State var bird3Y: CGFloat = -250
    
    @State var bird1ID: Double = 0
    @State var bird2ID: Double = 0
    @State var bird3ID: Double = 0

    @State var birdFlyIndex: Int = 0
    
    var body: some View {
        ZStack {
            //Main page and next page button
            Image("home_view")
                .scaleEffect(0.3)
                .offset(x: -360, y: -140)
                
                //tap to go back to main page and stop the music
                .onTapGesture {
                    playSound2(sound: "click", type: "mp3")
                    self.homeView.toggle()
                    audioPlayer?.stop()
                }
                .fullScreenCover(isPresented: $homeView) {
                    MainView()
                }
                
                //set the background music
                .onAppear(perform: {
                    playSound(sound: "bird", type: "mp3")
                })
                .zIndex(1.2)
            
            Image("next_view")
                .scaleEffect(0.4)
                .offset(x: 360, y: 150)
                .onTapGesture {
                    playSound2(sound: "click", type: "mp3")
                    self.nextView.toggle()
                    audioPlayer?.stop()
                }
                .fullScreenCover(isPresented: $nextView) {
                    Watch_Video2()
                }
                
                .zIndex(1.2)

            // Main clock
            Image("watch2_background")
                .zIndex(0)
                .scaleEffect(0.35)
                .offset(y: 15)
                .zIndex(0.1)
            
            Image("watch2_leaf")
                .scaleEffect(0.3)
                .offset(y: 15)
                .zIndex(0.2)
            
            Image("watch2_hour")
                .offset(y: -150)
                .scaleEffect(0.3)
                .rotationEffect(.init(degrees: currentTime.hrAngle()))
                .zIndex(0.8)
                .offset(y: 10)

            ForEach(1..<branchCount) {index in
                Image("watch2_min-\(index)")
                    .offset(y: -150)
                    .scaleEffect(0.4)
                    .rotationEffect(.init(degrees: currentTime.minAngle()))
                    .zIndex(2)
                    .offset(y: 10)
                    .opacity(branchOpacity)
            }
            
//            Image("watch2_min-1")
//                .offset(y: -30)
//                .scaleEffect(0.32)
//                .rotationEffect(.init(degrees: currentTime.minAngle()))
//                .zIndex(2)
//                .offset(y: 10)
//                .opacity(branchOpacity)
//
//            Image("watch2_min-2")
//                .offset(y: -55)
//                .scaleEffect(0.32)
//                .rotationEffect(.init(degrees: currentTime.minAngle()))
//                .zIndex(2)
//                .offset(y: 8)
//                .opacity(branchOpacity)
//
//            Image("watch2_min-3")
//                .offset(y: -150)
//                .scaleEffect(0.32)
//                .rotationEffect(.init(degrees: currentTime.minAngle()))
//                .zIndex(2)
//                .offset(y: 10)
//                .opacity(branchOpacity)
            
            //mushroom Image
            Image("mushroom-\(mushroomIndex)")
                .offset(x: mushroomX, y: mushroomY)
                .scaleEffect(0.4)
                .zIndex(1.0)
                .opacity(mushroomOn ? 0 : 1)
            
            //bird Image
            Image("bird-1-\(birdFlyIndex)")
                .scaleEffect(0.25)
                .rotationEffect(.init(degrees: 90+bird1ID))
                .offset(x: bird1X, y: bird1Y)
                .zIndex(2.4)
            
            Image("bird-2-\(birdFlyIndex)")
                .scaleEffect(0.3)
                .rotationEffect(.init(degrees: 90+bird2ID))
                .offset(x: bird2X, y: bird2Y)
                .zIndex(2.4)

            Image("bird-3-\(birdFlyIndex)")
                .scaleEffect(0.2)
                .rotationEffect(.init(degrees: 90+bird3ID))
                .offset(x: bird3X, y: bird3Y)
                .zIndex(2.4)
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
            } else if currentTime.sec == 58 {
                branchOpacity = 0
            }
            
            if distance(x: bird1X, y: bird1Y) > 400 {
                bird1X *= 0.8
                bird1Y *= 0.8
                bird1ID = Double.random(in: 0..<360)
            }
            
            self.bird1X += CGFloat(2 * cos(bird1ID * Double.pi / 180))
            self.bird1Y += CGFloat(2 * sin(bird1ID * Double.pi / 180))
            
            if distance(x: bird2X, y: bird2Y) > 410 {
                bird2X *= 0.8
                bird2Y *= 0.8
                bird2ID = Double.random(in: 0..<360)
            }
            
            self.bird2X += CGFloat(5 * cos(bird2ID * Double.pi / 180))
            self.bird2Y += CGFloat(5 * sin(bird2ID * Double.pi / 180))
            
            if distance(x: bird3X, y: bird3Y) > 400 {
                bird3X *= 0.8
                bird3Y *= 0.8
                bird3ID = Double.random(in: 0..<360)
            }
            
            self.bird3X += CGFloat(10 * cos(bird3ID * Double.pi / 180))
            self.bird3Y += CGFloat(10 * sin(bird3ID * Double.pi / 180))
        }
        
        .onReceive(thirdReceiver, perform: { _ in
            birdFlyIndex = (birdFlyIndex + 1) % 2
        })
        
        .onTapGesture {
            if mushroomOn {
                mushroomOn = false
            } else {
                mushroomOn = true
                mushroomIndex = Int.random(in: 1...6)
                mushroomX = CGFloat.random(in: -500...500)
                mushroomY = CGFloat.random(in: -300...300)
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
