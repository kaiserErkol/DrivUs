import Foundation

class MatchManager {

    func filterRides(rides: [RideObject], user: UserObject) -> [RideObject]{
        let userRides = rides.filter { $0.user_id == user.id }
        var matchingRides: [RideObject] = []
        
        for userRide in userRides {
            for ride in rides {
                if userRide.startpunkt_ort == ride.startpunkt_ort && userRide.endpunkt_ort == ride.endpunkt_ort && userRide.user_id != ride.user_id{
                    matchingRides.append(ride)
                }
            }
        }
        
        return matchingRides
    }
}
