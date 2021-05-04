

import SwiftUI


struct ContentView: View {
    
    @State var timeRemaining = 30
    @State var currentScore = 1
//    @State var highScore = 0
    @State var showingDetail = false

    
    //tutorial circle
    @State var percentage: CGFloat = 0
    //tutorial circle
    
    @State var timer = Timer.publish (every: 1, on: .main, in: .common).autoconnect()
    
    @State var emojiStatus = EmojiSearch.searching
    
    var emojiObjects = [EmojiModel(emoji: "💻", emojiName: "laptop"),
                        EmojiModel(emoji: "😽", emojiName: "cat"),
                        EmojiModel(emoji: "🧹", emojiName: "vacuum"),
                        EmojiModel(emoji: "📚", emojiName: "book"),
                        EmojiModel(emoji: "✍️", emojiName: "pen"),
//                        EmojiModel(emoji: "", emojiName: ""),
                        
                        
    ]
//    .shuffled()
        
    @State var currentLevel = 0
    @State var showNext = false
    
    var body: some View {
        
        ZStack {
            
            let defaults = UserDefaults.standard
        
            let highScore = defaults.integer(forKey: "highScore")
            
            
            if showNext || emojiStatus == .found || emojiStatus == .notFound {
//                notFoundd()
//                nextButton()
//                Button(action: {
//
//                    if self.currentLevel == self.emojiObjects.count - 1{
//
//
//
//                        self.emojiStatus = .gameOver
//
//                        // Display current score
//                        Text("Current score: \(currentScore)")
//                            .padding()
//                            .background(Color.pulsatingColor)
//                            .foregroundColor(Color.white)
//                            .cornerRadius(6)
//
//
//                    }
//
//
//                    else{
//
//                        if emojiStatus == .found {
//                            currentScore += 1
//
//                        }
//
//                        self.currentLevel = self.currentLevel + 1
//                        self.timeRemaining = 30
//                        self.emojiStatus = .searching
//                        self.showNext = false
//                        self.instantiateTimer()
//
//                        // If currentScore is large than highScore, set highScore into userDefaults
//                        if currentScore > highScore {
//
//                            defaults.set(self.currentScore, forKey: "highScore")
//
//                        }
//                        notFoundd()
//                    }
//
//                }) {
//                    Text("NEXT")
//                        .padding()
//                        .background(Color.pulsatingColor)
//                        .foregroundColor(Color.white)
//                        .cornerRadius(6)
//                }
                
            }
            if emojiStatus == .notFound {
                
                foundNotFound(colors: Color.notFoundColor, foundNotFoundIcon: "xmark",
                              currentScore: currentScore)
                    nextButton()
                
            } else if emojiStatus == .found {
                foundNotFound(colors: Color.outlineColor, foundNotFoundIcon: "checkmark",
                              currentScore: currentScore + 1, emojiStatusFound: true)
                nextButton()
            }
            
            else{
//                CustomCameraRepresentable(emojiString: emojiObjects[currentLevel].emojiName, emojiFound: $emojiStatus).edgesIgnoringSafeArea(.all)
//

            CustomCameraRepresentable(emojiString: emojiObjects[currentLevel].emojiName, emojiFound: $emojiStatus).edgesIgnoringSafeArea(.all)
    
            }

            VStack(alignment: .center, spacing: 16){
                Spacer()
                // tutorial
                
                if self.emojiStatus == .gameOver{
                    
                    Button(action: {
                        self.currentLevel = 0
                        self.timeRemaining = 30
                        self.emojiStatus = .searching
                        self.showNext = false
                        self.instantiateTimer()
                        self.currentScore = 0
                        self.showingDetail.toggle()
                        
                    }) {
                        Text("Play again!")
                            .padding()
                            .background(Color.pulsatingColor)
                            .foregroundColor(Color.white)
                            .cornerRadius(3)
                    }
                    
                    if currentScore < highScore {
                        Text("Current score: \(currentScore)")
                            .padding()
                            .background(Color.pulsatingColor)
                            .foregroundColor(Color.white)
                            .cornerRadius(6)
                        Text("High score: \(highScore)")
                            .padding()
                            .background(Color.pulsatingColor)
                            .foregroundColor(Color.white)
                            .cornerRadius(6)
                    }
                    
                    if currentScore > highScore {
                        Text("New high score: \(highScore)")
                            .padding()
                            .background(Color.pulsatingColor)
                            .foregroundColor(Color.white)
                            .cornerRadius(6)
                    }
                    
                }

                else{
                    if self.emojiStatus == .searching{
                        
//                         tutorial circle
//                        ZStack {
                //            Color.backgroundColor
                            VStack {
                                ZStack {
                                    Pulsation()
                                    Track()
                                    Label(percentage: CGFloat(timeRemaining))
                                    Outline(percentage: percentage)
                                    
                                }
                                Spacer()
                                
                                
//                                HStack {
//                                    Button(action: {
////                                        self.percentage = CGFloat(100 - ((Double(30) - Double(timeRemaining)) / Double(30)) * 100)
//                                        print(100 - ((Double(30) - Double(timeRemaining)) / Double(30)) * 100)
//                                    }) {
//                                        Image(systemName: "play.circle.fill").resizable()
//                                            .frame(width: 65, height: 65)
//                                            .aspectRatio(contentMode: .fit)
//                                            .foregroundColor(.white)
//                                    }
//                                }
//                            }
                        }
//                         tutorial circle end

                        
                        .onReceive(timer) { _ in
                                
                                if self.emojiStatus == .found{
                                    self.cancelTimer()
                                    self.timeRemaining = 30
                                }
                                else {
                                    if self.timeRemaining > 0 {
                                        self.timeRemaining -= 1
                                        percentage = CGFloat(100 - ((Double(30) - Double(timeRemaining)) / Double(30)) * 100)
                                    }
                                    else{
                                        self.emojiStatus = .notFound
                                        self.showNext = true
                                    }
                                }
                        }
                    } else {
//                        Outline()
                        
                    }
                    
                    // A button that skips the current object and goes to the next one
                    // Shown only when a user is searching
                    HStack {
                        if self.emojiStatus == .searching {
                            Button(action: {
                                self.emojiStatus = .notFound
                            }) {
                                Image(systemName: "xmark.circle").resizable()
                                    .frame(width: 65, height: 65)
                                    .aspectRatio(contentMode: .fit)
    //                                .padding()
                                    .background(Color.pulsatingColor)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(100)
                            }.padding(.leading)
                            
                        }
                        Spacer()
                        HStack{
                            if #available(iOS 14.0, *) {
                                Menu {
                                    
                                    Button(action: {
                                        
                                    }) {
                                        Text("\(emojiObjects[currentLevel].emojiName)")
                                    }
                                }label: {
                                    emojiResultText()
                                }
                                
                            } else {
                                // Fallback on earlier versions
                            }
                        }
                    }.padding(.trailing)
                    

                    
                }
            }
        }

    }
    
    func emojiResultText() -> Text {
       switch emojiStatus {
       case .found:
            
            return Text("\(emojiObjects[currentLevel].emoji)")
                .font(.system(size:50, design: .rounded))
                .fontWeight(.bold)
       case .notFound:
            return Text("\(emojiObjects[currentLevel].emoji)")
            .font(.system(size:50, design: .rounded))
                .foregroundColor(Color.notFoundColor)
       default:
            return Text(emojiObjects[currentLevel].emoji)
            .font(.system(size:50, design: .rounded))
            .fontWeight(.bold)
        
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func instantiateTimer() {
        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    func cancelTimer() {
        self.timer.upstream.connect().cancel()
    }
    

    
    func nextButton() -> some View {
        
        Button(action: {
            if emojiStatus == .found {
                
                self.currentScore += 1
                print("hhhh")
                
            }
            if self.currentLevel == self.emojiObjects.count - 1{
                
            
                
                self.emojiStatus = .gameOver
            
                // Display current score
                Text("Current score: \(currentScore)")
                    .padding()
                    .background(Color.pulsatingColor)
                    .foregroundColor(Color.white)
                    .cornerRadius(6)
                
                
            }
        
            
            else{
                
//                if emojiStatus == .found {
//
//                    self.currentScore += 1
//                    print("hhhh")
//
//                }
                
                self.currentLevel = self.currentLevel + 1
                self.timeRemaining = 30
                self.emojiStatus = .searching
                self.showNext = false
                self.instantiateTimer()
                
//                // If currentScore is large than highScore, set highScore into userDefaults
//                if currentScore > highScore {
//
//                    defaults.set(self.currentScore, forKey: "highScore")
//
//                }
                
            }
            
        }) {
            Text("NEXT")
                .padding()
                .background(Color.pulsatingColor)
                .foregroundColor(Color.white)
                .cornerRadius(6)
        }
        
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// tutorial circle
struct Label: View {
    var percentage: CGFloat = 0
    var body: some View {
        ZStack {
            Text(String(format: "%.0f", percentage)).font(.system(size: 32)).fontWeight(.heavy).colorInvert()
        }
    }
}

struct Outline: View {
    var percentage: CGFloat = 0
    var colors: [Color] = [Color.outlineColor]
    var body: some View {
        ZStack  {
            Circle()
                .fill(Color.clear)
                .frame(width: 93.75, height: 93.75)
                .overlay(
                    Circle()
                        .trim(from: 0, to: percentage * 0.01)
                        .stroke(style: StrokeStyle(lineWidth: 7.5, lineCap: .round, lineJoin: .round))
                        .fill(AngularGradient(gradient: .init(colors: colors), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, startAngle: .zero, endAngle: .init(degrees: 360)))
                ).animation(.spring(response: 0.5, dampingFraction: 1, blendDuration: 1))
            

        }
    }
}

struct Track: View {
    var colors: [Color] = [Color.trackColor]
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.backgroundColor)
                .frame(width: 81.75, height: 81.75)
                .overlay(
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 20))
                        .fill(AngularGradient(gradient: .init(colors: colors), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/))
                )
        }
    }
}

