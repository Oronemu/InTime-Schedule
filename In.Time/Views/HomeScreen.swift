import SwiftUI

struct HomeScreen: View {
	
	@State private var selectedTab: Int = 2

	@ObservedObject var settings = AppSettigs.shared
	
  var body: some View {
		TabView(selection: $selectedTab) {
			
			NavigationLazyView(ExamsView())
				.tabItem {
					VStack {
						Image(systemName: "graduationcap")
						Text("Экзамены")
					}
				}
				.tag(0)
			
			NavigationLazyView(LessonsView())
				.tabItem {
					VStack {
						Image(systemName: "book")
						Text("Расписание")
					}
				}
				.tag(2)

			NavigationLazyView(SettingsView())
				.tabItem {
					VStack {
						Image(systemName: "gearshape")
						Text("Настройки")
					}
				}
				.tag(3)
			
		}
		.accentColor(Color.init(settings.themeColor))
  }
}

struct NavigationLazyView<Content: View>: View {
	let build: () -> Content
	
	init(_ build: @autoclosure @escaping () -> Content){
		self.build = build
	}
	
	var body: Content {
		build()
	}
}

struct HomeScreen_Previews: PreviewProvider {
	static var previews: some View {
		HomeScreen()
	}
}
