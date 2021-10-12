//
//  Watch3.swift
//  first_build_mongmong
//
//  Created by HyokJun Won on 2021/10/06.
//

import SwiftUI
import AVKit

struct Watch3: View {
    @State var homeView  = false
    @State var nextView = false
    
    @State var currentTime = Time(ns: 0, sec: 0, min: 0, hr: 0)
    @State var receiver = Timer.publish(every: 0.2, on: .current, in: .default).autoconnect()
    @State var secondReceiver = Timer.publish(every: 0.05, on: .current, in: .default).autoconnect()
    @State var thirdReceiver = Timer.publish(every: 0.4, on: .current, in: .default).autoconnect()

    @State var hourIndex: Int = 0
    @State var minuteIndex: Int = 0
    @State var surferIndex: Int = 0

    @State var surferX: CGFloat = -15

    @State var personX: CGFloat = -280
    @State var personY: CGFloat = 50

    @State var seagullX: CGFloat = -50
    @State var seagullY: CGFloat = -50
    @State var seagullD: Double = 0

    @State var tubeX: CGFloat = -150
    @State var tubeY: CGFloat = -150
    @State var tubeD: Double = 45

    @State private var isAnimated = false
    @State var ballX: CGFloat = 0
    @State var ballY: CGFloat = 0
    @State var targetX: CGFloat = 100
    @State var targetY: CGFloat = 100
    @State var ballD: Double = 0

    @State var shadowX: CGFloat = 10
    @State var shadowY: CGFloat = -500
    
    var animation: Animation {
        Animation.easeOut
    }

