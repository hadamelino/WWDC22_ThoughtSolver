import SwiftUI


struct CongratulationPage: View {
    
    @State var expandControlCard = false
    @State var expandUncontrolCard = false
    @State var hoverStatusControl = false
    @State var hoverStatusUncontrol = false

    @ObservedObject var thought: Thoughts
    
    var body: some View {
        
        VStack {
            Text("Congratulations 🎉")
                .font(.system(size: 50).weight(.bold))
                .foregroundColor(.white)
            
            Text("You have successfully challenged your thoughts and here are the summary!")
                .font(.system(size: 20).weight(.medium))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
            
            HStack (spacing: 20){
                
                ZStack (){
                    
                    if !hoverStatusControl {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .frame(width: 300, height: 300, alignment: .center)
                        .foregroundColor(Color("green1"))
                        .shadow(color: Color(.secondaryLabel), radius: 10, x: 0, y: 15)
                    } else {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .frame(width: 300, height: 300, alignment: .center)
                        .foregroundColor(Color("green11"))
                        .shadow(color: Color(.secondaryLabel), radius: 10, x: 0, y: 15)
                    }

                    
                    if !expandControlCard {
                        Text("Controllable Thoughts")
                            .padding()
                            .font(.system(size: 30).weight(.bold))
                            .frame(width: 300, height: 300, alignment: .center)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .shadow(color: Color(.secondaryLabel), radius: 10, x: 0, y: 10)
                    } else {
                        ZStack (alignment: .top) {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .frame(width: 400, height: 400, alignment: .center)
                            .foregroundColor(Color("green1"))
                            .shadow(color: Color(.secondaryLabel), radius: 10, x: 0, y: 15)
                            
                            TabView {
                                ForEach(thought.controllableList, id: \.self) { thought in
                                    tabViewCard(thought: thought.thought!, solution: thought.solution!)
                                }
                            }
                            .tabViewStyle(.page(indexDisplayMode: .always))
                            .frame(width: 400, height: 400, alignment: .center)
                            .background(Color("green1"))
                            .cornerRadius(20)
                        }
                        .transition(.opacity)

                    }
                }
                .onTapGesture {
                    if !thought.controllableList.isEmpty {
                        expandControlCard.toggle()
                    }
                }
                .onHover { status in
                    hoverStatusControl = status
                }
                
                ZStack {
                    
                    if !hoverStatusUncontrol {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .frame(width: 300, height: 300, alignment: .center)
                        .foregroundColor(Color("orange1"))
                        .shadow(color: Color(.secondaryLabel), radius: 10, x: 0, y: 15)
                    } else {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .frame(width: 300, height: 300, alignment: .center)
                        .foregroundColor(Color("orange11"))
                        .shadow(color: Color(.secondaryLabel), radius: 10, x: 0, y: 15)
                    }
                    
                    if !expandUncontrolCard {
                        Text("Uncontrollable Thoughts")
                            .padding()
                            .font(.system(size: 30).weight(.bold))
                            .frame(width: 300, height: 300, alignment: .center)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        .shadow(color: Color(.secondaryLabel), radius: 10, x: 0, y: 10)
                    } else {
                        ZStack (alignment: .top) {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .frame(width: 400, height: 400, alignment: .center)
                            .foregroundColor(Color("orange1"))
                            .shadow(color: Color(.secondaryLabel), radius: 10, x: 0, y: 15)
                            
                            TabView {
                                ForEach(thought.uncontrollableList, id: \.self) { thought in
                                    tabViewCard(thought: thought.thought!, solution: thought.solution!)

                                }
                            }
                            .tabViewStyle(.page(indexDisplayMode: .always))
                            .frame(width: 400, height: 400, alignment: .center)
                            .background(Color("orange1"))
                            .cornerRadius(20)
                        }
                        .transition(.opacity)
                }
            }
                .onTapGesture {
                if !thought.uncontrollableList.isEmpty {
                    expandUncontrolCard.toggle()
                    }
                }
                .onHover { hover in
                    hoverStatusUncontrol = hover
                }
            }

            
            EmotionBar(thoughts: thought)
                .padding(.top, 30)
            
            Text("\(Int(calculateBarProgress(thought) * 100))%")
                .font(.system(size: 30))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("congrats"), Color("color1")]), startPoint: .top, endPoint: .bottomTrailing)
        )
        .animation(.default)
        .ignoresSafeArea()
        
        
    }


struct tabViewCard: View {
    
    let thought: String
    let solution: String
    
    var body: some View {
        
        VStack (spacing: 20){
            Text("\" \(thought) \"")
                .font(.system(size: 30).weight(.semibold))
            
            Text(solution)
                .font(.system(size: 20).weight(.medium))
                
                
        }
        .shadow(color: Color(.secondaryLabel), radius: 10, x: 0, y: 10)
        .padding()
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
        
        
    }
    }
}

