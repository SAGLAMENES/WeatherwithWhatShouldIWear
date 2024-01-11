import SwiftUI
import WeatherKit

struct WhatToWearView: View {
    @State private var time = Date.now
    @State private var shouldIWear = false
    public let model1: [HourWeather] = WeatherManager.shared.hourlyWeather
    
    @State var kis: [UIImage] = []
    @State var yaz: [UIImage] = []
    
    var body: some View {
        VStack() {
            VStack(alignment: .center, spacing: 30, content: {
                HStack(spacing: 20, content: {
                    Text("Select Time: ")
                        .font(.title)
                    
                    DatePicker("", selection: $time, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        
                })
                
                Button(action: {
                    shouldIWear = true
                }, label: {
                    Text("What Should I Wear")
                        .foregroundStyle(Color.white)
                        .padding(EdgeInsets(top: 15, leading: 70, bottom: 15, trailing: 70))
                        .background(Color.black.opacity(0.35))
                        .clipShape(Capsule())
                })
            })
            
            if shouldIWear {
                    let imagesToShow = (WeatherManager.shared.currentWeather?.temperature.value)! > 12.0 ? yaz : kis
                ScrollView(.horizontal){
                    HStack {
                        ForEach(imagesToShow, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                    }
                }
                    
            }
        }
        .onAppear() {
            kis.append(UIImage(named: "sapka")!)
            kis.append(UIImage(named: "eldiven")!)
            kis.append(UIImage(named: "atki")!)
            kis.append(UIImage(named: "bot")!)
            kis.append(UIImage(named: "semsiye")!)
            
            yaz.append(UIImage(named: "gozluk")!)
            yaz.append(UIImage(named: "ayakkabi")!)
            yaz.append(UIImage(named: "su")!)
        }
    }
    
    private func getSelectedHourWeather() -> HourWeather? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: time)
        let selectedHour = components.hour ?? 0

        if let index = model1.firstIndex(where: { calendar.component(.hour, from: $0.date) == selectedHour }) {
                return model1[index]
            }
        print("hata")
        return nil
    }
}

