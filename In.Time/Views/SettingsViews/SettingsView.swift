import SwiftUI

struct SettingsView: View {
	
  @State var selection: Int? = nil
	
  var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: false) {
        VStack(spacing: 15) {
          NavigationLink(destination: LoginView()) {
            CloudButton(title: "Профиль",
                        subtitle: "Управление параметрами синхронизации и учетной записи",
                        imageName: "person.fill")
          }
          .buttonStyle(ScaleButtonStyle())
          
          NavigationLink(destination: MainSettingsView()) {
            CloudButton(title: "Основное",
                        subtitle: "Управление основными параметрами работы приложения",
                        imageName: "gearshape.fill")
          }
          .buttonStyle(ScaleButtonStyle())
          
          NavigationLink(destination: AppearanceSetingsView()) {
            CloudButton(title: "Внешний вид",
                        subtitle: "Настройка параметров внешнего вида элементов приложения",
                        imageName: "iphone")
          }
          .buttonStyle(ScaleButtonStyle())
          
          NavigationLink(destination: AboutAppView()) {
            CloudButton(title: "О приложении",
                        subtitle: "Версия \(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String)",
                        imageName: "info.circle.fill")
          }
          .buttonStyle(ScaleButtonStyle())
          
        }
        .padding(10)
      }
      .navigationBarTitle(Text("Настройки"),displayMode: .large)
    }
  }
}

struct ScaleButtonStyle: ButtonStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .scaleEffect(configuration.isPressed ? 0.95 : 1)
  }
}

struct CloudButton: View {
	@ObservedObject var settings = AppSettigs.shared

  var title: String
  var subtitle: String
  var imageName: String
  
  var body: some View {
    HStack {
      VStack {
        Text(title)
          .font(.system(size: 20, weight: .bold))
          .foregroundColor(Color.primary)
          .frame(maxWidth: .infinity, alignment: .leading)
        Text(subtitle)
          .font(.system(size: 12, weight: .regular))
          .foregroundColor(Color.init(.systemGray))
          .frame(maxWidth: .infinity, alignment: .leading)
      }
     
      VStack {
        Image(systemName: imageName)
          .font(.title)
          .frame(width: 50, height: 50)
          .foregroundColor(.white)
					.background(Color.init(settings.themeColor))
          .clipShape(Circle())
      }
    }
    .padding()
    .frame(minHeight: 80)
    .multilineTextAlignment(.leading)
    .background(Color(.secondarySystemGroupedBackground))
    .clipShape(RoundedRectangle(cornerRadius: 25))
    .shadow(color: Color.black.opacity(0.1), radius: 10)
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
