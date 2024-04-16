//
//  ChatViewModel.swift
//  Chatgpt3.5
//
//  Created by Rauan on 29.11.2023.
//

import Foundation

extension ChatView {
    class ViewModel: ObservableObject {
        @Published var messages: [Message] = []
        
        @Published var currentInput: String = ""
        
        private let openAIService = OpenAIService()
        func sendMessage() {
            let newMessage = Message(id: UUID().uuidString, role: .user, content: currentInput, createAt: Date())
            messages.append(newMessage)
            currentInput = ""
            
//            Task {
//                let responce = await openAIService.sendMessage(messages: messages)
//                guard let receiveOpenAIMessage = responce?.choices.first?.message else {
//                    print("Had no message")
//                    return
//                }
//                let receivedMessage = Message(id: UUID(), role: receiveOpenAIMessage.role, content: receiveOpenAIMessage.content, createAt: Date())
//                await MainActor.run {
//                    messages.append(receivedMessage)
//                }
//            }
            openAIService.sendStreamMessage(messages: messages).responseStreamString { [weak self] stream in
                guard let self = self else { return }
                switch stream.event {
                case .stream(let responce):
                    switch responce {
                    case .success(let string):
                        let streamResponce = parseStreamData(string)
                        
                        streamResponce.forEach { newMessageResponce in
                            guard let messageContent = newMessageResponce.choices.first?.delta.content else {
                                return
                            }
                            guard let existingMessageIndex = self.messages.lastIndex(where: {$0.id == newMessageResponce.id}) else {
                                let newMessage = Message(id: newMessageResponce.id,role: .assistant,content: messageContent,createAt: Date())
                                self.messages.append(newMessage)
                                return
                            }
                            let newMessage = Message(id: newMessageResponce.id, role: .assistant, content: self.messages[existingMessageIndex].content + messageContent, createAt: Date())
                            self.messages[existingMessageIndex] = newMessage
                            
                        }
                        
                    case .failure(_):
                        print("something fails")
                    }
                case .complete(_):
                    print("Complete")
                }
            }
        }
        func parseStreamData(_ data: String) ->[ChatStreamCompletionResponse]{
            let responceString = data.split(separator: "data:").map({$0.trimmingCharacters(in: .whitespacesAndNewlines)}).filter({!$0.isEmpty})
            let jsonDecoder = JSONDecoder()
            
            return responceString.compactMap { jsonString in
                guard let jsonData = jsonString.data(using: .utf8), let streamResponce = try? jsonDecoder.decode(ChatStreamCompletionResponse.self, from: jsonData) else {
                    return nil
                }
                return streamResponce
            }
        }
        func cancelStream() {
            openAIService.cancelStream()
        }
    }
}

struct Message: Decodable {
    let id: String
    let role: SenderRole
    let content: String
    let createAt: Date
}

struct ChatStreamCompletionResponse: Decodable {
    let id: String
    let choices: [ChatStreamChoice]
}
struct ChatStreamChoice: Decodable {
    let delta: ChatStreamContent
}
struct ChatStreamContent: Decodable {
    let content: String?
}
