import Foundation

class WeekUtils {
		
	static func currentNumberDayofWeek(date: Date) -> Int {
		return Calendar.current.component(.weekday, from: date)
	}
	
	static func currentWeekNumber(date: String, dateFormat: String) -> Int {
		let calendar = Calendar(identifier: .gregorian)
		let dateFormatter = DateFormatter()

		dateFormatter.dateFormat = dateFormat

		let formatedDate = dateFormatter.date(from: date)!
		let weekNumber = calendar.component(.weekOfYear, from: formatedDate)

		return weekNumber
	}

	static func currentWeekNumber() -> Int {
		let calendar = Calendar(identifier: .gregorian)
		let weekNumber = calendar.component(.weekOfYear, from: Date.init(timeIntervalSinceNow: 0))

		return weekNumber
	}
	
	static func isEven() -> Bool {
		if currentWeekNumber(date: "01.09.2022", dateFormat: "dd/MM/yyyy") % 2 == 0 {
			return true
		} else {
			return false
		}
	}
}
