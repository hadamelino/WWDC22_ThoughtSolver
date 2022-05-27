import Foundation
import CoreML


public func classifyThought(_ inputThought: String) -> String {

    let model = ThoughtsClassifier()
    
    guard let thoughtClassifierOutput =  try? model.prediction(text: inputThought) else {
        fatalError("Could not predict with model")
    }
    
    let sentiment = thoughtClassifierOutput.label
    
    return sentiment
}
