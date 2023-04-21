import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ExamsViewModel: ObservableObject {
    
  @Published var exams = [Exam]()
  @Published var loading = false
  private var db = Firestore.firestore()

  init() {
    fetchData()
  }

func fetchData() {
  self.loading = true
  db.collection("exams").addSnapshotListener { (querySnapshot, error) in
    guard let documents = querySnapshot?.documents else {
      print("No exams in Firestore")
      return
    }
    
    self.exams = documents.compactMap { (queryDocumentSnapshot) -> Exam? in
      return try? queryDocumentSnapshot.data(as: Exam.self)
    }
  }
  
  DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
    self.loading = false
  }
}
    
}
