import SwiftUI

struct AboutAppView: View {
	
  @State private var message: String = ""
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack {
        Image("SyllabusLogo")
          .resizable()
          .scaledToFit()
          .frame(width: 125, height: 125)
          .clipShape(RoundedRectangle(cornerRadius: 25))
        Text("Syllabus")
        Text("Версия \(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String) - Бета")
          .foregroundColor(Color.init(.systemGray))
        VStack {
          Text("Приложение создано для отображения занятий и экзаменов для группы ФИТ-204 Кемеровского Государственного Университета.")
            //.Leading()
            .font(.system(size: 15))
            .multilineTextAlignment(.center)
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 25))
      }
      .padding(15)
    }
    .navigationTitle("О приложении")
    .navigationBarTitleDisplayMode(.inline)
    .shadow(color: Color.black.opacity(0.1), radius: 10)
  }
}

struct AboutAppView_Previews: PreviewProvider {
    static var previews: some View {
        AboutAppView()
    }
}
