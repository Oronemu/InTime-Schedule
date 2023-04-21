import Foundation
import FirebaseFirestore

class DatabaseService {
  
	static let shared = DatabaseService();  private init() { }
	
  private let db = Firestore.firestore()
  
  private var userRef: CollectionReference {
    return db.collection("users")
  }
  
  func setProfile(user: SIDUser, completion: @escaping (Result<SIDUser, Error>) -> ()) {
    userRef.document(user.id).setData(user.representation) { error in
      if let error = error {
        completion(.failure(error))
      } else {
        completion(.success(user))
      }
    }
  }
  
  func getProfile(completion: @escaping (Result<SIDUser, Error>) -> ()) {
    userRef.document(AuthService.shared.currentUser!.uid).getDocument { docSnapshot, error in
      guard let snap = docSnapshot else { return }
      guard let data = snap.data() else { return }
      guard let userName = data["userName"] as? String else { return }
      guard let id = data["id"] as? String else { return }
      guard let phone = data["phone"] as? String else { return }
      guard let email = data["email"] as? String else { return }
      guard let isAdmin = data["isAdmin"] as? Bool else { return }
      
      let user = SIDUser(id: id, userName: userName, phone: phone, email: email, isAdmin: isAdmin)
      
      completion(.success(user))
    }
  }
  
  func deleteProfile() {
    userRef.document(AuthService.shared.currentUser!.uid).delete { error in
      if let error = error {
        print(error.localizedDescription)
      } else {
        print("User DB data deleted succesfully!")
      }
    }
  }
}
