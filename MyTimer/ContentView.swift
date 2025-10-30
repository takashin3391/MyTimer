//
//  ContentView.swift
//  MyTimer
//
//  Created by Takayama on 2025/10/28.
//

import SwiftUI

struct ContentView: View {
    @State var timerHandler : Timer?
    
    @State var count = 0
    
    @AppStorage("timer_value") var timerValue = 10
    
    @State var showAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("backgroundTimer")
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                VStack(spacing:30.0) {
                    Text("残り\(timerValue - count)秒")
                        .font(.largeTitle)
                    HStack {
                        Button {
                            //スタート時の動作
                            startTimer()
                        } label: {
                            Text("スタート")
                                .font(.title)
                                .foregroundColor(Color.white)
                                .frame(width: 140, height: 140)
                                .background(Color("startColor"))
                                .clipShape(Circle())
                        }
                        
                        Button {
                            //ストップ時の動作
                            if let unwrappedTimer = timerHandler {
                                if unwrappedTimer.isValid == true {
                                    unwrappedTimer.invalidate( )
                                }
                            }
                        } label: {
                            Text("ストップ")
                                .font(.title)
                                .foregroundColor(Color.white)
                                .frame(width: 140, height: 140)
                                .background(Color("stopColor"))
                                .clipShape(Circle())
                        }
                    }
                }
            }
            .onAppear {
                count = 0
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        SettingView()
                    } label: {
                        Text("秒数設定")
                    }
                }
            }
            .alert("終了", isPresented: $showAlert) {
                Button("OK") {
                    print("OKタップされました")
                }
            } message: {
                Text("タイマー終了時間です")
            }
        }
    }
    
    func countDownTimer() {
        count += 1
        if timerValue - count <= 0 {
            timerHandler?.invalidate()
            showAlert = true
        }
    }
    
    func startTimer() {
        if let unwrappedTimerHandler = timerHandler {
            if unwrappedTimerHandler.isValid == true {
                return
            }
        }
        
        if timerValue - count <= 0 {
            count = 0
        }
        
        timerHandler = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            countDownTimer()
        }
    }
}


#Preview {
    ContentView()
}
