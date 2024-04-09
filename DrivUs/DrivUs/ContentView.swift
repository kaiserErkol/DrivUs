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
                                           latitudinalMeters: 10000000, longitudinalMeters: 5000000)
    @State var userLocationAnnotations: [UserLocationAnnotation] = []
    
    let stationaryLocation = UserLocationAnnotation(coordinate: CLLocationCoordinate2D(latitude: 60.12312, longitude: 122.4194))
    
    var combinedAnnotations: [UserLocationAnnotation] {
        userLocationAnnotations + [stationaryLocation]
    }
    
    private let places = [
        UserLocationAnnotation(coordinate: CLLocationCoordinate2D(latitude: 40.83859036140747, longitude: 14.24945566830365)),
        UserLocationAnnotation(coordinate: CLLocationCoordinate2D(latitude: 40.828206, longitude: 14.247549)),
    ]
    
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    let walkingRoute: [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: 40.836456,longitude: 14.307014),
        CLLocationCoordinate2D(latitude: 40.835654,longitude: 14.304346),
        CLLocationCoordinate2D(latitude: 40.836478,longitude: 14.302593),
        CLLocationCoordinate2D(latitude: 40.836936,longitude: 14.302464)
    ]
    
    var body: some View {
        VStack {
            
                Map {
                    /// The Map Polyline map content object
                    MapPolyline(coordinates: walkingRoute)
                        .stroke(.blue, lineWidth: 5)
                }
            
            
            /*
            Map(coordinateRegion: $region, annotationItems: userLocationAnnotations) { location in
                
                
                 MapAnnotation(coordinate: location.coordinate) {
                    Circle()
                        .strokeBorder(Color.blue, lineWidth: 2)
                        .background(Circle().fill(Color.blue.opacity(0.5)))
                        .frame(width: 20, height: 20)
                }
                
                
                //MapPolyline(coordinates: location.coordinate)
            }
            */
    
            if let location = locationManager.location {
                            Text("Your location: \(location.latitude), \(location.longitude)")
            }
            LocationButton {
                locationManager.requestLocation()
            }
            .frame(height: 30)
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
