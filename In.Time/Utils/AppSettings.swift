import Foundation
import SwiftUI

class AppSettigs: ObservableObject {
	
	@AppStorage("active_app_icon") var activeAppIcon = "AppIconOriginal"
	@AppStorage("log_status") var logStatus: Bool = false
	
	@AppStorage("isDarkMode") var isDarkMode: Bool = false
	@AppStorage("themeColor") var themeColor = "PacificBlue"
	@AppStorage("onBoardingisShowed") var onBoardingisShowed: Bool = false
	@AppStorage("group") var group = 1
	@AppStorage("direction") var direction = 1
	@AppStorage("weekparity") var weekParityMode = 3
	
	static let shared = AppSettigs()
	private init() {}
	
}
