import SwiftUI
import MapKit

struct SwipeView: View {
    @ObservedObject var viewModelRides: ViewModel_Rides
    @ObservedObject var viewModelUser: ViewModel_User
    @ObservedObject var viewModelSwipes: ViewModel_Swipes
    @ObservedObject var viewModelMatches: ViewModel_Matches
    
    @State private var showSwipeByIndex: Int = 0
    
    @StateObject var locationManager = LocationManager()
    @State var userLocations: [UserLocation] = []
    @State var route: MKRoute?
    @State var routeDisplaying = false
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                if viewModelSwipes.newMatch {
                    //ITS A MATCH VIEW ANZEIGEN LASSEN
                    Text("IT A MATCH")
                }
            }
            
            VStack(spacing: 0) {
                if showSwipeByIndex < viewModelSwipes.swipes.count {
                    let swipe = viewModelSwipes.swipes[showSwipeByIndex]
                    let loggedUserId = viewModelUser.loggedUser.id
                    let userSwipeId = (swipe.firstUserId != loggedUserId) ? swipe.firstUserId : swipe.secondUserId
                    
                    if let rideByCurrSwipe = viewModelRides.fetchRideByUser(userSwipeId),
                       let userById = viewModelUser.fetchUserById(rideByCurrSwipe.user_id) {

                        MapView(
                            sp_latitude: rideByCurrSwipe.startpunkt_latitude,
                            sp_longitude: rideByCurrSwipe.startpunkt_longitude,
                            ep_latitude: rideByCurrSwipe.endpunkt_latitude,
                            ep_longitude: rideByCurrSwipe.endpunkt_longitude,
                            startName: rideByCurrSwipe.startpunkt_ort,
                            endName: rideByCurrSwipe.endpunkt_ort
                        )
                        
                        Color.drivusBlue.overlay(
                            VStack {
                                // Buttons
                                HStack(spacing: 100) {
                                    Button(action: {
                                        rejectRide(swipe)
                                    }) {
                                        Image(systemName: "xmark")
                                            .padding()
                                            .background(Color.white)
                                            .foregroundColor(.black)
                                            .clipShape(Circle())
                                    }
                                    
                                    Button(action: {
                                        acceptSwipe(swipe)
                                    }) {
                                        Image(systemName: "checkmark")
                                            .padding()
                                            .background(Color.white)
                                            .foregroundColor(.black)
                                            .clipShape(Circle())
                                    }
                                }
                                .padding(.top, 5)
                                .background(Color.drivusBlue)
                                
                                Text("\(rideByCurrSwipe.startpunkt_ort) - \(rideByCurrSwipe.endpunkt_ort)")
                                    .padding(.top, 20)
                                    .foregroundColor(.white)
                                    .kerning(7)
                                
                                Text("User: \(userById.name)")
                                    .padding(5)
                                    .foregroundColor(.white)
                            }
                            .frame(width: UIScreen.main.bounds.width)
                            .padding(.bottom, 10)
                            .background(Color.drivusBlue)
                            .cornerRadius(40)
                            .gesture(
                                DragGesture()
                                    .onEnded { gesture in
                                        if gesture.translation.width < -100 {
                                            // Swipe Left
                                            rejectRide(swipe)
                                        } else if gesture.translation.width > 100 {
                                            // Swipe Right
                                            acceptSwipe(swipe)
                                        }
                                    }
                            )
                        )
                        
                    } else {
                        Text("No ride found")
                            .padding()
                            .foregroundColor(.white)
                    }
                } else {
                    Text("No available Rides found")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.drivusBlue)
                        .cornerRadius(70)
                        .padding(.top, 350)
                }
                
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width)
            .cornerRadius(20)
        }
        .task {
            viewModelSwipes.fetchUserSwipes(viewModelUser.loggedUser)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.bottom, 20)
        .shadow(color: .gray, radius: 15, x: -0, y: -5)
    }
    
    private func acceptSwipe(_ swipe: Model.SwipeModel.Swipe) {
        viewModelSwipes.answerSwipe(swipeId: swipe.id, answer: true, user: viewModelUser.loggedUser, fetchAllMatches: viewModelMatches.fetchAllMatches, fetchUserMatches: viewModelMatches.fetchUserMatches)
            
        showSwipeByIndex += 1
    }
    
    private func rejectRide(_ swipe: Model.SwipeModel.Swipe) {
        viewModelSwipes.answerSwipe(swipeId: swipe.id, answer: false, user: viewModelUser.loggedUser)
        showSwipeByIndex += 1
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
    
    let sp_latitude: Double
    let sp_longitude: Double
    let ep_latitude: Double
    let ep_longitude: Double
    let startName: String
    let endName: String
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        // Initial region setup
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: sp_latitude, longitude: sp_longitude),
                                        latitudinalMeters: 10000000, longitudinalMeters: 5000000)
        mapView.setRegion(region, animated: true)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Remove existing annotations and overlays
        uiView.removeAnnotations(uiView.annotations)
        uiView.removeOverlays(uiView.overlays)
        
        // Update map with new coordinates and route
        let startCoordinate = CLLocationCoordinate2D(latitude: sp_latitude, longitude: sp_longitude)
        let endCoordinate = CLLocationCoordinate2D(latitude: ep_latitude, longitude: ep_longitude)
        
        let p1 = MKPlacemark(coordinate: startCoordinate)
        let p2 = MKPlacemark(coordinate: endCoordinate)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: p1)
        request.destination = MKMapItem(placemark: p2)
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculate { response, error in
            DispatchQueue.main.async {
                guard let route = response?.routes.first, error == nil else { return }
                uiView.addOverlay(route.polyline)
                uiView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                
                let startAnnotation = MKPointAnnotation()
                startAnnotation.coordinate = p1.coordinate
                startAnnotation.title = startName
                uiView.addAnnotation(startAnnotation)
                
                let endAnnotation = MKPointAnnotation()
                endAnnotation.coordinate = p2.coordinate
                endAnnotation.title = endName
                uiView.addAnnotation(endAnnotation)
            }
        }
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
