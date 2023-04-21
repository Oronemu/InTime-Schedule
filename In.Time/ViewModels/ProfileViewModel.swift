import Foundation

class ProfileViewModel: ObservableObject {
  
  @Published var profile: SIDUser
  
  init (profile: SIDUser) {
    self.profile = profile
  }
  
  func setProfile() {
    DatabaseService.shared.setProfile(user: self.profile) { result in
      switch result {
      case .success(let user):
        print(user.userName)
      case .failure(let error):
        print("Error occured when sending profile data: \(error.localizedDescription)")
      }
    }
  }
  
  func getProfile() {
    DatabaseService.shared.getProfile { result in
      switch result {
      case .success(let user):
        self.profile = user
      case .failure(let error):
        print("Error occered when geting profile info: \(error.localizedDescription)")
      }
    }
  }
}
