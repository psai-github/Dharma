//
//  AiI_Image_Generation.swift
//  Volenteer
//
//  Created by Pranav Sai on 7/25/23.
//

import Foundation
import OpenAIKit
import SwiftUI

final class ImageGenerationModel: ObservableObject{
    private var openai: OpenAI?
    func setup(){
        openai = OpenAI(Configuration(organizationId: "Personal", apiKey: "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"))
    }
    
    func generateImage(prompt:String) async -> Data?{
        guard let openai = openai else{
            return nil
        }
        do{
            let params = ImageParameters(
                prompt: prompt,
                resolution: .medium,
                responseFormat: .base64Json
            )
            let result = try await openai.createImage(parameters: params)
            let data = result.data[0].image
            print(data)
            return Data(data.utf8)
            
        }
        catch{
            print(error)
            return nil
        }
    }
}
func getImageGeneration(prompt:String) async -> UIImage?{
    let openai = OpenAI(Configuration(organizationId: "Personal", apiKey: "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"))
    do{
        let params = ImageParameters(
            prompt: prompt,
            resolution: .medium,
            responseFormat: .base64Json
        )
        let result = try await openai.createImage(parameters: params)
        let data = result.data[0].image
        let image = try openai.decodeBase64Image(data)
     
        return image
                                          
    }
    catch{
        print(error)
        return nil
                                      
                                      
    }
                                      
                                     }
