//
//  MenuView.swift
//  SwiftUIVisionEmojiHunt
//
//  Created by Eric Rudenja on 27.04.2021.
//  Copyright © 2021 iowncode. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    
    var itemsPerRow = 5
    @State var menuBackgroundIsAnimating = false
    @State var showingGame = false
    
    var body: some View {
        if #available(iOS 14.0, *) {
            Color.trackColor.ignoresSafeArea(.all).overlay(
                VStack (spacing: 0){
                
                    ForEach(0..<getNumberOfRows()) {_ in
                        HStack (spacing: 0) {
                            ForEach(0..<self.itemsPerRow) {_ in
                                Image(systemName: getImage())
                                    .resizable()
                                    .scaledToFit()
                                    .padding()
                                    .foregroundColor(Color.outlineColor)
                                    .frame(width: UIScreen.main.bounds.width/CGFloat(self.itemsPerRow),
                                           height: UIScreen.main.bounds.width/CGFloat(self.itemsPerRow))
                                    .opacity(self.menuBackgroundIsAnimating ? 0.05 : 0)
                                    .animation(
                                        Animation
                                            .linear(duration: Double.random(in: 1.0...2.0))
                                            .repeatForever(autoreverses: true)
                                            .delay(Double.random(in: 1...8.5))
                                            
                                    )
                                                    
                                                    
                    
                    
                                    
                                
                            }
                        }
                    }
                
                    
                }.onAppear(){
                    self.menuBackgroundIsAnimating = true
                }
            ).overlay(Button(action: {
                self.showingGame.toggle()
            }){
                
                Circle()
                    .fill(Color.backgroundColor)
                    .frame(width: 181.75, height: 181.75)
                    .overlay(
                        Circle()
//                            .stroke(style: StrokeStyle(lineWidth: 10))
                            .fill(AngularGradient(gradient: .init(colors: [Color.backgroundColor]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/))
                            .shadow(color: Color.outlineColor, radius: 15)
//                            .overlay(Text("Play!").fontWeight(.heavy).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.outlineColor))
                        
                            .overlay(
                                Image(systemName: "play").resizable()
                                                        .frame(width: 65, height: 65)
                                    .padding(.leading, 10)
//                                                        .aspectRatio(contentMode: .fit)
                                                        .font(.title).foregroundColor(.outlineColor)
                                //                                            .foregroundColor(.white)
                                )
                        
                    )
        }.animation(
            Animation
                .linear(duration: Double.random(in: 1.0...2.0))
                .repeatForever(autoreverses: true)
                .delay(2)
        ).fullScreenCover(isPresented: $showingGame) {
                ContentView()
            }
            
        )
        } else {
            // Fallback on earlier versions
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        
    }
    
    func getImage() -> String {
        let systemNames = ["house", "sun.max", "pencil", "paperplane.fill", "calendar",
                            "book", "text.book.closed", "graduationcap.fill", "paperclip",
                            "umbrella.fill", "megaphone.fill", "magnifyingglass", "bell.fill", "flashlight.on.fill",
                            "camera.fill", "scissors", "die.face.5.fill", "paintbrush.pointed.fill", "bandage.fill",
                            "wrench.fill", "hammer.fill", "printer.fill", "cross.case.fill", "lock.fill",
                            "key.fill", "pin.fill", "radio.fill", "comb.fill", "alarm.fill", "gamecontroller.fill",
                            "hourglass.tophalf.fill"]
        return systemNames.randomElement() ?? "house"
    }
    
    func getNumberOfRows() -> Int {
        let heightPerItem = UIScreen.main.bounds.width/CGFloat(self.itemsPerRow)
        return Int(UIScreen.main.bounds.height/heightPerItem) + 1
    }
    
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

