import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class LessonsViewModel: ObservableObject {
	
  @Published var lessons = [Lesson]()
	@Published var currentWeek: [Date] = []
	@Published var currentDay: Date = Date()
	@Published var loading = false
	
	
	private var db = Firestore.firestore()
	private var settings = AppSettigs.shared
	
	init() {
		fetchCurrentWeek()
		fetchData()
	}
	
  func fetchData() {
    db.collection("lessons").addSnapshotListener { (querySnapshot, error) in
      guard let documents = querySnapshot?.documents else {
        print("No lessons in Firestore")
        return
      }
      
      self.lessons = documents.compactMap { (queryDocumentSnapshot) -> Lesson? in
        return try? queryDocumentSnapshot.data(as: Lesson.self)
      }
    }
  }
	
	func fetchCurrentWeek() -> Void {
		let today = Date()
		let calendar = Calendar.current
		let week = calendar.dateInterval(of: .weekOfMonth, for: today)
		
		guard let firstWeekDay = week?.start else {
			return
		}
		
		(0...6).forEach { day in
			if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
				currentWeek.append(weekday)
			}
		}
	}
	
	func extractDate(date: Date, format: String) -> String {
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "ru_RU")

		formatter.dateFormat = format
		
		return formatter.string(from: date)
	}
	
	func getParity() -> Int {
		switch settings.weekParityMode {
		case 1:
			return 1
		case 2:
			return 2
		case 3:
			if WeekUtils.isEven() {
				return 2
			} else {
				return 1
			}
		default:
			return 0
		}
	}
	
	
	
	func isToday(date: Date) -> Bool {
		let calendar = Calendar.current
		
		return calendar.isDate(currentDay, inSameDayAs: date)
	}
	
}
