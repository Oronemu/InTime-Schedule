import Foundation

import SwiftUI

struct ColorPickView: View {
	
	@ObservedObject var settings = AppSettigs.shared

  private let adaptiveColors: [String] = ["Aquamarin", "PacificBlue", "MintGreen"]
  private let notAdaptiveColors: [String] = ["RedSunset", "Graphite"]
  private let columns = [
    GridItem(.adaptive(minimum: 150))
  ]
  
  var body: some View {
      ScrollView(.vertical, showsIndicators: false) {
        LazyVStack(spacing: 15) {
          VStack {
            Text("Адаптивные цвета")
              .frame(maxWidth: .infinity, alignment: .leading)
              .font(.system(size: 25, weight: .semibold))
            Text("Данные цвета меняются в зависимости от системной темы устройства, адаптируясь под нее.")
              .frame(maxWidth: .infinity, alignment: .leading)
              .font(.system(size: 15))
              .foregroundColor(Color.init(.systemGray))
            LazyVGrid(columns: columns, spacing: 20) {
              ForEach(1...adaptiveColors.count, id: \.self) { number in
                Button {
									settings.themeColor = adaptiveColors[number%adaptiveColors.count]
                } label: {
                  ZStack {
                    Rectangle()
                      .fill(Color.init(adaptiveColors[number%adaptiveColors.count]))
                      .frame(minWidth: 150, minHeight: 150)
                      .clipShape(RoundedRectangle(cornerRadius: 15))
//                    Text("\(adaptiveColors[number%adaptiveColors.count])")
//                      .foregroundColor(.white)
//                      .font(.system(size: 25, weight: .semibold))
										if settings.themeColor == adaptiveColors[number%adaptiveColors.count] {
                      VStack {
                        Circle()
                          .fill(Color.white)
                          .frame(width: 15, height: 15)
                          .frame(maxWidth: .infinity, alignment: .trailing)
                          .padding(10)
                        Spacer()
                      }
                    }
                  }
                }
                .buttonStyle(ScaleButtonStyle())
              }
            }
          }
          .padding()
          .background(Color(.secondarySystemGroupedBackground))
          .clipShape(RoundedRectangle(cornerRadius: 25))
          .shadow(color: Color.black.opacity(0.1), radius: 10)
          
          VStack {
            Text("Не адаптивные цвета")
              .frame(maxWidth: .infinity, alignment: .leading)
              .font(.system(size: 25, weight: .semibold))
            Text("Данные цвета не меняются при смене системной темы устройства.")
              .frame(maxWidth: .infinity, alignment: .leading)
              .font(.system(size: 15))
              .foregroundColor(Color.init(.systemGray))
            LazyVGrid(columns: columns, spacing: 20) {
              ForEach(1...notAdaptiveColors.count, id: \.self) { number in
                Button {
									settings.themeColor = notAdaptiveColors[number%notAdaptiveColors.count]
                } label: {
                  ZStack {
                    Rectangle()
                      .fill(Color.init(notAdaptiveColors[number%notAdaptiveColors.count]))
                      .frame(minWidth: 150, minHeight: 150)
                      .clipShape(RoundedRectangle(cornerRadius: 15))
//                    Text("\(notAdaptiveColors[number%notAdaptiveColors.count])")
//                      .foregroundColor(.white)
//                      .font(.system(size: 25, weight: .semibold))
										if settings.themeColor == notAdaptiveColors[number%notAdaptiveColors.count] {
                      VStack {
                        Circle()
                          .fill(Color.white)
                          .frame(width: 15, height: 15)
                          .frame(maxWidth: .infinity, alignment: .trailing)
                          .padding(10)
                        Spacer()
                      }
                    }
                  }
                }
                .buttonStyle(ScaleButtonStyle())
              }
            }
          }
          .padding()
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

struct ColorPickView_Previews: PreviewProvider {
  static var previews: some View {
    ColorPickView()
  }
}
