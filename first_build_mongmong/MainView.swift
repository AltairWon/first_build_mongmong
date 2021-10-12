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
                    .zIndex(1)
                
                Image("bell_icon")
                    .scaleEffect(iconScale)
                    .offset(x: iconX+110, y: iconY)
                    .zIndex(1)
                
                Image("bird_icon")
                    .scaleEffect(iconScale)
                    .offset(x: iconX+220, y: iconY)
                    .zIndex(1)
                
                Image("rain_icon")
                    .scaleEffect(iconScale)
                    .offset(x: iconX+330, y: iconY)
                    .zIndex(1)
                
                Image("surfing_icon")
                    .scaleEffect(iconScale)
                    .offset(x: iconX+440, y: iconY)
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

