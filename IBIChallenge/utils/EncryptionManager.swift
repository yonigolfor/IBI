//
//  EncryptionManager.swift
//  IBIChallenge
//
//  Created by Yoni Golfor on 31/07/2024.
//

import CryptoKit
import Foundation
import Security

struct EncryptionManager {
    private let salt = "mysalt"
    private let keyName = "encryptionKey"

    var key: SymmetricKey {
        getOrCreateSymmetricKey(keyName: keyName)
    }

    func encryptPassword(password: String) -> (String, Data)? {
        let saltedPassword = password + salt
        
        guard let saltedPasswordData = saltedPassword.data(using: .utf8) else {
            return nil
        }
        
        do {
            let encryptedData = try encryptData(data: saltedPasswordData)
            let encryptedString = encryptedData.base64EncodedString()
            return (encryptedString, encryptedData)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func decryptPassword(encryptedData: Data) -> String? {
        do {
            let decryptedData = try decryptData(ciphertext: encryptedData)
            guard var decryptedString = String(data: decryptedData, encoding: .utf8) else {
                return "Decryption failed"
            }
            if decryptedString.hasSuffix(salt) {
                // Remove the "mysalt" suffix
                decryptedString = String(decryptedString.dropLast(salt.count))
            }            
            return decryptedString
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    private func encryptData(data: Data) throws -> Data {
        let sealedBox = try AES.GCM.seal(data, using: key)
        return sealedBox.combined!
    }

    private func decryptData(ciphertext: Data) throws -> Data {
        let sealedBox = try AES.GCM.SealedBox(combined: ciphertext)
        return try AES.GCM.open(sealedBox, using: key)
    }
    
    func getOrCreateSymmetricKey(keyName: String) -> SymmetricKey {
        if let existingKey = getKeyFromKeychain(keyName: keyName) {
            return existingKey
        } else {
            let newKey = SymmetricKey(size: .bits256)
            let success = saveKeyToKeychain(key: newKey, keyName: keyName)
            
            if !success {
                print("Failed to save the key to Keychain")
            }
            return newKey
        }
    }
    func getKeyFromKeychain(keyName: String) -> SymmetricKey? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: keyName,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess, let keyData = item as? Data else {
            return nil
        }
        return SymmetricKey(data: keyData)
    }
    func saveKeyToKeychain(key: SymmetricKey, keyName: String) -> Bool {
        let keyData = key.withUnsafeBytes { Data(Array($0)) }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: keyName,
            kSecValueData as String: keyData,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]
        
        SecItemDelete(query as CFDictionary) // Remove any existing item
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
}




