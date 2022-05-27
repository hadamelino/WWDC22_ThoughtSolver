import SwiftUI

struct ThoughtRow: View {
    
    var thought: ThoughtData
    
    var body: some View {
        
        HStack(spacing: 10){
            
            Text(getEmoji(thought))
                .font(.system(size: 30))
                .padding()
            
            Text(thought.thought!)
                .font(.system(size: 18))
                .padding()
            
            if thought.solution != nil {
                Text("✅")
                    .font(.system(size: 30))
                    .padding()
            }
            
        }
        
    }
}

func getEmoji(_ data: ThoughtData) -> String {
    
    if data.sentiment == "positive" {
        return "😃"
    } else if data.sentiment == "negative" {
        return "🙁"
    } else {
        return "🤔"
    }
}
