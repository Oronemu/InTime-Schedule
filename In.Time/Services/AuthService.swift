import Foundation
import CryptoKit
import FirebaseAuth

class AuthService {
  
	static let shared = AuthService(); private init() {}
	
  private let auth = Auth.auth()
	
  var currentUser: User? {
    return auth.currentUser
  }
  
  func signUp(userName: String, email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
    auth.createUser(withEmail: email, password: password) { result, error in
      if let result = result {
        let SIDUser = SIDUser(id: result.user.uid, userName: userName, phone: "", email: result.user.email!, isAdmin: false)
        DatabaseService.shared.setProfile(user: SIDUser) { resultdb in
          switch resultdb {
          case .success(_):
            completion(.success(result.user))
          case .failure(let error):
            completion(.failure(error))
          }
        }
        completion(.success(result.user))
      } else if let error = error {
        completion(.failure(error))
      }
    }
  }
  
  func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
    auth.signIn(withEmail: email, password: password) { result, error in
      if let result = result {
        completion(.success(result.user))
      } else if let error = error {
        completion(.failure(error))
      }
    }
  }
  
  func signOut() {
    do {
      try Auth.auth().signOut()
    } catch {
      print(error)
    }
  }
  
  func deleteUser() {
    let user = auth.currentUser
    
    user?.delete { error in
      if let error = error {
        print(error.localizedDescription)
      } else {
        print("Auth is deleted!")
      }
    }
  }
}
