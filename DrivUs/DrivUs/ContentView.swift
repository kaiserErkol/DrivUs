//
//  ContentView.swift
//  DrivUs
//
//  Created by MacBook on 05.03.24.
//

import SwiftUI
import CoreLocation
import CoreLocationUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                            Text("Your location: \(location.latitude), \(location.longitude)")
                        }
            LocationButton {
                locationManager.requestLocation()
            }
            .frame(height: 44)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
