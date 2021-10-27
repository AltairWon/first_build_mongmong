//
//  MainView.swift
//  first_build_mongmong
//
//  Created by HyokJun Won on 2021/10/12.
//

import SwiftUI
import UIKit
import MediaPlayer

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
            GeometryReader { geo in
                Image("main_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width, height: geo.size.height)
                    .scaleEffect(1.3)
                    .offset(y: 10.5)

            }
            
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
            
            VolumeSlider()
                .scaleEffect(x: 0.36, y: 1.1)
                .frame(height: 24)
                .offset(x: -10, y: 365)
                .rotationEffect(.degrees(-90))
                .zIndex(1)
        }
    }
}

//set the volume var
struct VolumeSlider: UIViewRepresentable {
    func updateUIView(_ uiView: MPVolumeView, context: Context) {}
    
    
    func makeUIView(context: Context) -> MPVolumeView {
        let volumeView = MPVolumeView()
        volumeView.showsRouteButton = false // TODO: 'showsRouteButton' was deprecated in iOS 13.0: Use AVRoutePickerView instead.
        if let sliderView = volumeView.subviews.first as? UISlider {
            // custom design colors
            sliderView.minimumTrackTintColor = UIColor(red: 0.557, green: 0.871, blue: 0.824, alpha: 1)
            sliderView.thumbTintColor = UIColor(red: 0.525, green: 0.749, blue: 1.0, alpha: 1)
            sliderView.maximumTrackTintColor = UIColor(red: 0.365, green: 0.365, blue: 0.365, alpha: 1)
        }
        
        return volumeView
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