struct Pulsation: View {
    @State private var pulsate = false
    var colors: [Color] = [Color.pulsatingColor]
    var body: some View {
        ZStack  {
            Circle()
                .fill(Color.pulsatingColor)
                .frame(width: 91.875, height: 91.875)
                .scaleEffect(pulsate ? 1.3 : 1.1)
                .animation(Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true))
                .onAppear {
                    self.pulsate.toggle()
                }
        }
    }
}

struct foundStar: View {
    var body: some View {
        Image(systemName: "star")
            .resizable()
            .scaledToFit()
            .padding()
            .foregroundColor(.yellow)
            .frame(width: UIScreen.main.bounds.width/CGFloat(6),
                   height: UIScreen.main.bounds.width/CGFloat(6))
            
    }
}


struct foundNotFound: View {
    @State var foundNotFoundBackgroundIsAnimating = false
    var colors: Color = Color.notFoundColor
    var foundNotFoundIcon: String = "xmark"
    var currentScore: Int = 0
    var emojiStatusFound: Bool = false
    @State private var starIsVisible = false
    
    var body: some View {
        if #available(iOS 14.0, *) {
            Color.trackColor.ignoresSafeArea(.all).overlay(
                VStack (spacing: 0){
                    
                    ForEach(0..<getNumberOfRows()) {_ in
                        HStack (spacing: 0) {
                            ForEach(0..<4) {_ in
                                Image(systemName:foundNotFoundIcon)
                                    .resizable()
                                    .scaledToFit()
                                    .padding(10)
                                    .foregroundColor(colors)
                                    .frame(width: UIScreen.main.bounds.width/CGFloat(2.5),
                                           height: UIScreen.main.bounds.width/CGFloat(2.5))
                                    .opacity(self.foundNotFoundBackgroundIsAnimating ? 0.15 : 0.015)
                                    .animation(
                                        Animation
                                            .linear(duration: Double.random(in: 1.0...2.0))
                                            .repeatForever(autoreverses: true)
                                            .delay(Double.random(in: 0.2...8.5))
                            
                                    )
                            }
                        }
                    }
                    
                    
                }.onAppear(){
                    self.foundNotFoundBackgroundIsAnimating = true
                    
                }).overlay(
                    
                    VStack {
                        
                        Spacer()
                        HStack {
                            ForEach(0..<currentScore) {i in
                                
                                if emojiStatusFound == true && i == self.currentScore-1 {
                                    
                                    
                                        foundStar()
                                        .opacity(starIsVisible ? 1 : 0)
                                        .scaleEffect(starIsVisible ? 1 : 3)
                                        .onAppear {
                                            withAnimation(.spring(response: 0.5, dampingFraction: 0.15, blendDuration: 0.3).delay(0.3)) {
                                                self.starIsVisible.toggle()
                                            }
                                        }
                                }
                                
                                else {
                                    foundStar()
                                }
                            }
                        }
                        if self.currentScore > 4 {
                            HStack {
                                ForEach(4..<currentScore) {i in
                                    if emojiStatusFound == true && i == self.currentScore-1 {
                                        foundStar()
                                            .opacity(starIsVisible ? 1 : 0)
                                            .scaleEffect(starIsVisible ? 1 : 3)
                                            .onAppear {
                                                withAnimation(.spring(response: 0.5, dampingFraction: 0.15, blendDuration: 0.3).delay(0.3)) {
                                                    self.starIsVisible.toggle()
                                                }
                                            }
                                    }

                                    else {
                                        foundStar()
                                    }
                                }
                            }
                        }
                        
                    }.padding(.trailing)
                )
//
            } else {
                // Fallback on earlier versions
            }
    }

}



