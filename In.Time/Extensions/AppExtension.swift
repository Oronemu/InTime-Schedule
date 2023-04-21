import Foundation
import FirebaseMessaging
import UIKit

extension UIApplication {
  func closeKeyboard() {
    sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
  
  func rootController() -> UIViewController {
    guard let window = connectedScenes.first as? UIWindowScene else { return .init() }
    guard let viewController = window.windows.last?.rootViewController else { return .init() }
    
    return viewController
  }
}
