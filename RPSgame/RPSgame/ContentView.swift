import SwiftUI

struct ContentView: View {
    @State private var appMove = Int.random(in: 0...2)
    @State private var playerScore = 0
    @State private var round = 1
    @State private var shouldWin = Bool.random()
    @State private var showAlert = false
    
    let moves = ["Rock", "Paper", "Scissors"]
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.red, .yellow]), startPoint: .topLeading, endPoint: .bottom)
                    .ignoresSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    Text("App's Move: \(moves[appMove])")
                        .font(.largeTitle)
                        .padding()
                        .bold()
                    
                    Text(shouldWin ? "You Need to Win!" : "You Need to Lose!")
                        .font(.title2)
                        .padding()
                    
                    Spacer()
                    
                    HStack {
                        ForEach(0..<3) { number in
                            Button(action: {
                                playerChoiceTapped(number)
                            }) {
                                Text(moves[number])
                                    .font(.system(size: 20))
                                    .padding()
                                    .background(Color.black)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Text("Score: \(playerScore)")
                        .font(.title)
                        .padding()
                    
                    Text("Round: \(round) / 10")
                        .font(.subheadline)
                        .padding()
                    
                    Spacer()
                }
                .padding()
                .alert("Game Over", isPresented: $showAlert) {
                    Button("Restart", action: restartGame)
                } message: {
                    Text("Your final score is \(playerScore)")
                }
            }
            .navigationTitle("RPS")
        }
    }
    
    func playerChoiceTapped(_ number: Int) {
        let result = determineResult(playerMove: number)
        
        if result == "Win" {
            playerScore += shouldWin ? 1 : -1
        } else if result == "Lose" {
            playerScore += shouldWin ? -1 : 1
        }
        
        nextRound()
    }
    
    func determineResult(playerMove: Int) -> String {
        if playerMove == appMove {
            return "Tie"
        }
        
        let isWin = (playerMove == (appMove + 1) % 3)
        return isWin ? "Win" : "Lose"
    }
    
    func nextRound() {
        if round == 10 {
            showAlert = true
        } else {
            round += 1
            appMove = Int.random(in: 0...2)
            shouldWin.toggle()
        }
    }
    
    func restartGame() {
        playerScore = 0
        round = 1
        appMove = Int.random(in: 0...2)
        shouldWin = Bool.random()
        showAlert = false
    }
}

#Preview {
    ContentView()
}
