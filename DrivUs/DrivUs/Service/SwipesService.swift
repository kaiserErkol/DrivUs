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
        guard var urlComponents = URLComponents(string: "http://localhost:3000/swipes") else {
            completion(nil)
            return
        }
        
        // Append the swipe ID as a query parameter
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
                let loadedSwipe = try JSONDecoder().decode(Model.SwipeModel.Swipe.self, from: data)
                completion(loadedSwipe)
            } catch {
                print("Error decoding swipe: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    // Update a specific swipe
    func updateSwipe(_ swipeId: String, _ acceptRide: Bool, _ user: Model.UserModel.User, completion: @escaping (Bool) -> Void) {
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
                updateData["firstAnswer"] = acceptRide
                updateData["firstUserId"] = user.id
            } else if swipeToUpdate.secondUserId == user.id {
                updateData["secondAnswer"] = acceptRide
                updateData["secondUserId"] = user.id
            } else {
                // If neither ID matches, there's a logic error
                completion(false)
                return
            }
            
            // Proceed to update the found swipe
            self.updateSwipeOnServer(swipeToUpdate, updateData ,completion: completion)
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
}
