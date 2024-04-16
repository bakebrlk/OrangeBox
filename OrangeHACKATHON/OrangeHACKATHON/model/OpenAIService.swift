//
//  OpenAIService.swift
//  Chatgpt3.5
//
//  Created by Rauan on 29.11.2023.
//

import Foundation
import Alamofire

class OpenAIService {
    private var dataStreamRequest: DataStreamRequest?
    private var generatingMessageId: String?
    private let endpointUrl = "https://api.openai.com/v1/chat/completions"
    func sendMessage(messages: [Message]) async -> OpenAIChatResponse? {
        let openAIMessages = messages.map({OpenAIChatMessage(role: $0.role,content: $0.content)})
        let body = OpenAIChatBody(model: "gpt-3.5-turbo", messages: openAIMessages,stream: false)
        let headers: HTTPHeaders = [
            "Authorization":"Bearer \(Constants.openAIApiKey)"
        ]
        return try? await AF.request(endpointUrl,method: .post,parameters: body,encoder: .json,headers: headers).serializingDecodable(OpenAIChatResponse.self).value
    }
    func sendStreamMessage(messages: [Message]) -> DataStreamRequest {
        let openAIMessages = messages.map({OpenAIChatMessage(role: $0.role,content: $0.content)})
        let body = OpenAIChatBody(model: "gpt-3.5-turbo", messages: openAIMessages,stream: true)
        let headers: HTTPHeaders = [
            "Authorization":"Bearer \(Constants.openAIApiKey)"
        ]
//        return AF.streamRequest(endpointUrl,method: .post,parameters: body,encoder: .json,headers: headers)
        
        generatingMessageId = messages.last?.id
        dataStreamRequest = AF.streamRequest(endpointUrl, method: .post, parameters: body, encoder: .json, headers: headers)
        return dataStreamRequest!
    }
    
    func cancelStream() {
        dataStreamRequest?.cancel()
        generatingMessageId = nil
    }
}

struct OpenAIChatBody: Encodable {
    let model: String
    let messages: [OpenAIChatMessage]
    let stream: Bool
}

struct OpenAIChatMessage: Codable {
    let role: SenderRole
    let content: String
}
enum SenderRole: String,Codable {
    case system
    case user
    case assistant
}
struct OpenAIChatResponse: Decodable {
    let choices: [OpenAIChatChoice]
}
struct OpenAIChatChoice: Decodable {
    let message: OpenAIChatMessage
}
