//
//  SwipeView.swift
//  DrivUs
//
//  Created by Natalie Schmitzberger on 02.04.24.
//
import SwiftUI
import MapKit

public var lat1 : Double = 0.0
public var lat2: Double = 0
var lon1: Double = 0
var lon2: Double = 0
var count : Int = 0

struct SwipeView: View {
    fileprivate let urlString = "http://localhost:3000"
    @State private var currentIndex: Int = 0
    @State private var isMatchShown: Bool = false
    
    @StateObject var locationManager = LocationManager()
    @State var userLocations: [UserLocation] = []
    @State var route: MKRoute?
    @State var routeDisplaying = false
    
    
        
    @EnvironmentObject var viewModel: MatchViewModel
    let carpoolData: [Carpool]
    //fiar standort
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        )
    
    
    var body: some View {
        
        ZStack {
            if isMatchShown, let match = viewModel.matches.last {
                // MatchView anzeigen, wenn es ein Match gibt
                MatchView(carpool: carpoolData[currentIndex], onClose: { isMatchShown = false }, onNext: {
                        // Beim Schließen zum nächsten Eintrag springen
                        isMatchShown = false
                        currentIndex += 1
                    })
            } else {
                VStack(spacing:0) {
                    
                    if currentIndex < carpoolData.count {
                        let carpool = carpoolData[currentIndex]
                        
                         
                        MapView()
                        
                       // Map(coordinateRegion: $region)
                         //   .frame(height: UIScreen.main.bounds.height / 2)
                           // .frame(width: UIScreen.main.bounds.width) // 1/3 des Bildschirmes
                            
                            
                        Color.drivusBlue.overlay(
                                
                        VStack {
                            //buttons
                            HStack (spacing:100){
                                Button(action: {
                                    rejectCurrent()
                                }) {
                                    Image(systemName: "xmark")
                                        .padding()
                                        .background(Color.white)
                                        .foregroundColor(.black)
                                        .clipShape(Circle())
                                        
                                }

                                Button(action: {
                                    acceptCurrent()
                                }) {
                                    Image(systemName: "checkmark")
                                        .padding()
                                        .background(Color.white)
                                        .foregroundColor(.black)
                                        .clipShape(Circle())
                                }
                            }.padding(.top,5).background(.drivusBlue)
                            
                            Text("\(carpool.from) - \(carpool.to)").padding(.top,20).foregroundColor(.white).kerning(7)
                            Text("\(carpool.time)").bold().padding().foregroundColor(.white)
                            Text("\(carpool.driver)").padding(5).foregroundColor(.white)
                            // check or x
                            
                        }.frame(width: UIScreen.main.bounds.width).animation(.easeInOut, value: currentIndex)
                            .transition(.slide)
                        
                        .padding(.bottom,10)
                        .background(.drivusBlue)
                        .frame(height: UIScreen.main.bounds.height*1.5))
                         
                        .cornerRadius(20)
                        .shadow(color: .white, radius: 15,x:-0,y:-5)
                        .frame(width: UIScreen.main.bounds.width)
                        .gesture(
                            DragGesture()
                                .onEnded { gesture in
                                    if gesture.translation.width < -100 {
                                        // Swipe Left
                                        rejectCurrent()
                                    } else if gesture.translation.width > 100 {
                                        // Swipe Right
                                        acceptCurrent()
                                    }
                                }
                        )
                        .animation(.easeInOut, value: currentIndex)
                        .transition(.slide)
                        .frame(height: UIScreen.main.bounds.height / 3)
                        .indexViewStyle(.page(backgroundDisplayMode: .never))
                    } else {
                        // Anzeigen, dass keine weiteren Matches vorhanden sind
                        Text("No Matches More")
                    }
                    Spacer()
                    
                }.frame(width: UIScreen.main.bounds.width).animation(.easeInOut, value: currentIndex)
                    .transition(.slide)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.bottom,20)
        
    }

    private func acceptCurrent() {
        if currentIndex < carpoolData.count {
            let carpool = carpoolData[currentIndex]
            if carpool.swipe {
                viewModel.addMatch(carpool)
                isMatchShown = true
            } else {
                moveToNext()
            }
        }
    }

    private func rejectCurrent() {
        moveToNext()
    }

    private func moveToNext() {
        if currentIndex < carpoolData.count - 1 {
            currentIndex += 1
        } else {
    
            isMatchShown = false
        }
    }
}


struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleCarpoolData = [
            Carpool(from: "GMUNDEN", to: "THENING", time: "10:00", driver: "Natalie Schmitzberger", swipe: true),
            Carpool(from: "C", to: "D", time: "12:00", driver: "Alice P.", swipe: false)
        ]
        
        return SwipeView(carpoolData: sampleCarpoolData)
            .environmentObject(MatchViewModel()) // Wenn du einen MatchViewModel benötigst
    }
}

extension CLLocationCoordinate2D {
    static var userLocation: CLLocationCoordinate2D {
        return .init(latitude: 48.2590, longitude: 14.2439)
    }
}


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
    
    //@Binding var directions: [String]
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
                                        latitudinalMeters: 10000000, longitudinalMeters: 5000000)
        mapView.setRegion(region, animated: true)
        
        let newHeight = UIScreen.main.bounds.height / 2
        let newWidth = UIScreen.main.bounds.width / 3
        mapView.frame = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
        
        count += 1;
        var p1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 48.137154, longitude: 11.576124))
        var p2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 52.520008, longitude: 13.404954))
        if count == 1 {
            
            p1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 48.137154, longitude: 11.576124))
            p2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 52.520008, longitude: 13.404954))
        }
         if count == 2 {
             p1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 48.25632000, longitude: 14.16263000))
             p2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 48.267, longitude: 14.250))
         }
        if count == 3 {
            p1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 48.25632000, longitude: 14.16263000))
            p2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 48.267, longitude: 14.250))
       }
        if count == 4 {
            p1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 48.25632000, longitude: 14.16263000))
            p2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 48.274200, longitude: 14.199200))
       }
        if count == 5 {
            p1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 48.33223000, longitude: 14.17428000))
            p2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 48.3000, longitude: 14.2833
))
       }
        
        
        
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: p1)
        request.destination = MKMapItem(placemark: p2)
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            DispatchQueue.main.async {
                guard let route = response?.routes.first, error == nil else { return }
                //mapView.addAnnotation([p1,p2] as! MKAnnotation)
                mapView.addOverlay(route.polyline)
                mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                //self.directions = route.steps.map { $0.instructions }.filter{ !$0.isEmpty }
                
                let annotations = [p1, p2].compactMap{MKPlacemark(placemark: $0)}
                mapView.addAnnotations(annotations)
            }
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


