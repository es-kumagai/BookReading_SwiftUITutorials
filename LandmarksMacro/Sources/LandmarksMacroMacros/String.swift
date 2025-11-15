//
//  String.swift
//  LandmarksMacro
//
//  Created by とりあえず読書会 on 2025/11/03.
//

extension StringProtocol {
    
    var lowerCamelcased: String {
        guard let firstASCIIValue = first?.asciiValue else {
            return String(self)
        }
        
        let newASCIIValue = firstASCIIValue | 0b0010_0000
        let newCharacter = Character(Unicode.Scalar.init(newASCIIValue))
        let newString = String(newCharacter)
        
        return newString + dropFirst()
    }
    
    var upperCamelcased: String {
        guard let firstASCIIValue = first?.asciiValue else {
            return String(self)
        }
        
        let newASCIIValue = firstASCIIValue & 0b1101_1111
        let newCharacter = Character(Unicode.Scalar.init(newASCIIValue))
        let newString = String(newCharacter)

        return newString + dropFirst()
    }
}
