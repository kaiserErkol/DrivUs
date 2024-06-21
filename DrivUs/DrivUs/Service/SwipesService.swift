import Foundation

class SwipesService {
    static let shared = SwipesService()
        
    // Fetch all swipes
    func fetchAllSwipes(completion: @escaping ([Model.SwipeModel.Swipe]?) -> Void) {
        guard let url = URL(string: "http://localhost:3000/swipes") else {
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
                let loadedSwipes = try JSONDecoder().decode([Model.SwipeModel.Swipe].self, from: data)
                
                completion(loadedSwipes)
            } catch {
                print("Error decoding posts: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    // Fetch a specific swipe by ID
    func fetchSwipeById(byID swipeId: String, completion: @escaping (Model.SwipeModel.Swipe?) -> Void) {
        // Create the URL with the swipe ID
        guard let url = URL(string: "http://localhost:3000/swipes/\(swipeId)") else {
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
                let loadedSwipe = try JSONDecoder().decode(Model.SwipeModel.Swipe.self, from: data)
                completion(loadedSwipe)
            } catch {
                print("Error decoding swipe: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    // Update a specific swipe
    func updateSwipe(_ swipeId: String, _ answer: Bool, _ user: Model.UserModel.User, completion: @escaping (Bool) -> Void) {
        
        fetchAllSwipes { swipes in
            guard let swipes = swipes else {
                completion(false)
                return
            }
            
            let filteredSwipes = MatchManager.shared.filterSwipesByUser(swipes, user)
            
            // Find the swipe to update
            guard let swipeToUpdate = filteredSwipes.first(where: { $0.id == swipeId }) else {
                completion(false)
                return
            }
            
            // Determine which field to update
            var updateData: [String: Any] = [:]
            
            if swipeToUpdate.firstUserId == user.id {
                updateData["firstAnswer"] = answer
                updateData["firstUserId"] = user.id
            } else if swipeToUpdate.secondUserId == user.id {
                updateData["secondAnswer"] = answer
                updateData["secondUserId"] = user.id
            } else {
                // If neither ID matches, there's a logic error
                completion(false)
                return
            }
            
            // Proceed to update the found swipe
            self.updateSwipeOnServer(swipeToUpdate, updateData) { success in
                if success {
                    // Check if both answers are true
                    self.checkSwipeAnswers(swipeToUpdate) { bothTrue in
                        if bothTrue {
                            
                            self.checkMatchDuplicate(swipeToUpdate, user) { isDuplicate in
                                
                                if !isDuplicate {
                                    self.createMatch(from: swipeToUpdate) { createdMatch in
                                        if createdMatch {
                                            print("")
                                            print("------------------------------")
                                            print("ITS A MATCH!!")
                                            print("------------------------------")
                                            print("")
                                            
                                            completion(true)
                                        }
                                        else {
                                            completion(false)
                                        }
                                    }
                                }
                                else {
                                    completion(false)
                                }
                                
                            }
                            
                        } else {
                            completion(false)
                        }
                    }
                } else {
                    completion(false)
                }
                
            }
        }
    }
    
    // Helper method to update swipe on the server
    private func updateSwipeOnServer(_ swipe: Model.SwipeModel.Swipe, _ updateData: [String:Any], completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://localhost:3000/swipes/\(swipe.id)") else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH" // Specify PATCH method
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: updateData, options: [])
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
            print("Error serializing update data: \(error)")
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error updating swipe: \(error)")
                completion(false)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Failed to update swipe")
                completion(false)
                return
            }
            
            completion(true)
        }.resume()
    }
    
    private func checkSwipeAnswers(_ swipe: Model.SwipeModel.Swipe, completion: @escaping (Bool) -> Void) {
        // Re-fetch the swipe to get the latest data
        fetchSwipeById(byID: swipe.id) { updatedSwipe in
            guard let updatedSwipe = updatedSwipe else {
                completion(false)
                return
            }
            
            let bothTrue = updatedSwipe.firstAnswer == true && updatedSwipe.secondAnswer == true
            completion(bothTrue)
        }
    }
    
    private func checkMatchDuplicate(_ swipe: Model.SwipeModel.Swipe, _ user: Model.UserModel.User, completion: @escaping (Bool) -> Void) {
        
        MatchesService.shared.fetchAllMatches { matches in
            guard let matches = matches else {
                completion(false)
                return
            }
            
            for match in matches {
                if match.swipeId == swipe.id {
                    completion(true)
                    return
                }
            }
            
            completion(false)
        }
    }
    
    private func createMatch(from swipe: Model.SwipeModel.Swipe, completion: @escaping (Bool) -> Void) {
        // Create the new match object with a new id
        print("")
        print("creating match")
        print("")
        var mymatches: [Model.MatchModel.Match] = []
        var idNumber: Int = 1
        
        MatchesService.shared.fetchAllMatches { matches in
            DispatchQueue.main.async {
                mymatches = matches ?? []
                for _ in mymatches {
                    idNumber += 1
                }
                
                let newMatch = Model.MatchModel.Match(id: String(idNumber), rideId: swipe.rideId, swipeId: swipe.id, firstUserId: swipe.firstUserId, secondUserId: swipe.secondUserId)
                
                // Save the new match object to the server
                guard let url = URL(string: "http://localhost:3000/matches") else {
                    completion(false)
                    return
                }
                
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                
                do {
                    let jsonData = try JSONEncoder().encode(newMatch)
                    request.httpBody = jsonData
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                } catch {
                    print("Error serializing match data: \(error)")
                    completion(false)
                    return
                }
                
                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print("Error creating match: \(error)")
                        completion(false)
                        return
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                        print("Failed to create match")
                        completion(false)
                        return
                    }
                    
                    completion(true)
                }.resume()
            }
        }
    }
}
