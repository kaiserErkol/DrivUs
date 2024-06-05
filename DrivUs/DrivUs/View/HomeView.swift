import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel_rides = ViewModel_Rides()
    @ObservedObject var viewModel_user = ViewModel_User()
    
    var body: some View {
        VStack {
            Image(systemName: "car.rear")
                .resizable()
                .frame(width: 150, height: 130)
                .padding(50)
                .background(Color.drivusBlue)
                .foregroundColor(.white)
                .clipShape(Circle())
                .padding(.top, 80)
                .padding(.vertical, 20)
                .shadow(color: .black, radius: -15, x: 5, y: 5)
                
            VStack(spacing: -15) {
                Button("NACHHAUSE") {
                    print("Nach Hause")
                }
                .padding(.horizontal, 80)
                .padding(.vertical, 20)
                .background(Color.gray)
                .foregroundColor(.black)
                .cornerRadius(20)
                .shadow(color: .black, radius: 3, x: 3, y: 3)
                .frame(width: UIScreen.main.bounds.width / 1)
                .frame(height: 100)
                
                Button("SUCHEN") {
                    print("Suchen")
                }
                .padding(.horizontal, 100)
                .padding(.vertical, 20)
                .background(Color.drivusBlue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .shadow(color: .black, radius: 3, x: 3, y: 3)
                .frame(width: UIScreen.main.bounds.width / 1)
                .frame(height: 100)
                
                
            }
            .padding(.top, 30)
            
            Spacer()
        }
        .task {
            viewModel_user.fetchUsers()
            viewModel_rides.fetchRides()
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .tabItem {
            Image(systemName: "house.fill")
            Text("Home")
        }
    }
}

#Preview {
    HomeView()
}
