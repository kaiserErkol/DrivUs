//
//  ContentView.swift
//  DrivUs
//
//  Created by MacBook on 05.03.24.
//

import SwiftUI
import CoreLocation
import CoreLocationUI
import MapKit

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
                                           latitudinalMeters: 1000, longitudinalMeters: 1000)
    @State var userLocationAnnotations: [UserLocationAnnotation] = []
    
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            
            Map(coordinateRegion: $region, annotationItems: userLocationAnnotations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    // Hier können Sie ein benutzerdefiniertes SwiftUI-View für die Annotation angeben.
                    Circle()
                        .strokeBorder(Color.blue, lineWidth: 3)
                        .background(Circle().fill(Color.blue.opacity(0.5)))
                        .frame(width: 30, height: 30)
                }
            }
            .frame(height: 600)
            
            if let location = locationManager.location {
                            Text("Your location: \(location.latitude), \(location.longitude)")
                        }
            LocationButton {
                locationManager.requestLocation()
            }
            .frame(height: 44)
        }
        .padding()
        .onReceive(locationManager.$location) { newLocation in
            DispatchQueue.main.async {
                if let newLocation = newLocation {
                    region.center = newLocation
                    userLocationAnnotations = [UserLocationAnnotation(coordinate: newLocation)]
                }
            }
        }
        .onReceive(timer) { _ in
            locationManager.requestLocation()
        }
    }
}

struct UserLocationAnnotation: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}

#Preview {
    ContentView()
}
