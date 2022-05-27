//
//  File.swift
//  WWDC
//
//  Created by Hada Melino Muhammad on 18/04/22.
//

import SwiftUI

struct Home: View {
    
    @State private var inputThought: String = ""
    @State private var emotionScore: Int = 0
    @State private var sentiment: String = ""
    @State private var tempData = ThoughtData()
    
    @EnvironmentObject var thoughts: Thoughts
    @EnvironmentObject var state: AppState

    var body: some View {
                        
        ZStack {
            VStack {
                Text("What are you thinking right now? 🤔")
                    .font(.system(size: 60).weight(.medium))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.white)
                    .padding()
                            
                List {
                    ForEach(thoughts.thoughtsData, id: \.self) {
                        thoughtElement in
                        ThoughtRow(thought: thoughtElement)
                    }
                }
                .onAppear(perform: {
                    UITableView.appearance().backgroundColor = .clear
                })
                .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 2, alignment: .center)
                .cornerRadius(16)
                .shadow(color: Color(.secondaryLabel), radius: 12, x: 0, y: 10)
                .padding()
                
                ZStack(alignment:.leading) {
                    TextEditor(text: $inputThought)
                        .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 20, alignment: .center)
                        .cornerRadius(16)
                        .shadow(color: Color(.secondaryLabel), radius: 12, x: 0, y: 5)
                    
                    if inputThought.isEmpty {
                        Text("Share your thought here!")
                            .font(.body)
                            .foregroundColor(.gray)
                            .padding(.leading)
                    }
                }
                .padding([.leading, .trailing], 8)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.black, lineWidth: 0)
                )
                
                HStack(alignment: .center, spacing: 200) {
                    Button("📝 Add") {
                        if !inputThought.isEmpty {
                            
                            sentiment = classifyThought(inputThought)
                            
                            tempData = ThoughtData(id: thoughts.thoughtsData.count, sentiment: sentiment, thought: inputThought)
                            thoughts.updatePoint(tempData)

                            thoughts.thoughtsData.append(tempData)
                            if sentiment == "negative" {
                                thoughts.negativeThoughts.append(tempData)
                            }
                            inputThought = ""
                            
                            print(thoughts.totalPoints)
                            print(emotionScore)
                        }
                    }
                    .buttonStyle(.plain)
                    .padding()
                    .foregroundColor(.white)
                    .background(RoundedRectangle(cornerRadius: 15)
                        .fill(Color("customDark"))
                        .frame(width: 100, height: 50, alignment: .center)
                        .shadow(color: Color(.secondaryLabel), radius: 5, x: 0, y: 5))
                    .font(
                        .system(size: 16)
                        .weight(.medium))
                    
                    Button("Next") {
                        withAnimation {
                            state.showInstruction.toggle()
                        }
                    }
                    .buttonStyle(.plain)
                    .padding()
                    .foregroundColor(.black)
                    .background(RoundedRectangle(cornerRadius: 15)
                        .fill(Color("customWhite"))
                        .frame(width: 100, height: 50, alignment: .center)
                        .shadow(color: Color(.secondaryLabel), radius: 5, x: 0, y: 5)
                        )
                    .font(.system(size: 16).weight(.medium))

                } //: HStack
                .font(.system(size: 24))
                .offset(x: 0, y: 20)
                
            } //: VStack
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .background(Color("mainColor"))
            
            if state.showInstruction {
                InstructionPage()
                    .transition(.opacity)
            }
            
        } //: ZStack
        
        
       
    
    }
    
}



