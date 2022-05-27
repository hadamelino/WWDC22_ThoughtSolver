import SwiftUI

class Thoughts: ObservableObject {
    
    @Published var thoughtsData = [ThoughtData]()
    @Published var negativeThoughts = [ThoughtData]()
    @Published var controllableList = [ThoughtData]()
    @Published var uncontrollableList = [ThoughtData]()
    @Published var totalPoints = 0
    
    init(){
        
        var tempData: ThoughtData = ThoughtData()
        
        tempData.thought = "I am very excited to introduce my app about how to manage our overthinking that will prevent it to become worst by journaling the thoughts. Below are the sample thoughts that we will dig deeper into."
        tempData.id = 0
        tempData.sentiment = classifyThought(tempData.thought!)
        updatePoint(tempData)
        self.thoughtsData.append(tempData)
        
        tempData.thought = "I am feeling rather overwhelmed with all that is on my to do list"
        tempData.id = 1
        tempData.sentiment = classifyThought(tempData.thought!)
        updatePoint(tempData)
        self.thoughtsData.append(tempData)

        tempData.thought = "I could say I was feeling fear or anxiety or that I am terrified of what the future may bring"
        tempData.id = 2
        tempData.sentiment = classifyThought(tempData.thought!)
        updatePoint(tempData)
        self.thoughtsData.append(tempData)
        
        tempData.thought = "I begin to feel uncomfortable internally feeling nauseous light headed and experienced shortness of breath"
        tempData.id = 3
        tempData.sentiment = classifyThought(tempData.thought!)
        updatePoint(tempData)
        self.thoughtsData.append(tempData)
    
        
        getNegativeData()
        updatePoint(tempData)
    }


    func updatePoint(_ data: ThoughtData) {
        if data.sentiment == "positive" {
            self.totalPoints += 1
        }
    }
    
    func getNegativeData() {
        
        for thought in thoughtsData {
            if thought.sentiment == "negative" {
                negativeThoughts.append(thought)
            }
        }
    }
    
}

