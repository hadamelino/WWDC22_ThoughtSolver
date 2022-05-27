import SwiftUI

struct InstructionPage: View {
    
    @EnvironmentObject var state: AppState
    @State var backgroundColor: Color = Color("mainColor")
    @State var buttonHover = false

    
    var body: some View {
        ZStack {
            TabView {
                Text("Negative thoughts have been detected 😔\nbut that's okay because I am here to help ☺️")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: UIScreen.main.bounds.width / 2)
                    .padding()
                
                Text("Before we continue there are something you need to know 😊")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: UIScreen.main.bounds.width / 2)
                    .padding()

                
                Text("Dwelling on your problems isn’t helpful—but looking for solutions is 🛠")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: UIScreen.main.bounds.width / 2)
                    .padding()
                   
                
                Text("If it’s something you have some control over, consider how you can prevent the problem, or challenge yourself to identify the potential solutions 📋")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: UIScreen.main.bounds.width / 2)
                    .padding()
                
                Text("If it’s something you have no control over—like a natural disaster—think about the strategies you can use to cope with it 📋")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: UIScreen.main.bounds.width / 2)
                    .padding()
                
                VStack {
                    Text("Focus on the things you can control, like your attitude and effort 🤩")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .frame(width: UIScreen.main.bounds.width / 2)
                        .padding()
                    
                    
                    ZStack {
                        Button("Let's start!") {
                            withAnimation {
                                state.showSummary.toggle()
                            }
        
                        }
                        .padding()
                        .font(.system(size: 20).weight(.semibold))
                        .buttonStyle(.plain)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(10)
                        .onHover { hover in
                            buttonHover = hover
                        }
                        
                        if buttonHover {
                            Button("Let's start!") {
                                withAnimation {
                                    state.showSummary.toggle()
                                }
            
                            }
                            .padding()
                            .font(.system(size: 20).weight(.semibold))
                            .buttonStyle(.plain)
                            .foregroundColor(.black)
                            .background(.white)
                            .cornerRadius(10)
                            .onHover { hover in
                                buttonHover = hover
                            }
                    }
                    
                    
                    }
                    
                } //: VStack

            } //: TabView
            .tabViewStyle(.page(indexDisplayMode: .always))
            .background(backgroundColor)
            .transition(.opacity)
            
            if state.showSummary {
                SummaryPage()
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 2.0), value: state.showSummary)
            }
            
        } //: ZStack

    }

}
