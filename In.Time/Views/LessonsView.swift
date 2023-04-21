import SwiftUI

struct LessonsView: View {
	
	
	@Environment(\.colorScheme) var colorScheme
	
	@ObservedObject var settings = AppSettigs.shared
	
	@StateObject private var lessonsViewModel: LessonsViewModel = .init()
	@State private var selectedDay = WeekUtils.currentNumberDayofWeek(date: Date())
	
	@Namespace private var animation
			
  var body: some View {
		NavigationView {
			ScrollView(.vertical, showsIndicators: false) {
				LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
					Section {
						ScrollView(.horizontal, showsIndicators: false) {
							HStack(spacing: 10) {
								ForEach (lessonsViewModel.currentWeek, id: \.self) { day in
									VStack {
										Text(lessonsViewModel.extractDate(date: day, format: "dd"))
												.font(.system(size:20))
												.fontWeight(.semibold)
										Text(lessonsViewModel.extractDate(date: day, format: "EE"))
												.font(.system(size:15))
												.fontWeight(.semibold)
									}
									.foregroundColor(lessonsViewModel.isToday(date: day) ? .white : .gray)
									.frame(width: 45, height: 70)
									.background (
										ZStack {
											if lessonsViewModel.isToday(date: day) {
												Capsule()
													.fill(Color.init(settings.themeColor))
													.padding(2)
													.matchedGeometryEffect(id: "CURRENTDAY", in: animation)
											}
										}
									)
									.contentShape(Capsule())
									.onTapGesture {
										selectedDay = WeekUtils.currentNumberDayofWeek(date: day)
										withAnimation {
											lessonsViewModel.currentDay = day
										}
									}
								}
							}
						}
						.background(Color(.secondarySystemGroupedBackground))
						.clipShape(RoundedRectangle(cornerRadius: 25))
						.shadow(color: Color.black.opacity(0.1), radius: 10)
						
						if lessonsViewModel.loading {
							VStack {
								ProgressView()
									.progressViewStyle(CircularProgressViewStyle())
									.scaleEffect(1.5,anchor: .center)
							}
						} else {
							if (lessonsViewModel.lessons.filter{$0.day == selectedDay}.isEmpty) {
								VStack {
									Image("Sleeping")
										.resizable()
										.frame(width: 250, height: 200)
									Text("В этот день занятий нет!")
										.font(.system(size: 15, weight: .semibold))
									Text("cегодня можно поспать 😴")
										.font(.system(size: 15))
								}
							} else {
								ForEach(lessonsViewModel.lessons.filter {
									$0.day == selectedDay
									&& ($0.group == settings.group || $0.group == 0)
									&& ($0.direction == settings.direction || $0.direction == 0)
									&& ($0.week == lessonsViewModel.getParity() || $0.week == 0)
								}) {
									lesson in VStack(alignment: .center) {
										LessonCardView(lesson: lesson)
											.shadow(color: Color.black.opacity(0.1), radius: 10)
									}
								}
							}
						}
					} header: {
						ZStack {
							StickyHeader {
								Image("Forest")
									.resizable()
									.scaledToFill()
									.offset(y: -70)
							}
							.padding(-10)
							
							HeaderView(viewModel: lessonsViewModel)
								.shadow(color: Color.black.opacity(0.1), radius: 10)
						}
					}
				}
				.padding(10)
				.padding(.top, 50)
			}
		}

  }
}

struct HeaderView: View {
	
	@ObservedObject var settings = AppSettigs.shared
	
	var viewModel: LessonsViewModel
	
	var body: some View {
		HStack(spacing: 10){
			VStack(alignment: .leading) {
				Text("Сегодня")
					.foregroundColor(.gray)
				Text(viewModel.extractDate(date: Date(), format: "EEEE").capitalizingFirstLetter())
					.font(.largeTitle.bold())
				Text("Неделя \(WeekUtils.currentWeekNumber(date: "01.09.2022", dateFormat: "dd/MM/yyyy")), \(WeekUtils.isEven() ? "четная" : "нечетная")")
						.foregroundColor(.gray)
			}
			.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

			VStack {
				 Menu {
					 Menu("Неделя") {
						 Picker("",selection: $settings.weekParityMode) {
							 Text("Нечетная").tag(1)
							 Text("Четная").tag(2)
							 Text("Автоопределение").tag(3)
						 }
					 }
					 Menu("Группа") {
						 Picker("", selection: $settings.group) {
							 Text("Первая").tag(1)
							 Text("Вторая").tag(2)
						 }
					 }
				 } label: {
					 Image(systemName: "ellipsis.circle")
						 .foregroundColor(Color.init(settings.themeColor))
						 .font(.system(size: 32))
				 }
			}

		}
		.padding()
		.background(Color(.secondarySystemGroupedBackground))
		.clipShape(RoundedRectangle(cornerRadius: 25))
	}
}


struct LessonCardView: View {
	
	var lesson: Lesson
	
	var body: some View {
		HStack {
			VStack(alignment: .leading, spacing: 5) {
				Text(lesson.lessonName)
					.font(.system(size: 18, weight: .medium))
				Text("\(Image(systemName: "person")) \(lesson.teacher)")
					.foregroundColor(.gray)
				Text("\(Image(systemName: "building")) \(lesson.cabinet)")
					.foregroundColor(.gray)
				Spacer()
				
				Text("\(lesson.startTime) - \(lesson.endTime)")
					.font(.system(size: 17, weight: .medium))

			}
			.frame(maxWidth: .infinity, alignment: .leading)
			
			VStack(alignment: .trailing, spacing: 10) {
				Text(lesson.lessonType)
					.background (
						ZStack {
							Capsule()
								.fill(lesson.lessonType == "Лекция" ? .red : .blue)
								.padding(-5)
						}
					)
					.foregroundColor(.white)
					.font(.system(size: 15))
				Spacer()
				Text(lesson.count)
					.foregroundColor(.gray)
			}
		}
		.padding()
		.background(Color(.secondarySystemGroupedBackground))
		.clipShape(RoundedRectangle(cornerRadius: 25))
	}
}

struct StickyHeader<Content: View>: View {
	var minHeight: CGFloat
	var content: Content
	
	init(minHeight: CGFloat = 100, @ViewBuilder content: () -> Content) {
		self.minHeight = minHeight
		self.content = content()
	}
	
	var body: some View {
		GeometryReader { geometry in
			if (geometry.frame(in: .global).minY <= 0) {
				content
					.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
			} else {
				content
					.offset(y: -geometry.frame(in: .global).minY)
					.frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
			}
		}
		.frame(minHeight: minHeight)
	}
}

struct LessonsView_Previews: PreviewProvider {
	static var previews: some View {
		LessonsView()
	}
}
