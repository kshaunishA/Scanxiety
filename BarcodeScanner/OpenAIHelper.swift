//
//  OpenAIHelper.swift
//  BarcodeScanner
//
//  Created by Kshaunish Addala on 2025-07-29.
//

import Foundation
import UIKit

struct ProductInfo: Decodable {
    let itemName: String
    let price: String     // keep as string so GPT can add "CA$" etc.
    let emotion: String
}

enum OpenAIHelper {
    static func fetchInfo(for image: UIImage) async throws -> ProductInfo {
        // Convert image to base64
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw NSError(domain: "ImageProcessingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to data"])
        }
        let base64Image = imageData.base64EncodedString()
        
        // 1 — craft the chat request with vision (corrected format)
        let messages: [[String: Any]] = [
            [
                "role": "system",
                "content": """
                You are the Scanxiety™ Emotional Barcode Scanner AI. Given an image of any object, \
                identify what it is, estimate a reasonable retail price in CAD, and generate a deeply \
                poetic, absurd, and emotionally resonant assessment of what this object represents in terms \
                of human feelings, consumption psychology, and existential baggage.

                Your emotional assessments should be creative, varied, and use different formats like:
                - "Contains 45% impulsive sadness"
                - "Guilt score: 87/100"  
                - "Nostalgia detected: childhood summers"
                - "Regret residue: dangerously high"
                - "Craving satisfied. Fulfillment: still pending"
                - "Void-filling capacity: moderate"
                - "Self-worth correlation: inverse"
                - "Emotional tax: loneliness surcharge applied"
                - "Comfort level: false but effective"

                Be psychologically insightful but playfully absurd. Consider the hidden emotional \
                costs of ownership, the cultural baggage of objects, stress-buying patterns, \
                consumer guilt, nostalgic attachments, and the way objects promise feelings they can't deliver.

                CRITICAL: You must respond with ONLY valid JSON in exactly this format with no extra text:
                {"itemName":"description of the object","price":"CAD $X.XX","emotion":"your creative emotional assessment"}
                
                Do not include any explanation, markdown formatting, or additional text. Just the JSON object.
                """
            ],
            [
                "role": "user",
                "content": [
                    [
                        "type": "text",
                        "text": "Analyze this object's emotional cost and hidden psychological toll."
                    ],
                    [
                        "type": "image_url",
                        "image_url": [
                            "url": "data:image/jpeg;base64,\(base64Image)",
                            "detail": "low"
                        ]
                    ]
                ]
            ]
        ]
        
        let body: [String: Any] = [
            "model": "gpt-4o-mini",        // supports vision
            "temperature": 0.8,            // increased for more creativity
            "max_tokens": 300,
            "messages": messages
        ]

        // 2 — prepare request
        guard
            let apiKey = Bundle.main.object(forInfoDictionaryKey: "OpenAI_API_Key") as? String,
            let url = URL(string: "https://api.openai.com/v1/chat/completions"),
            let jsonData = try? JSONSerialization.data(withJSONObject: body)
        else { throw URLError(.badURL) }

        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = jsonData

        // 3 — perform with better error handling
        let (data, response) = try await URLSession.shared.data(for: req)
        
        // Debug: Print response details
        if let httpResponse = response as? HTTPURLResponse {
            print("HTTP Status: \(httpResponse.statusCode)")
        }
        
        // Try to parse the response
        guard let root = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            let responseString = String(data: data, encoding: .utf8) ?? "Unable to decode response"
            print("Raw response: \(responseString)")
            throw NSError(domain: "BadOpenAIResponse", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON response from OpenAI"])
        }
        
        // Check for API errors first
        if let error = root["error"] as? [String: Any],
           let message = error["message"] as? String {
            throw NSError(domain: "OpenAIAPIError", code: 2, userInfo: [NSLocalizedDescriptionKey: "OpenAI API Error: \(message)"])
        }
        
        guard
            let choices = root["choices"] as? [[String: Any]],
            let firstChoice = choices.first,
            let message = firstChoice["message"] as? [String: Any],
            let content = message["content"] as? String
        else {
            print("Response structure: \(root)")
            throw NSError(domain: "BadOpenAIResponse", code: 3, userInfo: [NSLocalizedDescriptionKey: "Unexpected response structure from OpenAI"])
        }
        
        // Clean and parse the JSON content
        let trimmedContent = content.trimmingCharacters(in: .whitespacesAndNewlines)
        print("AI Response: \(trimmedContent)")
        
        // Start with the trimmed content as-is
        var jsonContent = trimmedContent
        
        // Only do cleanup if we detect non-JSON wrapper text
        if jsonContent.hasPrefix("```json") {
            jsonContent = jsonContent
                .replacingOccurrences(of: "```json", with: "")
                .replacingOccurrences(of: "```", with: "")
                .trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        // If it doesn't start with {, try to find JSON
        if !jsonContent.hasPrefix("{") {
            if let startIndex = jsonContent.firstIndex(of: "{") {
                jsonContent = String(jsonContent[startIndex...])
            }
        }
        
        print("JSON to parse: \(jsonContent)")
        
        guard let jsonData = jsonContent.data(using: .utf8) else {
            throw NSError(domain: "BadOpenAIResponse", code: 4, userInfo: [NSLocalizedDescriptionKey: "Failed to convert AI response to data"])
        }
        
        do {
            // Try parsing as our expected format first
            return try JSONDecoder().decode(ProductInfo.self, from: jsonData)
        } catch let decodingError {
            print("JSON Decode Error: \(decodingError)")
            
            // Try to parse as generic JSON to see what we got
            if let genericJSON = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any] {
                print("Received JSON structure: \(genericJSON)")
                
                // Try to manually extract the fields with flexible key names
                let itemName = genericJSON["itemName"] as? String ?? 
                              genericJSON["item"] as? String ?? 
                              genericJSON["name"] as? String ?? 
                              genericJSON["object"] as? String ?? "Unknown Object"
                
                let price = genericJSON["price"] as? String ?? 
                           genericJSON["cost"] as? String ?? 
                           "Priceless (emotionally speaking)"
                
                let emotion = genericJSON["emotion"] as? String ?? 
                             genericJSON["emotional"] as? String ?? 
                             genericJSON["feeling"] as? String ?? 
                             genericJSON["toll"] as? String ?? 
                             "Emotional data corrupted"
                
                return ProductInfo(itemName: itemName, price: price, emotion: emotion)
            }
            
            throw NSError(domain: "BadOpenAIResponse", code: 5, userInfo: [NSLocalizedDescriptionKey: "Failed to decode AI response as ProductInfo. Original error: \(decodingError.localizedDescription)"])
        }
    }
}

