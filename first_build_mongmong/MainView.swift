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
    @State var watch_video3 = false
    @State var watch_video4 = false
    @State var watch_video5 = false
    @State private var showingAlert = false
    
    
    var body: some View {
        ZStack{
            GeometryReader { geo in
                Image("main_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width, height: geo.size.height)
                    .scaleEffect(1.3)
                    .offset(y: 10.5)
                
                //icon Image
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(){
                        Spacer(minLength: 13)
                        Button(action: {
                            self.watch1.toggle()
                        }) {
                            Image("icon_1")
                                .scaleEffect(1.05)
                            Spacer().frame(height: geo.size.height * 1.2)
                            
                        }
                        .fullScreenCover(isPresented: $watch1) {
                            Watch1()
                        }
                        .zIndex(1)
                        
                        Button(action: {
                            self.watch_video1.toggle()
                        }) {
                            Image("icon_2")
                                .scaleEffect(1.05)
                            Spacer().frame(height: geo.size.height * 1.2)
                        }
                        .fullScreenCover(isPresented: $watch_video1) {
                            Watch_Video1()
                        }
                        .padding(.horizontal, -8)
                        .zIndex(1)
                        
                        Button(action: {
                            self.watch2.toggle()
                        }) {
                            Image("icon_3")
                                .scaleEffect(1.05)
                            Spacer().frame(height: geo.size.height * 1.2)
                            
                        }
                        .fullScreenCover(isPresented: $watch2) {
                            Watch2()
                        }
                        .padding(.horizontal, -8)
                        .zIndex(1)
                        
                        Button(action: {
                            self.watch_video2.toggle()
                        }) {
                            Image("icon_4")
                                .scaleEffect(1.05)
                            Spacer().frame(height: geo.size.height * 1.2)
                            
                        }
                        .fullScreenCover(isPresented: $watch_video2) {
                            Watch_Video2()
                        }
                        .padding(.horizontal, -8)
                        .zIndex(1)
                        
                        Button(action: {
                            self.watch3.toggle()
                        }) {
                            Image("icon_5")
                                .offset(y: 2)
                                .scaleEffect(1.05)
                            Spacer().frame(height: geo.size.height * 1.2)
                            
                        }
                        .fullScreenCover(isPresented: $watch3) {
                            Watch3()
                        }
                        .padding(.horizontal, -2)
                        .zIndex(1)
                        
                        Button(action: {
                            self.watch_video3.toggle()
                        }) {
                            Image("icon_6")
                                .offset(y: -2)
                                .scaleEffect(1.03)
                            Spacer().frame(height: geo.size.height * 1.2)
                            
                        }
                        .fullScreenCover(isPresented: $watch_video3) {
                            Watch_Video3()
                        }
                        .padding(.horizontal, -8)
                        .zIndex(1)
                        
                        Button(action: {
                            self.watch_video4.toggle()
                        }) {
                            Image("icon_7")
                                .offset(y: -3)
                                .scaleEffect(1.05)
                            Spacer().frame(height: geo.size.height * 1.2)
                            
                        }
                        .fullScreenCover(isPresented: $watch_video4) {
                            Watch_Video4()
                        }
                        .padding(.horizontal, -12)
                        .zIndex(1)
                        
                        Button(action: {
                            self.watch_video5.toggle()
                        }) {
                            Image("icon_8")
                                .offset(y: -3)
                                .scaleEffect(1.05)
                            Spacer().frame(height: geo.size.height * 1.2)
                            
                        }
                        .fullScreenCover(isPresented: $watch_video5) {
                            Watch_Video5()
                        }
                        .padding(.horizontal, -8)
                        .zIndex(1)
                        
                        Button(action: {
                            self.showingAlert  = true
                        }) {
                            Image("icon_9")
                                .offset(y: -16)
                                .scaleEffect(1.05)
                            Spacer().frame(height: geo.size.height * 1.2)
                        }
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("MongMong"), message: Text("We will update soon"), dismissButton: .default(Text("OK")))
                        }
                        .padding(.horizontal, -3)
                        .zIndex(1)
                    }
                }
                
                Image("volume_background")
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geo.size.width * 1.1)
                    .offset(x: geo.size.height * 0.83, y: 7)
                    .scaleEffect(1.1)
                    .zIndex(1)
                
                VolumeSlider()
                    .aspectRatio(contentMode: .fit)
                    //                    .scaleEffect(x: 0.36, y: 1.1)
                    .frame(height: geo.size.height * 0.8)
                    .offset(x: -50, y: geo.size.height * 2.025)
                    .rotationEffect(.degrees(-90))
                    .zIndex(1)
            }
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
        Group {
            MainView()
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
                .previewDisplayName("iPhone 12 Mini")
            
            MainView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
                .previewDisplayName("iPhone 11 Pro Max")
            
            MainView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
                .previewDisplayName("iPhone 12 Pro Max")
            
            MainView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
                .previewDisplayName("iPhone 11")
            
            MainView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
                .previewDisplayName("iPhone 11 Pro")
        }
    }
}

