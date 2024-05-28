//
//  RidesService.swift
//  DrivUs
//
//  Created by MacBook on 30.04.24.
//

import Foundation

class RidesService {
    static let shared = RidesService()
    
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
    
    func createRide(ride: RideObject, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://localhost:3000/rides") else {
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


