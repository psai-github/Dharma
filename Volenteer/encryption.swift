//
//  encryption.swift
//  Final HelperX
//
//  Created by Pranav Sai on 6/30/23.
//

import Foundation
import Foundation
import RNCryptor

func encryptMessage(message: String) throws -> String {
    let messageData = message.data(using: .utf8)!
    let cipherData = RNCryptor.encrypt(data: messageData, withPassword: "crazybutheslikethat")
    return cipherData.base64EncodedString()
}

func decryptMessage(encryptedMessage: String) throws -> String {

    let encryptedData = Data.init(base64Encoded: encryptedMessage)!
    let decryptedData = try RNCryptor.decrypt(data: encryptedData, withPassword: "crazybutheslikethat")
    let decryptedString = String(data: decryptedData, encoding: .utf8)!

    return decryptedString
}

