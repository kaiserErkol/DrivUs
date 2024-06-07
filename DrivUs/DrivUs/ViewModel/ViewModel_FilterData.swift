//
//  ViewModel_FilterData.swift
//  DrivUs
//
//  Created by MacBook on 07.06.24.
//

import Foundation

class ViewModel_FilteredData: ObservableObject {
    @Published private(set) var filteredSwipes: [Model.SwipeModel.Swipe] = []
    
    
    func filterSwipes(for rides: [Model.RideModel.Ride], swipes: [Model.SwipeModel.Swipe]) {
        let filterModel = Model.FilterDataByLoginModel(swipes: swipes, rides: rides)
        self.filteredSwipes = filterModel.filterSwipesByRides()
    }
}