    var body: some View {
        ZStack {
            //Main page and next page button
            Image("home_view")
                .scaleEffect(0.4)
                .offset(x: -360, y: -150)
                .onTapGesture {
                    self.homeView.toggle()
                    audioPlayer?.stop()
                }
                .fullScreenCover(isPresented: $homeView) {
                    MainView()
                }
                
                //set the background music
                .onAppear(perform: {
                    playSound(sound: "surfing", type: "mp3")
                })
                .zIndex(1.2)

//            Image("next_view")
//                .scaleEffect(0.4)
//                .offset(x: 360, y: 150)
//                .onTapGesture {
//                    self.nextView.toggle()
//                }
//                .fullScreenCover(isPresented: $nextView) {
//                    //set the next watch view
//                }
//                .zIndex(1.2)
            Group{
                // Main clock
                Image("watch3_background")
                    .scaleEffect(0.35)
                    .offset(y: -20)
                    .zIndex(0.1)
                
                Image("watch3_hour\(hourIndex)")
                    .scaleEffect(0.25)
                    .offset(y: -25)
                    .rotationEffect(.init(degrees: currentTime.hrAngle()))
                    .offset(y: -50)
                    .zIndex(0.1)
                
                Image("watch3_minute\(minuteIndex)")
                    .scaleEffect(0.25)
                    .offset(x: -5, y: -50)
                    .rotationEffect(.init(degrees: currentTime.minAngle()))
                    .offset(y: -50)
                    .zIndex(0.1)
                
                Image("surfer\(surferIndex)")
                    .scaleEffect(0.3)
                    .rotationEffect(.init(degrees: -90))
                    .offset(x: surferX)
                    .offset(x: -5, y: -50)
                    .rotationEffect(.init(degrees: currentTime.minAngle()))
                    .offset(y: -30)
                    .zIndex(0.3)

                Image("person")
                    .scaleEffect(0.3)
                    .offset(x: personX, y: personY)
                    .zIndex(0.2)

                Image("seagull")
                    .scaleEffect(0.3)
                    .rotationEffect(.init(degrees: 90+seagullD))
                    .offset(x: seagullX, y: seagullY)
                    .zIndex(0.4)

                Image("tube")
                    .scaleEffect(0.3)
                    .rotationEffect(.init(degrees: 90+tubeD))
                    .offset(x: tubeX, y: tubeY + 15)
                    .zIndex(0.4)

                Image("ball")
                    .scaleEffect(isAnimated ? 6 : 0.3)
                    .animation(animation)
                    .offset(x: ballX, y: ballY)
                    .zIndex(0.9)

                Image("shadow")
                    .scaleEffect(0.3)
                    .offset(x: shadowX, y: shadowY)
                    .zIndex(0.1)
            }
            

        }
        
        .onReceive(receiver, perform: { _ in
            let calendar = Calendar.current

            let ns = calendar.component(.nanosecond, from: Date())
            let sec = calendar.component(.second, from: Date())
            let min = calendar.component(.minute, from: Date())
            let hr = calendar.component(.hour, from: Date())

            self.currentTime = Time(ns: ns, sec: sec, min: min, hr: hr)

        })

        .onReceive(secondReceiver, perform: { _ in
            let secondInMili = currentTime.secondInMili()

            let twoSecondRemainder = secondInMili % 2000

            if twoSecondRemainder < 1000 {
                surferX = -15 + 30/1000*CGFloat(twoSecondRemainder)
            } else {
                surferX = 15 - 30/1000*CGFloat(twoSecondRemainder-1000)
            }

            let thirtySecondRemainder = secondInMili % 30000

            if thirtySecondRemainder < 15000 {
                personX = 280 + 160/15000*CGFloat(thirtySecondRemainder-15000)
            } else {
                personX = 280 - 160/15000*CGFloat(thirtySecondRemainder-15000)
            }

            let tenSecondRemainder = (secondInMili+2500) % 10000

            if tenSecondRemainder < 5000 {
                personY = 50 + 40/5000*CGFloat(tenSecondRemainder)
            } else {
                personY = 90 - 40/5000*CGFloat(tenSecondRemainder-5000)
            }

            if distance(x: seagullX, y: seagullY) > 420 {
                seagullX *= 0.8
                seagullY *= 0.8
                seagullD = Double.random(in: 0 ..< 360)
            }

            self.seagullX += CGFloat(2 * cos(seagullD * Double.pi / 180))
            self.seagullY += CGFloat(2 * sin(seagullD * Double.pi / 180))

            if thirtySecondRemainder < 5000 {
                tubeX = -450
                tubeY = -150
                tubeD = 45
            } else if thirtySecondRemainder < 12000 {
                tubeX = -450 + 200/7000*CGFloat(thirtySecondRemainder-5000)
                tubeY = -150 + 200/7000*CGFloat(thirtySecondRemainder-5000)
                tubeD = 45
            } else if thirtySecondRemainder < 15000 {
                tubeX = -250
                tubeY = 50
                tubeD = 45 + 180/3000000000*Double(thirtySecondRemainder-12000)
            } else if thirtySecondRemainder < 22000 {
                tubeX = -250-200/7000*CGFloat(thirtySecondRemainder-15000)
                tubeY = 50-200/7000*CGFloat(thirtySecondRemainder-15000)
                tubeD = 225
            } else {
                tubeX = -450
                tubeY = -150
                tubeD = 45
            }

            self.ballX += CGFloat(0.5 * cos(ballD * Double.pi / 180))
            self.ballY += CGFloat(0.5 * sin(ballD * Double.pi / 180))

            if sqrt(pow((ballX-targetX), 2) + pow((ballY-targetY), 2)) <= 5 {
                targetX = CGFloat.random(in: -190 ..< 190)
                targetY = CGFloat.random(in: -175 ..< 305)
            }
            let xDiff = targetX - ballX
            let yDiff = targetY - ballY
            self.ballD = Double(atan(yDiff/xDiff)) * 180 / Double.pi
            if xDiff < 0 {
                self.ballD += 180
            }

            if thirtySecondRemainder < 10000 {
                shadowX = 10
                shadowY = -500
            } else if secondInMili < 15000 {
                shadowX = -100 + 50/5000*CGFloat(thirtySecondRemainder-10000)
                shadowY = -150 + 500/5000*CGFloat(thirtySecondRemainder-10000)
            } else {
                shadowX = 30
                shadowY = 500
            }

        })

        .onReceive(thirdReceiver, perform: { _ in
            hourIndex = (hourIndex + 1) % 3
            minuteIndex = (minuteIndex + 1) % 4
            surferIndex = (surferIndex + 1) % 2

        })
        
        .onTapGesture {
            var lock = true
            guard !lock else {
                isAnimated = true
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                    isAnimated = false
                    lock = false
                }
                return }
        }

    }

    func distance(x: CGFloat, y: CGFloat) -> Double {
        return sqrt(Double(pow(x, 2)) + Double(pow(y, 2)))
    }

}

