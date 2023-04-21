import SwiftUI

struct AppearanceSetingsView: View {

	@ObservedObject var settings = AppSettigs.shared

  let appIcons: [String] = ["AppIconOriginal", "AppIconGreen", "AppIconGreen2", "AppIconPink","AppIconNeon"]
  let icons: [String] = ["pAppIconOriginal", "pAppIconGreen", "pAppIconGreen2", "pAppIconPink","pAppIconNeon"]

  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      LazyVStack(spacing: 15) {
        VStack {
          Text("Системная иконка")
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(Color.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
          ScrollView(.horizontal, showsIndicators: false) {
            HStack {
              ForEach (Array(icons.enumerated()), id: \.offset) { index, icon in
                VStack {
                  Image(icon)
                    .resizable()
                    .frame(width: 65,height: 65)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                  
                }
                .padding(5)
                .frame(minHeight: 70)
                .contentShape(Capsule())
                .onTapGesture {
									settings.activeAppIcon = appIcons[index]
									UIApplication.shared.setAlternateIconName(settings.activeAppIcon)
                }
                .overlay (
                  ZStack {
										if settings.activeAppIcon == appIcons[index%appIcons.count] {
                      RoundedRectangle(cornerRadius: 20)
												.stroke(Color(settings.themeColor), lineWidth: 3)
                    }
                  }
                )
              }
            }
            .padding(5)
          }
        }
        .padding(15)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .shadow(color: Color.black.opacity(0.1), radius: 10)
        
        NavigationLink(destination: ColorPickView()) {
          CloudButton(title: "Цветовой акцент",
                      subtitle: "Выбор основного цвета для элементов интерфейса приложения",
                      imageName: "paintpalette.fill")
        }
        .buttonStyle(ScaleButtonStyle())
        
        VStack {
          Text("Тема приложения")
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(Color.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
          Text("Ручное переключение светлого и темного режима приложения")
            .font(.system(size: 12, weight: .regular))
            .foregroundColor(Color.init(.systemGray))
            .frame(maxWidth: .infinity, alignment: .leading)
					Picker("Mode", selection: $settings.isDarkMode) {
              Text("Светлая").tag(false)
              Text("Темная").tag(true)
          }
          .pickerStyle(SegmentedPickerStyle())
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 60)
        .multilineTextAlignment(.leading)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .shadow(color: Color.black.opacity(0.1), radius: 10)
    
      }
      .padding(10)
    }
    .navigationTitle("Внешний вид")
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct AppearanceSetingsView_Previews: PreviewProvider {
  static var previews: some View {
    AppearanceSetingsView()
  }
}
