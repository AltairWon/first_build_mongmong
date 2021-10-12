//
//  MainView.swift
//  first_build_mongmong
//
//  Created by HyokJun Won on 2021/10/12.
//

import SwiftUI

struct MainView: View {
    @State var iconScale: CGFloat = 1
    @State var iconX: CGFloat = -300
    @State var iconY: CGFloat = 40
    
    @State var watch1 = false
    @State var watch2 = false
    @State var watch3 = false
    @State var watch_video1 = false
    @State var watch_video2 = false

    var body: some View {
        ZStack{
            Image("main_background")
                .offset(y: 10)
                .zIndex(0.1)
            
            //Image icon
            Group {
                Image("ocean_icon")
                    .scaleEffect(iconScale)
                    .offset(x: iconX, y: iconY)
                    .onTapGesture {
                        self.watch1.toggle()
                    }
                    .fullScreenCover(isPresented: $watch1) {
                        Watch1()
                    }
                    .zIndex(1)
                
                Image("bell_icon")
                    .scaleEffect(iconScale)
                    .offset(x: iconX+110, y: iconY)
                    .onTapGesture {
                        self.watch_video1.toggle()
                    }
                    .fullScreenCover(isPresented: $watch_video1) {
                        Watch_Video1()
                    }
                    .zIndex(1)
                
                Image("bird_icon")
                    .scaleEffect(iconScale)
                    .offset(x: iconX+220, y: iconY)
                    .onTapGesture {
                        self.watch2.toggle()
                    }
                    .fullScreenCover(isPresented: $watch2) {
                        Watch2()
                    }
                    .zIndex(1)
                
                Image("rain_icon")
                    .scaleEffect(iconScale)
                    .offset(x: iconX+330, y: iconY)
                    .onTapGesture {
                        self.watch_video2.toggle()
                    }
                    .fullScreenCover(isPresented: $watch_video2) {
                        Watch_Video2()
                    }
                    .zIndex(1)
                
                Image("surfing_icon")
                    .scaleEffect(iconScale)
                    .offset(x: iconX+440, y: iconY)
                    .onTapGesture {
                        self.watch3.toggle()
                    }
                    .fullScreenCover(isPresented: $watch3) {
                        Watch3()
                    }
                    .zIndex(1)
                
                Image("plus_icon")
                    .scaleEffect(iconScale)
                    .offset(x: iconX+550, y: iconY - 10)
                    .zIndex(1)
            }
            
            Image("volume_background")
                .scaleEffect(x: 1.2, y: 1)
                .offset(x: iconX+660, y: 6.5)
                .zIndex(1)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

