import SwiftUI

struct HomeView: View {
    
    var body: some View {
        VStack {
            
            Image("Logo_font_bright")
                .resizable()
                .frame(width: 300, height: 300)
                .padding(.bottom, -70)
                .foregroundColor(.white)
                .padding(.top, -10)
                .shadow(color: .white, radius: -15, x: 5, y: 5)
                
            VStack(spacing: -15) {
                Button("NACHHAUSE") {
                    print("Nach Hause")
                }
                .padding(.horizontal, 80)
                .padding(.vertical, 20)
                .background(.drivusBlue)
                .foregroundColor(.white)
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
             
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .tabItem {
            Image(systemName: "house.fill")
            Text("Home")
        }
    }
}
