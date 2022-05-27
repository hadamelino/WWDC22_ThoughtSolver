import SwiftUI

struct SummaryPage: View {
    
    @EnvironmentObject var state: AppState
    @EnvironmentObject var thoughts: Thoughts

    @State var temptData = ThoughtData()
    @State var completeProgress = false
    
    
    var body: some View {

        NavigationView {
            ZStack {
                VStack (alignment: .center, spacing: 10) {
        
                Text("The below bar indicates your thought score! 🥳")
                    .font(.system(size: 40).weight(.bold))
                    .frame(width: UIScreen.main.bounds.width / 1.5, alignment: .center)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.bottom)
                
                Text("It is calculated based on how many positive thoughts compared to the negative thoughts that our model predicted. Don't worry, I am here to help you increase your thought score. We will dig into the details of your negative thoughts by first categorizing them into controllable and uncontrollable thought and then write your solutions or strategies to cope with them. With that, you can divide which thoughts are possible to have solutions and not.")
                    .font(.body)
                    .frame(width: UIScreen.main.bounds.width / 1.5, alignment: .center)
                    .foregroundColor(.white)
                
                    HStack {
                        Text("\(Int(calculateBarProgress(thoughts) * 100))%")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                        
                        EmotionBar(thoughts: thoughts)
                    }
                
                VStack (spacing:0){
                    Text("Drag and drop your thought to categorize it!")
                        .font(.body)
                    .foregroundColor(.white)
                            
                    DroppableList("", thoughts: $thoughts.negativeThoughts, needNavLink: false, tableID: 0) { dropped, index in
                        temptData.thought = dropped
                        temptData.sentiment = classifyThought(dropped)
                        thoughts.negativeThoughts.insert(temptData, at: index)
                        thoughts.controllableList.removeAll {$0.thought == dropped}
                        thoughts.uncontrollableList.removeAll {$0.thought == dropped}
                    }
                    
                } //: VStack
                .padding(.top)
                
                    Text("Challenge your thoughts!")
                        .foregroundColor(.white)
                        .padding(.top)
                    Text("Tap each thought and write your solution to increase your thought score")
                        .foregroundColor(.white)

                HStack (alignment: .center, spacing: 20) {
                    VStack {
                        Text("Controllable 💡")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        ZStack {
                            if $thoughts.controllableList.isEmpty {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(.white)
                                    .shadow(color: Color(.secondaryLabel), radius: 12, x: 0, y: 10)
                            }
                            
                            DroppableList("", thoughts: $thoughts.controllableList, needNavLink: true, tableID: 1) { dropped, index in
                                temptData.thought = dropped
                                temptData.sentiment = classifyThought(dropped)
                                thoughts.controllableList.insert(temptData, at: index)
                                thoughts.negativeThoughts.removeAll {$0.thought == dropped}
                                thoughts.uncontrollableList.removeAll {$0.thought == dropped}
                            }
                            
                        } //: ZStack

                    }
                    
                    VStack {
                        Text("Uncontrollable ⌛️")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        ZStack {
                            
                            if $thoughts.uncontrollableList.isEmpty {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(.white)
                                    .shadow(color: Color(.secondaryLabel), radius: 12, x: 0, y: 10)
                            }
                            
                            DroppableList("", thoughts: $thoughts.uncontrollableList, needNavLink: true, tableID: 2) { dropped, index in
                                temptData.thought = dropped
                                temptData.sentiment = classifyThought(dropped)
                                thoughts.uncontrollableList.insert(temptData, at: index)
                                thoughts.controllableList.removeAll {$0.thought == dropped}
                                thoughts.negativeThoughts.removeAll {$0.thought == dropped}
                            }
                        } //: ZStack
                        
                }
            } //: HStack
                .padding()
                }
                .background(Color("mainColor"))
                
                if completeProgress {
                    CongratulationPage(thought: thoughts)
                        .transition(.opacity)

                }
                
            }
            .onAppear {
                if CGFloat(thoughts.totalPoints) / CGFloat(thoughts.thoughtsData.count) == 1.0 {
                    print("here")
                    completeProgress = true
                }
                print("ZStack Appear")
            }
    
        } //: Navigation View
        .navigationViewStyle(.stack)
        .onAppear {
            UINavigationBar.appearance().tintColor = .white
        }

    }

}


