//
//  DeviceOrientationView.swift
//  first_build_mongmong
//
//  Created by HyokJun Won on 2021/09/14.
//

import SwiftUI

struct DeviceOrientationView: View {
    @State private var orientation = UIDeviceOrientation.unknown
    var body: some View {
        Group{
            if orientation.isPortrait {
                Text("Portrait")
                    .font(.title)
                    .foregroundColor(Color.red)
            } else if orientation.isLandscape {
                Text("LandScape")
                    .font(.title)
                    .foregroundColor(Color.blue)
            } else if orientation.isFlat {
                Text("Flat")
            } else {
                Text("Unknown")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.black)
            }
        }.onRotate { newDeviceRotation in
            orientation = newDeviceRotation
        }
    }
}

struct DeviceOrientationView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceOrientationView()
    }
}
