import SwiftUI

struct MainSettingsView: View {
	@ObservedObject var settings = AppSettigs.shared
	
  var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			VStack(alignment: .leading, spacing: 15) {
				HStack {
					Text("Подгруппа")
					Spacer()
					Picker(selection: $settings.group) {
						Text("Первая").tag(1)
						Text("Вторая").tag(2)
					} label: {}
				}
				
				Divider()

				HStack {
					Text("Режим недели")
					Spacer()
					Picker(selection: $settings.weekParityMode) {
						Text("Нечетная").tag(1)
						Text("Четная").tag(2)
						Text("Автоопределение").tag(3)
					} label: {}
				}
				
				Divider()

				HStack {
					Text("Направление")
					Spacer()
					Picker(selection: $settings.direction) {
						Text("ВЕБ-разработка").tag(1)
						Text("ИИ-разработка").tag(2)
					} label: {}
				}
			}
			.padding(10)
		}
		.navigationTitle("Основное")
		.navigationBarTitleDisplayMode(.inline)
		
  }
}

struct MainSettingsView_Previews: PreviewProvider {
  static var previews: some View {
    MainSettingsView()
  }
}

