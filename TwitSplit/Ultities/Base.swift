//
//  Base.swift
//  TwitSplit
//
//  Created by Lu Kien Quoc on 1/31/19.
//  Copyright © 2019 Lu Kien Quoc. All rights reserved.
//

import Foundation

class Base: NSObject {
    
    static let limit_character = 50
    
    static func splitMessage(_ input: String) -> [String] {
        func split(_ noOfCharacter: Int, input: [String], output: inout [String]) -> Bool {
            // 4 character is "1/noOfCharacter"
            var totalLeftCount = 1 + 1 + noOfCharacter
            var stringAppend: String = ""
            
            var inputHandle = input
            while inputHandle.count > 0 {
                guard let string = inputHandle.first else {
                    return false
                }
                
                // if total output count lager than power of 10 vs noOfCharacter
                if output.count > Int(pow(10, Double(noOfCharacter))) - 1 {
                    return false
                }
                
                // countString = space + lenght of string
                let countString = 1 + string.count
                
                if countString + totalLeftCount >= limit_character {
                    return false
                }
                
                if totalLeftCount + countString + stringAppend.count <= limit_character {
                    stringAppend += " " + string
                    inputHandle.remove(at: 0)
                    
                    // append if not have any object in inputHandle
                    if inputHandle.isEmpty {
                        output.append(stringAppend)
                    }
                } else {
                    output.append(stringAppend)
                    
                    // go to next object of array output
                    totalLeftCount = (output.count + 1).numOfCharacters + 1 + noOfCharacter
                    stringAppend = ""
                }
            }
            
            return true
        }
        
        let inputWithTrim = input.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // check if not have any character
        if inputWithTrim.isEmpty {
            return []
        }
        
        // check if number character <= 50
        if inputWithTrim.count <= 50 {
            return [inputWithTrim]
        }
        
        let arr_SplitSpace = inputWithTrim.components(separatedBy: " ")
        if !arr_SplitSpace.filter({ $0.count > 50 }).isEmpty {
            return []
        }
        
        // Handle array
        var arr_Handle: [String] = []
        var noOfCharacter = 1
        while !split(noOfCharacter, input: arr_SplitSpace, output: &arr_Handle) {
            arr_Handle = []
            noOfCharacter += 1
        }
    
        // Format message for output
        let totalPage = arr_Handle.count
        var arr_Output: [String] = []
        for (index, element) in arr_Handle.enumerated() {
            let string = "\( index + 1 )/\( totalPage )\( element )"
            arr_Output.append(string)
        }
        
        return arr_Output
    }    
}
