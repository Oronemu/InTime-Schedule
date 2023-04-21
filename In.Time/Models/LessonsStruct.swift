import Foundation
import FirebaseFirestoreSwift

struct Lesson: Identifiable, Hashable, Codable {
  @DocumentID var id: String? = UUID().uuidString
  var startTime:  String
  var endTime:  String
  var cabinet:  String
  var lessonName: String
  var lessonType: String
  var teacher:  String
  var count: String
  var day: Int
  var group: Int
  var week: Int
  var direction: Int
}
