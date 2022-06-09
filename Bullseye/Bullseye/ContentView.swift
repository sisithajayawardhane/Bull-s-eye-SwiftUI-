//
//  ContentView.swift
//  Bullseye
//
//  Created by sisitha jayawardhane on 5/8/20.
//  Copyright © 2020 Sisitha Jayawardhane. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 0...100)
    @State var score = 0
    @State var round = 1

    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View{
            return content
                .foregroundColor(Color.yellow)
                .shadow(color: Color.black, radius: 5, x: 5, y: 5)
                .font(Font.custom("Arial", size: 25))
        }
    }
    
var body: some View {
    VStack {
        Image("ab").fixedSize()
        Spacer()
        //Target row
        HStack {
            Text("Pull the bullseye as close as you can to: ").foregroundColor(Color.green)
            Text(" \(target )")
                .modifier(ValueStyle())
        }
        Spacer()
        //Slider row
        HStack{
            Text("0")
            .modifier(ValueStyle())
            Slider(value: self.$sliderValue, in:  0...100).accentColor(Color.green)
            Text("100")
            .modifier(ValueStyle())
        }
        Spacer()
        Button(action: {
            print("Button Pressed!")
            self.alertIsVisible =  true
        }) {
            Text(/*@START_MENU_TOKEN@*/"Hit me!"/*@END_MENU_TOKEN@*/).foregroundColor(Color.red)
            
                
        }
        
        .alert(isPresented: $alertIsVisible){
            () -> Alert in
            return Alert(title: Text("\(addTitle())"), message: Text("The Slider's value is \(sliderValueRounded())\n" +
                "You Scored \(pointsForThisRound()) points this round"), dismissButton: .default(Text("Awesome!")){
                    self.score += self.pointsForThisRound()
                    self.target = Int.random(in: 0...100)
                    self.round += 1
                })
            }.background(Image("gr"))
        Spacer()
        //Score row
        HStack{
            Button(action: {
                self.startOver()
            }) {
                Text("Start over").foregroundColor(Color.red)
                
            }.background(Image("gr"))
            Spacer()
            Text("Score:").foregroundColor(Color.green)
            Text("\(score)")
            .modifier(ValueStyle())
            Spacer()
            Text("Round:").foregroundColor(Color.green)
            Text("\(round)")
            .modifier(ValueStyle())
            Spacer()
            NavigationLink(destination: AboutView()) {
                Text("Info").foregroundColor(Color.red)
                }.background(Image("gr")).navigationBarTitle("Bullseye")
        }
        .padding(.bottom, 20)
        
    }
    .background(Image("r"), alignment: .center)

}
    func sliderValueRounded()->Int{
        Int(sliderValue.rounded())
    }
    func pointsForThisRound()-> Int{
        let maximumScore = 100
        let bonus:Int
        let difference = amountOff()
        if difference == 0{
            bonus = 100
        }
        else if difference == 1{
            bonus = 50
        }
        else{
            bonus = 0
        }
        return maximumScore - difference + bonus
    }
    func amountOff()-> Int{
        abs(target - sliderValueRounded())
    }
    func addTitle()-> String{
        let difference = amountOff()
        let title:String
        if difference == 0{
            title = "Perfect!"
        }
        else if difference < 5{
            title = "You almost had it"
        }
        else if difference <= 10{
            title = "Not bad"
        }
        else{
            title = "Are you even trying"
        }
        return title
    }
    func startOver(){
        round = 1
        score = 0
        sliderValue = 50.0
        target = Int.random(in: 0...100)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
