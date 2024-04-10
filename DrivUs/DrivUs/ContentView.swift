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

struct ContentView: View{
    @StateObject var locationManager = LocationManager()
    
    //@State var cameraPosition: MapCameraPosition = .region(.userRegion)
    @State var userLocations: [UserLocation] = []
    @State var route: MKRoute?
    @State var routeDisplaying = false
    //@State var routeDestination: UserLocation
    
    /*
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
                                           latitudinalMeters: 10000000, longitudinalMeters: 5000000)

    
    let stationaryLocation = UserLocationAnnotation(coordinate: CLLocationCoordinate2D(latitude: 60.12312, longitude: 122.4194))
    
    var combinedAnnotations: [UserLocationAnnotation] {
        userLocationAnnotations + [stationaryLocation]
    }
    

    
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    
    let walkingRoute: [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: 40.836456,longitude: 14.307014),
        CLLocationCoordinate2D(latitude: 40.835654,longitude: 14.304346),
        CLLocationCoordinate2D(latitude: 40.836478,longitude: 14.302593),
        CLLocationCoordinate2D(latitude: 40.836936,longitude: 14.302464)
    ]
     */
    
    var body: some View {
        VStack {
            MapView()
            
            Button(action: {
                
            }, label: {
                Text("DrvUs Yeaah !")
            })
            .padding()
            /*
            Map(position: $cameraPosition) {
                Annotation("user location",  coordinate: .userLocation) {
                   Circle()
                       .strokeBorder(Color.blue, lineWidth: 2)
                       .background(Circle().fill(Color.blue.opacity(0.5)))
                       .frame(width: 20, height: 20)
                }
                
                ForEach(otherLocations, id: \.self) { item in
                    let locationMark = item.coordinate
                    Marker("NameThisPlease", coordinate: item.coordinate)
                }
                 */
                /*
                if let route = route {
                    MapPolyline(route.polyline) {
                                    $0.stroke(Color.blue, lineWidth: 6)
                                }
                }
                 
            }
            .mapControls {
                MapCompass()
                MapUserLocationButton()
            }
                 */
            /*
            Map(coordinateRegion: $region, annotationItems: userLocationAnnotations) { location in
                
                
                 MapAnnotation(coordinate: location.coordinate) {
                    Circle()
                        .strokeBorder(Color.blue, lineWidth: 2)
                        .background(Circle().fill(Color.blue.opacity(0.5)))
                        .frame(width: 20, height: 20)
                }
                
                
                if let route {
                    MapPolyline(route.polyline) {
                        .stroke(.blue, lineWidth: 3)
                    }
                }
            }
            */
    
            /*
            if let location = locationManager.location {
                            Text("Your location: \(location.latitude), \(location.longitude)")
            }
            LocationButton {
                locationManager.requestLocation()
            }
            .frame(height: 30)
             */
        }
        .padding()
        /*
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
         */
    }
}

extension CLLocationCoordinate2D {
    static var userLocation: CLLocationCoordinate2D {
        return .init(latitude: 48.2590, longitude: 14.2439)
    }
}

/*
extension MKCoordinateRegion {
    static var userRegion: MKCoordinateRegion {
        return .init(center: .userLocation,
            latitudinalMeters: 300000,
            longitudinalMeters: 300000)
    }
}
*/
struct UserLocation: Identifiable, Hashable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: UserLocation, rhs: UserLocation) -> Bool {
        return lhs.id == rhs.id
    }
}

struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView
    
    func makeCoordinator() -> MapViewCoordinator {
        
        return MapViewCoordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
                                        latitudinalMeters: 10000000, longitudinalMeters: 5000000)
        mapView.setRegion(region, animated: true)
        
        let p1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 48.3064, longitude: 14.2861))
        let p2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 47.8095, longitude: 13.0550))
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: p1)
        request.destination = MKMapItem(placemark: p2)
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let route = response?.routes.first else {return }
            mapView.addAnnotation([p1,p2] as! MKAnnotation)
            mapView.addOverlay(route.polyline)
            mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            
        }
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Update the view
    }
}

class MapViewCoordinator: NSObject, MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .blue
        renderer.lineWidth = 3
        return renderer
    }
    
}


#Preview {
    ContentView()
}
