import SwiftUI

struct ContentView: View {
    @State private var timerHandler: Timer?
    @State private var count = 0
    @AppStorage("timer_value") private var timerValue = 10
    @State private var showAlert = false

    private let buttonSize: CGFloat = 140
    private var remaining: Int { max(timerValue - count, 0) }

    var body: some View {
        NavigationStack {
            ZStack {
                Image("backgroundTimer")
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                VStack(spacing: 30) {
                    Text("残り\(remaining)秒")
                        .font(.largeTitle)
                        .monospacedDigit()
                    HStack {
                        Button(action: startTimer) {
                            Text("スタート")
                                .font(.title)
                                .foregroundColor(.white)
                                .frame(width: buttonSize, height: buttonSize)
                                .background(Color("startColor"))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("タイマーを開始")

                        Button(action: stopTimer) {
                            Text("ストップ")
                                .font(.title)
                                .foregroundColor(.white)
                                .frame(width: buttonSize, height: buttonSize)
                                .background(Color("stopColor"))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("タイマーを停止")

                        Button(action: resetTimer) {
                            Text("リセット")
                                .font(.title)
                                .foregroundColor(.white)
                                .frame(width: buttonSize, height: buttonSize)
                                .background(Color.blue)
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("タイマーをリセット")
                    }
                }
            }
            .onAppear { resetTimer() }
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
                Button("OK") { }
            } message: {
                Text("タイマー終了時間です")
            }
        }
    }

    private func startTimer() {
        guard timerHandler?.isValid != true else { return }
        if remaining == 0 { count = 0 }
        timerHandler = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            tick()
        }
    }

    private func tick() {
        count += 1
        if remaining <= 0 {
            finishTimer()
        }
    }

    private func stopTimer() {
        timerHandler?.invalidate()
    }

    private func resetTimer() {
        stopTimer()
        count = 0
    }

    private func finishTimer() {
        stopTimer()
        showAlert = true
    }
}

#Preview {
    ContentView()
}
