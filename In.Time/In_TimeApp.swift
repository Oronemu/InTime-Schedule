import SwiftUI
import SpriteKit
import FirebaseCore
import FirebaseMessaging

class AppDelegate: NSObject, UIApplicationDelegate {
	
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		
    FirebaseApp.configure()

    return true
  }
	
}

@main
struct In_TimeApp: App {
  
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
	@ObservedObject var settings = AppSettigs.shared
	
	var body: some Scene {
			WindowGroup {
				if !settings.onBoardingisShowed {
					IntroView(onBoardingisShowed: $settings.onBoardingisShowed)
						.environment(\.colorScheme, settings.isDarkMode ? .dark : .light)
						.accentColor(Color.init(settings.themeColor))
				} else {
					HomeScreen()
						.environment(\.colorScheme, settings.isDarkMode ? .dark : .light)
						.accentColor(Color.init(settings.themeColor))
				}
			}
	}
}


