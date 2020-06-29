//
//  MyWidget.swift
//  MyWidget
//
//  Created by Farshid on 6/29/20.
//

import WidgetKit
import SwiftUI


struct WidgetModel : TimelineEntry {
    var date: Date
    var currentTime:String
    var today:String
    
}

struct DataProvider : TimelineProvider {
    func timeline(with context: Context, completion: @escaping (Timeline<WidgetModel>) -> ()) {
        
        let date = Date()
        let today = date.getFormattedDate(format: "yyyy-MM-dd")
        let time = date.getFormattedDate(format: "hh:mm:ss a")
        
        
        let widgetModel = WidgetModel(date: date, currentTime: time,today: today)
        
        
        let refresh = Calendar.current.date(byAdding: .second, value: 10, to: date)!
        
        let timeLine = Timeline(entries: [widgetModel],policy: .after(refresh))
        
        completion(timeLine)
        
    }
    
    func snapshot(with context: Context, completion: @escaping (WidgetModel) -> ()) {
        
        let date = Date()
        let today = date.getFormattedDate(format: "yyyy-MM-dd")
        let time = date.getFormattedDate(format: "hh:mm:ss a")
        
        
        let widgetModel = WidgetModel(date: date, currentTime: time,today: today)
        
        completion(widgetModel)
        
    }
}

struct WidgetView : View {
    
    var model: DataProvider.Entry
    
    @State var isStart:Bool = false
    
    var body: some View {
        
        VStack {
            Spacer()
            HStack {
                Image(systemName: "cloud.sun")
                    .foregroundColor(.white)
                Spacer()
                Text("32 C")
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .font(.system(size: 14))
                    .padding(.all,5)
                Spacer()
            }.padding(.top, 5)
            .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(.blue)
                Text(model.today)
                    .foregroundColor(.blue)
                    .fontWeight(.regular)
                    .font(.system(size: 14))
                    .padding(.all,5)
                Spacer()
            }
            .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .padding([.top,.bottom], /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .background(Color.yellow)
            Divider()
            
            HStack {
                Image(systemName: "clock")
                    .foregroundColor(.white)
                Text(model.currentTime)
                    .foregroundColor(.white)
                    .fontWeight(.regular)
                    .font(.system(size: 14))
                    .padding(.all,5)
                Spacer()
            }
            .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .padding(.bottom, 5)
            
            Spacer()
        }.background(Color.blue)
    }
}

@main
struct Config : Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "My Widget", provider: DataProvider(), placeholder: EmptyView()) { data in
            WidgetView(model: data)
        }
        
        .supportedFamilies([.systemSmall])
        .description(Text("some description for widget"))
        
    }
}


extension Date {
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
