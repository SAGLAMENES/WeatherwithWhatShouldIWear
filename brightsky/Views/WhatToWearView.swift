import SwiftUI
import WeatherKit

struct WhatToWearView: View {
    @State private var time = Date.now
    @State private var shouldIWear = false
    @State private var selectedHour1 = Int()
    @State private var selectedHour2 = Int()

    public let model1: [HourWeather] = WeatherManager.shared.hourlyWeather
    
    @State var kis: [UIImage] = []
    @State var hava0alti: [UIImage] = []
    @State var yaz: [UIImage] = []
    @State var yagmurlu: [UIImage] = []
    @State var mangal: [UIImage] = []
    
    var body: some View {
        VStack() {
            VStack(alignment: .center, spacing: 30, content: {
                HStack(spacing: 20, content: {
                    Text("Select Time: ")
                        .font(.title)
                    
                    Picker("Select Hour", selection: $selectedHour1) {
                        
                                    ForEach(0..<24) { hour in
                                        Text("\(hourString(from:WeatherManager.shared.hourlyWeather[hour].date)):00").tag(hour)
                                        
                                    }
                    }.onTapGesture {
                        shouldIWear = false
                    }
                                .pickerStyle(.menu)
                        .labelsHidden()
                    Text("-")
                        .font(.headline)
                    Picker("Select Hour", selection: $selectedHour2) {
                                    ForEach(0..<24) { hour in
                                        Text("\(hourString(from:WeatherManager.shared.hourlyWeather[hour+1].date)):00").tag(hour)
                                    }
                    }.onTapGesture {
                        shouldIWear = false
                    }
                                .pickerStyle(.menu)
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
                
                VStack {
                    Text("Tempreture is between-> \(WeatherManager.shared.hourlyWeather[selectedHour1].temperature.value.formatted())°C-\(WeatherManager.shared.hourlyWeather[selectedHour2].temperature.value.formatted())°C")
                        .bold()
                    HStack{
                        Image(systemName:  WeatherManager.shared.hourlyWeather[selectedHour1].symbolName)
                        Text("-")
                        Image(systemName:  WeatherManager.shared.hourlyWeather[selectedHour2].symbolName)
                    }
                    ScrollView(.horizontal){
                        HStack {
                            if WeatherManager.shared.hourlyWeather[selectedHour1].symbolName == "cloud.rain" || WeatherManager.shared.hourlyWeather[selectedHour2].symbolName == "cloud.rain"{
                                ForEach(yagmurlu, id: \.self) { image in
                                    Image(uiImage: image)
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                }
                            }
                           else if WeatherManager.shared.hourlyWeather[selectedHour1].temperature.value < 7.0 || WeatherManager.shared.hourlyWeather[selectedHour2].temperature.value < 7.0   {
                                ForEach(hava0alti, id: \.self) { image in
                                    Image(uiImage: image)
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                }
                            }
                            else if WeatherManager.shared.hourlyWeather[selectedHour1].temperature.value >= 7.0 && WeatherManager.shared.hourlyWeather[selectedHour1].temperature.value < 16.0 || WeatherManager.shared.hourlyWeather[selectedHour2].temperature.value >= 7.0 && WeatherManager.shared.hourlyWeather[selectedHour2].temperature.value < 16.0   {
                                ForEach(kis, id: \.self) { image in
                                    Image(uiImage: image)
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                }
                            }
                            else if WeatherManager.shared.hourlyWeather[selectedHour1].temperature.value >= 16.0 && WeatherManager.shared.hourlyWeather[selectedHour2].temperature.value < 30.0 || WeatherManager.shared.hourlyWeather[selectedHour2].temperature.value >= 16.0 && WeatherManager.shared.hourlyWeather[selectedHour2].temperature.value < 30.0 {
                                ForEach(yaz, id: \.self) { image in
                                    Image(uiImage: image)
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                }
                            }
                            else  {
                                 ForEach(mangal, id: \.self) { image in
                                     Image(uiImage: image)
                                         .resizable()
                                         .frame(width: 100, height: 100)
                                 }
                             }
                                        
                        }
                    }
                }
                    
            }
        }
        .onAppear() {
            kis.append(UIImage(named: "kisyagmur")!)
            kis.append(UIImage(named: "kisyagmur2")!)
            kis.append(UIImage(named: "kisyagmur3")!)
            
            hava0alti.append(UIImage(named: "kis1")!)
            hava0alti.append(UIImage(named: "kis2")!)
            hava0alti.append(UIImage(named: "kisyagmur")!)
            hava0alti.append(UIImage(named: "kisyagmur2")!)
            hava0alti.append(UIImage(named: "kisyagmur3")!)

            yaz.append(UIImage(named: "yaz1")!)
            yaz.append(UIImage(named: "yaz2")!)
            yaz.append(UIImage(named: "yazmangal")!)
            
            yagmurlu.append(UIImage(named: "yagmur")!)
            yagmurlu.append(UIImage(named: "yagmur2")!)
            yagmurlu.append(UIImage(named: "kisyagmur")!)
            yagmurlu.append(UIImage(named: "kisyagmur2")!)
            yagmurlu.append(UIImage(named: "kisyagmur3")!)
                
            mangal.append(UIImage(named:"mangal")!)
            mangal.append(UIImage(named:"mangal2")!)
            mangal.append(UIImage(named:"mangal3")!)
            mangal.append(UIImage(named:"yazmangal")!)

            
            
      
            print(WeatherManager.shared.hourlyWeather[1].symbolName)
            
        }
    }
    func hourString(from date: Date) -> String {
            let formatter = DateFormatter()
            // Set the desired date format
            formatter.dateFormat = "HH" // 24-hour format
            // formatter.dateFormat = "h a" // 12-hour format with AM/PM

            return formatter.string(from: date)
        }
}

