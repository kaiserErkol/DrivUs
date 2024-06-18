//
//  RidesService.swift
//  DrivUs
//
//  Created by MacBook on 30.04.24.
//

import Foundation

class RidesService {
    static let shared = RidesService()
    
    func fetchAllRides(completion: @escaping ([Model.RideModel.Ride]?) -> Void) {
        guard let url = URL(string: "http://172.20.10.2:3000/rides") else {
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
                let loadedRides = try JSONDecoder().decode([Model.RideModel.Ride].self, from: data)
                
                completion(loadedRides)
            } catch {
                print("Error decoding posts: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    func fetchRideById(byID rideId: String, completion: @escaping (Model.RideModel.Ride?) -> Void) {
        // Create the URL with the swipe ID
        guard let url = URL(string: "http://172.20.10.2:3000/rides/\(rideId)") else {
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
                let loadedRide = try JSONDecoder().decode(Model.RideModel.Ride.self, from: data)
                completion(loadedRide)
            } catch {
                print("Error decoding swipe: \(error)")
                completion(nil)
            }
        }.resume()
    }
        
    func createRide(ride: Model.RideModel.Ride, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://172.20.10.2:3000/rides") else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Specify POST method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(ride)
            request.httpBody = jsonData
        } catch {
            print("Error encoding match: \(error)")
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error creating match: \(error)")
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
    /**
     USAGE:
     let newRide  = RideObject(id: "1, ...")
     RidesService.shared.createRide(ride: newRide) { success in
         if success {
             print("Ride created successfully")
         } else {
             print("Failed to create Ride")
         }
     }
     */
}