func getNumberOfRows() -> Int {
    let heightPerItem = UIScreen.main.bounds.width/CGFloat(5)
    return Int(UIScreen.main.bounds.height/heightPerItem) + 4
}

func getNumberOfRowsStars() -> Int {
    let heightPerItem = UIScreen.main.bounds.width/CGFloat(5)
    return Int(UIScreen.main.bounds.height/heightPerItem) + 4
}



//maybe not
// tutorial circle

struct CustomCameraRepresentable: UIViewControllerRepresentable {
    
    var emojiString: String
    @Binding var emojiFound: EmojiSearch
    
    func makeUIViewController(context: Context) -> CameraVC {
        let controller = CameraVC(emoji: emojiString)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ cameraViewController: CameraVC, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(emojiFound: $emojiFound)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, EmojiFoundDelegate {
        
        @Binding var emojiFound: EmojiSearch
        
        init(emojiFound: Binding<EmojiSearch>) {
            _emojiFound = emojiFound
        }
        
        func emojiWasFound(result: Bool) {
            print("emojiWasFound \(result)")
            emojiFound = .found
        }
        
    }
}

protocol EmojiFoundDelegate{
    func emojiWasFound(result: Bool)
}

enum EmojiSearch{
    case found
    case notFound
    case searching
    case gameOver
}


struct EmojiModel{
    var emoji: String
    var emojiName: String
}
