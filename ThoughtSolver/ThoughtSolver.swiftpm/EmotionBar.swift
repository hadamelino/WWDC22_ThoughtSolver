import SwiftUI

struct EmotionBar: View {
    
    @ObservedObject var thoughts: Thoughts
    @State var barWidth: CGFloat = UIScreen.main.bounds.width / 4
        
    var body: some View {
        
        ZStack(alignment: .leading) {

            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .shadow(color: .black, radius: 8, x: 4, y: 10)
                .frame(width: barWidth, height: 30, alignment: .leading)
                .foregroundColor(Color.black.opacity(0.4))
                

            
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .frame(width: barWidth * calculateBarProgress(thoughts), height: 30, alignment: .leading)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color("green3"), Color("yellow1")]), startPoint: .leading, endPoint: .trailing)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                )
                .foregroundColor(.clear)
        } //: ZStack
    }
    
}

func calculateBarProgress(_ thoughts: Thoughts) -> CGFloat {
    return CGFloat(thoughts.totalPoints) / CGFloat(thoughts.thoughtsData.count)
}



