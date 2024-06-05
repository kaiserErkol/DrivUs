import Foundation

class ViewModel_User: ObservableObject {
    @Published private(set) var model = UserModel()
        
    var users: [UserObject] {
        model.users
    }
    
    var currUser: UserObject {
        model.curr_user
    }
    
    func getCurrUser() -> UserObject {
        return model.curr_user
    }
    
    func setUsers(users: [UserObject]) {
        model.setUsers(users)
    }
    
    func setCurrUser(_ userId: String, rides: [RideObject], swipes: [SwipeObject]) {
        model.setCurrUser(userId)
        JsonService.shared.createSwipes(user: currUser, mySwipes: swipes, myRides: rides)
    }
    
    func usersLoaded(_ users: [UserObject]) {
        model.setUsers(users)
    }
    
    func getUserById(id: String) -> UserObject? {
        for user in users {
            if user.id == id {
                return user
            }
        }
        return StandardObject.default
    }
    
    func fetchUsers() {
        JsonService.shared.fetchUsers { [weak self] users in
            DispatchQueue.main.async {
                self?.setUsers(users: users ?? [])
            }
        }
    }
}
