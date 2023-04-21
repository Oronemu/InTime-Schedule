import SwiftUI

struct ExamsView: View {
    
  @StateObject var examsViewModel: ExamsViewModel = .init()

  var body: some View {
    NavigationView {
      GeometryReader { geometry in
        ScrollView(.vertical, showsIndicators: false) {
          LazyVStack(spacing: 15) {
            if examsViewModel.loading {
              VStack(alignment: .center) {
                ProgressView()
                  .progressViewStyle(CircularProgressViewStyle())
                  .scaleEffect(1.5,anchor: .center)
              }
              .frame(height: geometry.size.height)
            } else {
              if examsViewModel.exams.isEmpty {
                VStack {
                  Image("Exam")
                    .resizable()
                    .frame(width: 230, height: 230)
                  Text("Пока что расписания экзаменов нет")
                    .font(.system(size: 15, weight: .semibold))
                  Text("Но возможно оно появится позже 🤔")
                    .font(.system(size: 15))
                }
              } else {
                ForEach (examsViewModel.exams) { exam in
                  VStack {
                    ExamCardView(exam: exam)
                  }
                }
              }
            }
          }.padding(10)
        }
      }
      .navigationBarTitle(Text("Экзамены"),displayMode: .large)
    }
  }
}

func ExamCardView(exam: Exam) -> some View {
  HStack {
    VStack(alignment: .leading, spacing: 10) {
      Text(exam.examName)
        .font(.system(size: 18, weight: .semibold))
      Text("\(Image(systemName: "person")) \(exam.teacher)")
        .foregroundColor(.gray)
      Text("\(Image(systemName: "building")) \(exam.cabinet)")
        .foregroundColor(.gray)
      Text("\(exam.date) (\(exam.startTime))")
        .font(.system(size: 17, weight: .medium))
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    
    VStack (alignment: .trailing, spacing: 10){
      Text(exam.type)
        .foregroundColor(.white)
        .padding(6)
        .background(
          Capsule()
            .fill(exam.type == "Консультация" ?
                  Color.init(.systemBlue) :
                  Color.init(.systemCyan))
        )
      Spacer()
      if exam.isFEPO {
        Text("ФЭПО")
          .background (
            ZStack {
              Capsule()
                .fill(.cyan)
                .padding(-7)
            }
          )
          .foregroundColor(.white)
      }
    }
  }
  .padding()
  .background(Color(.secondarySystemGroupedBackground))
  .clipShape(RoundedRectangle(cornerRadius: 25))
  .shadow(color: Color.black.opacity(0.1), radius: 10)
}

struct ExamsView_Previews: PreviewProvider {
  static var previews: some View {
    ExamsView()
  }
}
