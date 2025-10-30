//
//  SettingView.swift
//  MyTimer
//
//  Created by Takayama on 2025/10/28.
//

import SwiftUI

struct SettingView: View {
    @AppStorage("timer_value") var timerValue = 10
    
    var body: some View {
        ZStack {
            Color("backgroundSetting")
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("\(timerValue)秒")
                    .font(.largeTitle)
                
                Spacer()
                //10秒毎
                Picker(selection: $timerValue) {
                    Text("10")
                        .tag(10)
                    Text("20")
                        .tag(20)
                    Text("30")
                        .tag(30)
                    Text("40")
                        .tag(40)
                    Text("50")
                        .tag(50)
                    Text("60")
                        .tag(60)
                }label: {
                    Text("選択")
                }
                .pickerStyle(.wheel)
                Spacer()
            }
        }
    }
}

#Preview {
    SettingView()
}
