import SwiftUI

struct SolutionPage: View {
    
    @Binding var data: ThoughtData
    @State var solutions: String = ""
    @State var sentiment: String = ""
    @State var textEditorColor: Color = .primary
    @State var textEditorTapped: Bool = false
    @State private var onButton = false
    let subTitleText: String
    
    @EnvironmentObject var thoughts: Thoughts

    
    var body: some View {
    
        VStack (spacing: 10){
            Text(data.thought!)
                .font(.system(size: 40).weight(.semibold))
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width * 0.75)
                .multilineTextAlignment(.center)
                .padding()
            
            VStack {
                Text(subTitleText)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                ZStack {
                    TextEditor(text: $solutions)
                        .frame(width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.height / 8, alignment: .center)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .stroke(.black, lineWidth: 0.5)
                        )
                        .shadow(color: Color(.secondaryLabel), radius: 5, x: 0, y: 5)
                        .onTapGesture {
                            textEditorTapped = true
                        }
                        
                    
                    if !textEditorTapped {
                        Text("Write down your solutions here!")
                            .font(.body)
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
            }
            .padding()
                        
            Button("Done") {
                if !solutions.isEmpty {
                    if data.solution == nil {
                        thoughts.totalPoints += 1
                    }
                    data.solution = solutions
                }
            }
            .onHover(perform: { hover in
                onButton = hover
            })
            .buttonStyle(.plain)
            .padding()
            .foregroundColor(onButton ? .black: .white)
            .background(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(onButton ? .white: Color("customDark"))
                    .frame(width: 100, height: 50, alignment: .center)
                    .shadow(color: Color(.secondaryLabel), radius: 5, x: 0, y: 5))
            .font(
                .system(size: 16)
                .weight(.medium))

            
            
        } //: VStack
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("mainColor"))
        .ignoresSafeArea()
        .navigationBarTitleDisplayMode(.inline)
    }
}


