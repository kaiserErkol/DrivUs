import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                
                PersonView()
                    .tabItem {
                        Label("Matches", systemImage: "person.fill")
                    }
                
                SwipeView()
                    .tabItem {
                        Label("Rides", systemImage: "car.fill")
                    }
                
                UserView()
                    .tabItem {
                        Label("Users", systemImage: "person.fill")
                    }
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
