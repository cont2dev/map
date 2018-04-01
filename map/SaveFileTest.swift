//
//  SaveFileTest.swift
//  map
//
//  Created by 양덕규 on 01/04/2018.
//  Copyright © 2018 three idiots. All rights reserved.
//

import Foundation

// https://stackoverflow.com/questions/24097826/read-and-write-a-string-from-text-file
// https://stackoverflow.com/questions/46456481/how-to-write-a-file-to-a-folder-located-at-apples-files-app-in-swift-4
class SaveFileTest {

    static let share = SaveFileTest()
    var fileName = "map_test_save_file.txt"
    var fileContent = "Is this message saved?"
    var dir: URL
    var fileURL: URL
    var fileShareURL: URL
    
    init() {
        dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        fileURL = dir.appendingPathComponent(fileName)
        fileShareURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
    }
    
    func saveFile() {
        do {
            try fileContent.write(to: fileURL, atomically: false, encoding: .utf8)
        } catch {
            
        }
    }
    
    func readFile() -> String {
        var text: String = "File not found"
        
        do {
            text = try String(contentsOf: fileURL, encoding: .utf8)
        } catch {
            
        }
        
        return text
    }
}
