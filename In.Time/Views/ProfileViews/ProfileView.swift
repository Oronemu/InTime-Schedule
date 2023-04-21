import SwiftUI
import FirebaseCore
import FirebaseAuth

struct ProfileView: View {
  
	
	@ObservedObject var settings = AppSettigs.shared
	
	@State private var isAvatarAlertPresented: Bool = false
  @StateObject var viewModel: ProfileViewModel
  @State private var isDeletingALertShowed: Bool = false
  let creationDate = Auth.auth().currentUser?.metadata.creationDate
  
  var body: some View {
        VStack {
          HStack(spacing: 15) {
            VStack(alignment: .leading) {
              Text("\(viewModel.profile.userName)")
                .font(.system(size: 30, weight: .bold))
              Text("UID: \(viewModel.profile.id)")
                .foregroundColor(Color(.systemGray))
                .lineLimit(1)
              Text("Дата регистрации:  \(creationDate.unsafelyUnwrapped.formatted(.dateTime.day().month().hour().minute().locale(.current)))")
                .foregroundColor(Color(.systemGray))
              Text("Статус: \(viewModel.profile.isAdmin ? "Администратор" : "Пользователь")")
                .foregroundColor(Color(.systemGray))
              
            }
          }
          .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
          .padding(.leading, 20)

          List {
            Section {
              HStack {
                Text("Почта")
                Spacer()
                Text(viewModel.profile.email)
              }
              HStack {
                Text("Номер телефона: ")
                Spacer()
                TextField("Номер телефона", text: $viewModel.profile.phone)
                  .multilineTextAlignment(.trailing)
              }
              
            } header: {
              Text("Данные профиля")
                .foregroundColor(.primary)
                .font(.system(size: 20, weight: .semibold))
            }
          }
          .listStyle(.plain)
          
          
          
          Button {
            isDeletingALertShowed = true
          } label: {
            Text("Удалить аккаунт")
              .foregroundColor(.red)
          }
          
          Button {
            AuthService.shared.signOut()
						settings.logStatus = false
          } label: {
            Text("Выйти")
              .fontWeight(.semibold)
              .foregroundColor(.white)
              .frame(minWidth: 0, maxWidth: .infinity)
              .padding(.vertical)
              .background {
                RoundedRectangle(cornerRadius: 15, style: .circular)
                  .fill(.blue)
              }
          }
          .padding(10)
        }
        .redacted(reason: viewModel.profile.email == "" ? .placeholder : [])
        .onSubmit { viewModel.setProfile() }
        .onAppear { viewModel.getProfile() }
        .alert("Удаление учетной записи", isPresented: $isDeletingALertShowed) {
          Button(role: .cancel) {} label: { Text("Отмена") }
          Button(role: .destructive) {
						settings.logStatus = false
            AuthService.shared.deleteUser()
            DatabaseService.shared.deleteProfile()
          } label: { Text("Удалить") }

        } message: {
          Text("Вы уверены, что хотите удалить учетную запись? Это действие будет необратимо, все ваши данные будут удалены без возможности восстановления")
        }
        .navigationBarTitle("Профиль",displayMode: .inline)
    }
  }

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView(viewModel: ProfileViewModel(profile: SIDUser(id: "2021TIT1", userName: "Вася", phone: "123", email: "Bebrus", isAdmin: false)))
    
    SettingsView()
  }
}
