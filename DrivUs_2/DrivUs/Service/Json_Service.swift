//
//  Json_Service.swift
//  DrivUs
//
//  Created by MacBook on 04.06.24.
//

import Foundation

class JsonService {
    static let shared = JsonService()
    
    var manager = MatchManager()
    
    func fetchUsers(completion: @escaping ([UserObject]?) -> Void) {
        guard let url = URL(string: "http://localhost:3000/users") else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET" // Specify GET method
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching posts: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let loadedUsers = try JSONDecoder().decode([UserObject].self, from: data)                
                completion(loadedUsers)
            } catch {
                print("Error decoding posts: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    func fetchRides(completion: @escaping ([RideObject]?) -> Void) {
        guard let url = URL(string: "http://localhost:3000/rides") else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET" // Specify GET method
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching posts: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let loadedRides = try JSONDecoder().decode([RideObject].self, from: data)
                completion(loadedRides)
            } catch {
                print("Error decoding posts: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    func fetchRideById(byID rideID: String, completion: @escaping (RideObject?) -> Void) {
        guard var urlComponents = URLComponents(string: "http://localhost:3000/rides") else {
            completion(nil)
            return
        }
        
        // Append the ride ID as a query parameter
        urlComponents.queryItems = [URLQueryItem(name: "id", value: rideID)]
        
        guard let url = urlComponents.url else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET" // Specify GET method
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching ride: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let loadedRide = try JSONDecoder().decode(RideObject.self, from: data)
                completion(loadedRide)
            } catch {
                print("Error decoding ride: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    
    func fetchSwipes(completion: @escaping ([SwipeObject]?) -> Void) {
        guard let url = URL(string: "http://localhost:3000/swipes") else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching swipes: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let loadedSwipes = try JSONDecoder().decode([SwipeObject].self, from: data)
                
                //filter data here
                
                completion(loadedSwipes)
            } catch {
                print("Error decoding swipes: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    func fetchSwipeById(byID swipeId: String, completion: @escaping (SwipeObject?) -> Void) {
        guard var urlComponents = URLComponents(string: "http://localhost:3000/swipes") else {
            completion(nil)
            return
        }
        
        // Append the ride ID as a query parameter
        urlComponents.queryItems = [URLQueryItem(name: "id", value: swipeId)]
        
        guard let url = urlComponents.url else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET" // Specify GET method
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching swipe: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let loadedSwipe = try JSONDecoder().decode(SwipeObject.self, from: data)
                completion(loadedSwipe)
            } catch {
                print("Error decoding swipe: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    func createSwipes(user: UserObject, mySwipes: [SwipeObject], myRides: [RideObject]){
        
        /**
         TO FIX:
         Index should be updated by server
         */
        var index: Int = 0
        var swipesToPost = [SwipeObject]()
        var matchingRides = [RideObject]()
        
        matchingRides = manager.filterRides(rides: myRides, user: user)
 

        //find the last id
        for swipe in mySwipes {
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
                let newSwipe = SwipeObject(
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
            JsonService.shared.postSwipe(swipe: swipe) { success in
                if success {
                    print("Swipe posted successfully")
                } else {
                    print("Failed to post swipe")
                }
            }
        }
         
    }
    
    func postSwipe(swipe: SwipeObject,completion: @escaping (Bool) -> Void) {
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
        fetchSwipeById(byID: swipeId) { swipeObject in
            DispatchQueue.main.async {
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

}
