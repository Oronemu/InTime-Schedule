import Foundation
import FirebaseFirestoreSwift

struct Exam: Identifiable, Hashable, Codable {
  @DocumentID var id: String? = UUID().uuidString
  var startTime:  String
  var cabinet:  String
  var examName: String
  var teacher:  String
  var isFEPO: Bool
  var type: String
  var date: String
}
