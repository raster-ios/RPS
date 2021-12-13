//
//  ContentView.swift
//  RPS
//
//  Created by Gena Raster on 13.12.21.
//

import SwiftUI

struct ContentView: View {
    
    let gameItems = ["Rock", "Paper", "Scissors"]
    let gameProposal = ["Win", "Lose"]
    
    
    
    @State private var step = 1
    @State private var point = 0
    @State private var isShowingMessage = false
    @State private var playerChoice = "Rock"
    
    
    var body: some View {
        let nextStepper = AIStep(arr: gameItems, winLoseArr: gameProposal)
        
        NavigationView {
            let aiChoice = nextStepper.choiceItem
            let winLose = nextStepper.winLose
            
            VStack {
                Text("AI choose: \(aiChoice)")
                Text("You must: \(winLose)")
                Picker("Player choise", selection: $playerChoice) {
                    ForEach(gameItems, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                
                Button("Next".uppercased()) {
                    checkWinOrLose(ai: aiChoice, player: playerChoice, winOrLose: winLose)
                    step += 1
                    if step == 11 {
                        step = 0
                        isShowingMessage = true
                    }
                }
                .padding()
                .font(.headline)
                .frame(width: 100, height: 50)
                .foregroundColor(.white)
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                .alert("GameOver", isPresented: $isShowingMessage) {
                    Button("Continue", role: .cancel) {
                        point = 0
                    }
                } message: {
                    Text("Your score is \(point)")
                }
                
                
                

                Text("\(step)")
//                Text("\(point)")
            }
            .padding()
            .navigationTitle("RPS game")
            
        }
    }
    
    func checkWinOrLose (ai: String, player: String, winOrLose: String) {
        
        let answerSet = (ai, player, winOrLose)
        switch answerSet {
        case ("Rock", "Paper", "Win"):
            point += 1
        case ("Paper", "Scissors", "Win"):
            point += 1
        case ("Scissors", "Rock", "Win"):
            point += 1
        case ("Rock", _, "Lose") where answerSet.1 != "Paper":
            point += 1
        case ("Paper", _, "Lose") where answerSet.1 != "Scissors":
            point += 1
        case ("Scissors", _, "Lose") where answerSet.1 != "Rock":
            point += 1
        default:
            break
        }
    }
}




struct AIStep{
    
    let arr: [String]
    let winLoseArr: [String]
    
    var choiceItem: String {
        arr.randomElement()!
    }
    
    var winLose: String {
        winLoseArr.randomElement()!
    }
    
}

struct GameMessage {
    let gameProcess = "You must choose"
    let gameOverMessage = "Game over"
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
