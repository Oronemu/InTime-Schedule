import SwiftUI
import FirebaseCore
import AuthenticationServices

struct LoginView: View {
	
	
	@Environment(\.colorScheme) var colorScheme
	@ObservedObject var settings = AppSettigs.shared
  
  @State private var userName: String = ""
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var confirmPassword = ""
  @State private var alertMessage: String = ""

  @State private var isSheetShowed: Bool = false
  @State private var isAuth: Bool = true
  @State private var isShowAlert: Bool = false

  var body: some View {
		if !settings.logStatus {
      VStack(alignment: .center, spacing: 15) {
        Spacer()

        Image(systemName: "person.circle.fill")
          .font(.system(size: 60))
        
        Text(isAuth ? "Войти в учетную запись SID" : "Создать учетную запись SID")
          .font(.system(size: 20))

        if !isAuth {
          LoginTextField(text: $userName, isSecure: false, hint: "Имя пользователя")
            .padding(.top, 50)
        }
        
        LoginTextField(text: $email, isSecure: false, hint: "Электронная почта")
          .padding(.top, 20)
        
        LoginTextField(text: $password, isSecure: true, hint: "Пароль")
          .padding(.top, 20)
        
        if !isAuth {
          LoginTextField(text: $confirmPassword, isSecure: true, hint: "Повторите пароль")
            .padding(.top, 20)
        }
        
        Button {
          if isAuth {
            AuthService.shared.signIn(email: self.email, password: self.password) { result in
              switch result {
              case .success(_):
                UIApplication.shared.closeKeyboard()
								self.settings.logStatus = true
              case .failure(let error):
                self.alertMessage = "Ошибка авторизации: \(error.localizedDescription)"
                self.isShowAlert.toggle()
              }
            }
          } else {
            guard password == confirmPassword else {
              self.alertMessage = "Пароли не совпадают"
              self.isShowAlert.toggle()
              return
            }
            AuthService.shared.signUp(userName: self.userName, email: self.email, password: self.password) { result in
              switch result {
              case .success(_):
                print("Succesful register")
                self.isAuth = true
              case .failure(let error):
                alertMessage = error.localizedDescription
                self.isShowAlert.toggle()
              }
            }
          }
        } label: {
          Text(isAuth ? "Войти" : "Создать аккаунт")
            .fontWeight(.semibold)
            .foregroundColor(colorScheme == .light ? .white : .black)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.vertical)
            .background {
              RoundedRectangle(cornerRadius: 15, style: .circular)
                .fill(colorScheme == .light ? .black : .white)
            }
        }

        Button {
          isAuth.toggle()
        } label: {
          Text(isAuth ? "Создать учетную запись" : "Войти в учетную запись")
            .foregroundColor(Color(.systemGray))
        }
        
        Spacer()
        
//        Button {
//          isSheetShowed = true
//        } label: {
//          Text("Зачем мне регистрироваться?")
//            .foregroundColor(Color(.systemGray))
//        }.sheet(isPresented: $isSheetShowed) {
//          SheetInfo()
//        }
      }
      .padding(15)
      .alert(alertMessage, isPresented: $isShowAlert) { Button { } label: { Text("Ок") }}
      .animation(Animation.spring(response: 0.5, dampingFraction: 1, blendDuration: 0.8), value: isAuth)

    } else {
      ProfileView(viewModel: ProfileViewModel(profile: SIDUser(id: "", userName: "", phone: "", email: "", isAdmin: false)))
    }
  }
}

struct ServiceLoginButton: View {

  @Environment(\.colorScheme) var colorScheme
  var serviceLogo: String
  var serviceName: String

  var body: some View {
    HStack {
      Image(serviceLogo)
        .resizable()
        .renderingMode(.template)
        .aspectRatio(contentMode: .fit)
        .frame(width: 25, height: 25)
        .frame(height: 45)

      Text("Войти через \(serviceName)")
        .font(.callout)
        .fontWeight(.semibold)
        .lineLimit(1)
    }
    .padding(.vertical, 5)
    .frame(minWidth: 0, maxWidth: .infinity)
    .foregroundColor(colorScheme == .light ? .white : .black)
    .background {
      RoundedRectangle(cornerRadius: 15, style: .continuous)
        .fill(.primary)
    }
  }
}

struct LoginTextField: View {
  
  @Binding var text: String
  @FocusState var isEnabled: Bool

  var isSecure: Bool
  var hint: String

  var body: some View {
    VStack(alignment: .leading, spacing: 15) {
      
      if isSecure {
        SecureField(hint, text: $text)
          .focused($isEnabled)
      } else {
        TextField(hint, text: $text)
          .focused($isEnabled)
      }
        
      ZStack(alignment: .leading) {
        Rectangle()
          .fill(.primary.opacity(0.2))
        Rectangle()
          .fill(.primary)
          .frame(width: isEnabled ? nil : 0, alignment: .leading)
          .animation(.easeInOut(duration: 0.3), value: isEnabled)
      }
      .frame(height: 2)
    }
  }
}

struct SheetInfo: View {
  var body: some View {
    RoundedRectangle(cornerRadius: 15)
      .frame(width: 50, height: 5)
      .padding(.top, 5)
    
    ScrollView(.vertical, showsIndicators: false){
      VStack {
        HStack {
          Image(systemName: "icloud.and.arrow.up.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
        }
        .padding(.bottom, 20)
        
        VStack(alignment: .leading) {
          Text("SID - твое преимущество!")
            .font(.system(size: 25, weight: .bold))
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.bottom, 15)
          Text("Учетная запись даст вам следующие возможности")
            .multilineTextAlignment(.leading)
            .padding(.bottom, 15)
          Text("⦿ Синхронизация настроек из облака\n⦿ Доступ к ранее недоступным функциям для не зарегистрированных пользователей\n⦿ Уникальные достижения за выполнение целей и многое другое")
            .multilineTextAlignment(.leading)
            .padding(.bottom, 15)
          Text("Ваша личная информация никогда не будет использована в каких-либо корыстных целях и не будет передана третьим лица. Мы гарантируем, что не будем отправлять вам рекламные и иные сообщения без вашего согласия.")
            .font(.system(size: 15, weight: .regular))
            .foregroundColor(Color(.systemGray))
            .multilineTextAlignment(.leading)
            .padding(.bottom, 15)
          Text("Учтите, что в данный момент аккаунты находятся в режиме бета тестирования, поэтому не содержат некоторый функционал. Но вы все равно можете зарегистрироваться, дальнейшее функциональное расширение учетных записей не повляет на состояние вашей текущей учетной записи. ")
            .font(.system(size: 13, weight: .regular))
            .foregroundColor(Color(.systemYellow))
            .padding()
            .overlay (
              RoundedRectangle(cornerRadius: 15)
                .stroke(Color(.systemYellow), lineWidth: 3)
            )
        }
      }
      .padding(20)
    }
  }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}
