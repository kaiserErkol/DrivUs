import Foundation

class ViewModel_Swipes: ObservableObject {
    @Published private(set) var model = SwipeModel()
    @Published var isLoading = false
    
    var swipes: [SwipeObject] {
        return model.swipes
    }
    
    func getSwipes() -> [SwipeObject] {
        return model.swipes
    }
    
    func setSwipes(swipes: [SwipeObject]) {
        model.setSwipes(swipes)
    }
    
    func swipesLoaded(_ swipes: [SwipeObject]) {
        model.setSwipes(swipes)
    }
    
    func fetchSwipes() {
        isLoading = true
        JsonService.shared.fetchSwipes { [weak self] swipes in
            DispatchQueue.main.async {
                self?.setSwipes(swipes: swipes ?? [])
                self?.isLoading = false
            }
        }
    }
    
    func acceptSwipe(swipeId: String, acceptRide: Bool, userId: String) {
        JsonService.shared.updateSwipeRideId(swipeId: swipeId, acceptRide: acceptRide, userId: userId) { success in
            if success {
                print("Swipe updated successfully")
            } else {
                print("Failed to update swipe")
            }
        }
    }
    
    func swipe(at index: Int) -> SwipeObject? {
        return swipes.safeElement(at: index)
    }
}

extension Array {
    func safeElement(at index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
