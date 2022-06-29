//
//  ContentView.swift
//  BullsEye
//
//  Created by Ritwik Pahwa on 17/05/22.
//

import SwiftUI

struct ContentView: View {
    
    struct LabelModeifier: ViewModifier{
        func body(content: Content) -> some View{
            return content
                .foregroundColor(.yellow)
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
                .shadow(color: .black, radius: 5, x: 2, y: 2)
        }
        
    }
    
    @State var isAlertVisible = false
    @State var slidingValue = 50.0
    @State var random = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                HStack{
                    Text("Put your slider close to:")
                    Text("\(random)").modifier(LabelModeifier())
                }
                Spacer()
                HStack{
                    Text("1")
                    Slider(value: $slidingValue, in: 1...100)
                    Text("100")
                }
                Button("Hit me") {
                    self.isAlertVisible = true
                }.alert(isPresented: $isAlertVisible) { () ->
                    Alert in
                    return Alert(title: Text("\(getAlertTitle())"), message: Text("You slided to \(getRoundedValue()). \n" + "You scored \(calculatePoints()) points this round."), dismissButton: .default(Text("Awesome")) {
                        self.score = self.score + calculatePoints()
                        random = Int.random(in: 1...100)
                        round = round + 1
                    })
                }
                Spacer()
                HStack{
                    Button("Start over") {
                        round = 1
                        score = 0
                        slidingValue = 50.0
                        random = Int.random(in: 1...100)
                    }
                    Spacer()
                    Text("Score:")
                    Text("\(score)").modifier(LabelModeifier())
                    Spacer()
                    Text("Round:")
                    Text("\(round)").modifier(LabelModeifier())
                    Spacer()
                    NavigationLink(destination: AboutView()) {
                        Text("Info")
                    }
                }
                .padding(.bottom, 20)
            }.navigationBarTitle("BullsEye")
        }
    }
    
    func getRoundedValue() -> Int{
        return Int(slidingValue.rounded())
    }
    
    func calculatePoints() -> Int{
        let points = 100 - abs(self.random - getRoundedValue())
        if points == 100{
            return points + 100
        }
        else if points == 99{
            return points + 50
        }
        else{
            return points
        }
    }

    func getAlertTitle() -> String{
        let points = calculatePoints()
        if points == 100{
            return "Spot On"
        }
        else if points < 100 && points >= 90 {
            return "almost made it"
        }
        else if points < 90 && points >= 70 {
            return "better luck next time"
        }
        else{
            return "way off"
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
