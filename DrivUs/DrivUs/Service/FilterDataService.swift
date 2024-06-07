//
//  FilterDataService.swift
//  DrivUs
//
//  Created by MacBook on 07.06.24.
//

import Foundation

class FilterDataService {
    static let shared = FilterDataService()
    
    func createSwipes(_ user: Model.UserModel.User, _ mySwipes: [Model.SwipeModel.Swipe], _ myRides: [Model.RideModel.Ride]){
        print("create Swipes")
        /**
         TO FIX:
         Index should be updated by server
         */
        var index: Int = 0
        var swipesToPost = [Model.SwipeModel.Swipe]()
        var matchingRides = [Model.RideModel.Ride]()
        
        matchingRides = MatchManager.shared.filterRides(rides: myRides, user: user)
        
        //find the last id
        for _ in mySwipes {
            index+=1
        }
        
        let userSwipes = mySwipes.filter { $0.firstUserId == user.id || $0.secondUserId == user.id }
        
        for ride in matchingRides {
            var shouldCreateSwipe = true
            var duplicateSwipe = false
            
            for swipe in mySwipes {
                for userSwipe in userSwipes {
                    if (swipe.firstUserId == userSwipe.firstUserId || swipe.firstUserId == userSwipe.secondUserId) && (swipe.secondUserId == userSwipe.firstUserId || swipe.secondUserId == userSwipe.secondUserId) {
                        duplicateSwipe = true
                        break
                    }
                }
                
                if (ride.user_id == swipe.firstUserId || ride.user_id == swipe.secondUserId) &&
                    (user.id == swipe.firstUserId || user.id == swipe.secondUserId) &&
                    ride.id == swipe.rideId {
                    shouldCreateSwipe = false
                    break
                }
                
            }
            
            if shouldCreateSwipe && !duplicateSwipe{
                index+=1
                // Create swipe object
                let newSwipe = Model.SwipeModel.Swipe(
                    id: String(index),
                    rideId: ride.id,
                    firstUserId: ride.user_id,
                    secondUserId: user.id,
                    firstAnswer: false,
                    secondAnswer: false
                )
                swipesToPost.append(newSwipe)
            } else {
                // Don't create swipe object
            }
        }
        
        
        for swipe in swipesToPost {
            print("Swipe TO POST: \(swipe.id)")
            FilterDataService.shared.postSwipe(swipe: swipe) { success in
                if success {
                    print("Swipe posted successfully")
                } else {
                    print("Failed to post swipe")
                }
            }
        }
        
    }
    
    func postSwipe(swipe: Model.SwipeModel.Swipe,completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://localhost:3000/swipes") else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            
            let jsonData = try JSONEncoder().encode(swipe)
            request.httpBody = jsonData
            
        } catch {
            print("Error encoding swipe: \(error)")
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error creating swipe: \(error)")
                completion(false)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                completion(false)
                return
            }
            
            completion(true)
        }.resume()
    }
    
    func updateSwipeRideId(swipeId: String, acceptRide: Bool, userId: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://localhost:3000/swipes/\(swipeId)") else {
            completion(false)
            return
        }
        
        // Fetch the current swipe object
        SwipesService.shared.fetchSwipeById(byID: swipeId) { swipeObject in
            guard let swipe = swipeObject else {
                print("Failed to fetch swipe details")
                completion(false)
                return
            }
            
            // Determine which field to update based on userId
            var updateData: [String: Any] = [:]
            if swipe.secondUserId == userId {
                updateData["secondAnswer"] = acceptRide
            } else if swipe.firstUserId == userId {
                updateData["firstAnswer"] = acceptRide
            } else {
                print("User ID does not match any user in the swipe object")
                completion(false)
                return
            }
            
            // Encode update data to JSON
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: updateData, options: [])
                var request = URLRequest(url: url)
                request.httpMethod = "PATCH"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
                
                // Send PATCH request
                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print("Error updating swipe: \(error)")
                        completion(false)
                        return
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        print("Failed to update swipe. HTTP status code: \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
                        completion(false)
                        return
                    }
                    
                    completion(true)
                }.resume()
            } catch {
                print("Error encoding patch data: \(error)")
                completion(false)
            }
        }
    }
}