struct DroppableList: View {
    
    let title: String
    @Binding public var thoughtsList: [ThoughtData]
    @State private var dragOver = false
    @State private var needNavLink: Bool
    @State private var tableID: Int
    @EnvironmentObject var thoughts: Thoughts

    
    let action: ((String, Int) -> Void)?
    
    
    
    init(_ title: String, thoughts: Binding<[ThoughtData]>, needNavLink: Bool, tableID: Int, action: ((String, Int) -> Void)? = nil) {
        self.title = title
        self._thoughtsList = thoughts
        self.action = action
        self.needNavLink = needNavLink
        self.tableID = tableID
    }
    
    var body: some View {
        
        if needNavLink {
        List {
            ForEach(thoughtsList, id: \.self) {thought in
                if tableID == 1 {
                    NavigationLink {
                        SolutionPage(data: self.$thoughtsList[self.thoughtsList.firstIndex(of: thought)!], subTitleText: "Think about the possible actions or solutions to control it")
                    } label: {
                        ThoughtRow(thought: thought)
                    }
                    .onDrag {
                            NSItemProvider(object: thought.thought! as NSString)
                        }
                } else {
                    NavigationLink {
                        SolutionPage(data: self.$thoughtsList[self.thoughtsList.firstIndex(of: thought)!], subTitleText: "Think about the strategies you can use to cope with it")
                    } label: {
                        ThoughtRow(thought: thought)
                    }
                    .onDrag {
                            NSItemProvider(object: thought.thought! as NSString)
                        }
                    .onAppear {
                        
                    }
                }
                
                }
            .onMove(perform: moveThought)
            .onInsert(of: [.text], perform: dropThought)

        }
        .shadow(color: Color(.secondaryLabel), radius: 12, x: 0, y: 10)
        .onAppear {
            UITableView.appearance().backgroundColor = .clear

        }
        .padding()
        .overlay(helperOverlay())
            
        } else {
            List {
                ForEach(thoughtsList, id: \.self) {thought in
                    
                        ThoughtRow(thought: thought)
                            .onDrag {
                                NSItemProvider(object: thought.thought! as NSString)
                            }
                    
            
                }
                .onMove(perform: moveThought)
                .onInsert(of: [.text], perform: dropThought)

            }
            .shadow(color: Color(.secondaryLabel), radius: 12, x: 0, y: 10)
            .onAppear {
                UITableView.appearance().backgroundColor = .clear
            }
            .padding()

            .overlay(helperOverlay())
        }
        
        
    }
    

    private func helperOverlay() -> some View {
        Group {
            if thoughtsList.isEmpty {
                Color.white.opacity(0.0001)  // << should be something opaque
                    .onDrop(of: [.text], isTargeted: nil, perform: dropOnEmptyList)
            }
        }
    }
    
    func dropOnEmptyList(_ items: [NSItemProvider]) -> Bool {
        dropThought(at: thoughtsList.endIndex, items)
        return true
    }
    
    func moveThought(from source: IndexSet, to destination: Int){
        print(source)
        print(destination)
        thoughtsList.move(fromOffsets: source, toOffset: destination)
    }
    
    func dropThought(at index: Int, _ items: [NSItemProvider]){
        print(items)
        print(index)
        for item in items {
            _ = item.loadObject(ofClass: String.self, completionHandler: { droppedData, _ in
                if let ss = droppedData, let dropAction = action {
                    DispatchQueue.main.async {
                        dropAction(ss, index)
                    }
                }
            })
        }
        
    }
}

