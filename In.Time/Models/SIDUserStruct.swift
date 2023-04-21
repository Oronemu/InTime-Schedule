import Foundation

struct SIDUser: Identifiable {
  var id: String
  var userName: String
  var phone: String
  var email: String
  var isAdmin: Bool
  
  var representation: [String: Any] {
    var repres = [String: Any]()
    repres["id"] = self.id
    repres["userName"] = self.userName
    repres["phone"] = self.phone
    repres["email"] = self.email
    repres["isAdmin"] = self.isAdmin
    
    return repres
  }
}
