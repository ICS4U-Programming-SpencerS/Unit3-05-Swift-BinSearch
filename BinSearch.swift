import Foundation

/**
 - Binary Search Program in Swift
 
 - Author - Spencer S
 - Version - 1.0
 - Since: 2024-05-2
 */
final class BinSearch {
    
    // main function
    static func main() {
        var listOfStrings = [String]()
        // empty variable for later
        do {
            // preps file access and writing/reading
            let fileInput = URL(fileURLWithPath: "input.txt")
            let fileOutput = URL(fileURLWithPath: "output.txt")
            let inputString = try String(contentsOf: fileInput)
            listOfStrings = inputString.components(separatedBy: .newlines)
            
            let fileOutputString = OutputStream(toFileAtPath: fileOutput.path, append: false)!
            fileOutputString.open()
            
            // for loop to remove spaces with the array to make it readable and find the target number
            var i = 0
            while i < listOfStrings.count - 1 {
                guard let target = Int(listOfStrings[i]) else {
                    print("Invalid target: \(listOfStrings[i])")
                    i += 2
                    continue
                }
                
                let numStrings = listOfStrings[i + 1].components(separatedBy: " ")
                let arrayNum = numStrings.compactMap { Int($0) }
                
                if arrayNum.count == 0 {
                    print("Invalid array: \(listOfStrings[i + 1])")
                    i += 2
                    continue
                }
                
                // sort the array
                let sortedArrayNum = arrayNum.sorted()
                
                // output message for if the target was found or not
                // but also shows the index found at
                let resultFinal = recBinSearch(target: target, arrayNum: sortedArrayNum, low: 0, high: sortedArrayNum.count - 1)
                if resultFinal == -1 {
                    let message = "Target \(target) was not found within the array\n"
                    if let data = message.data(using: .utf8) {
                        _ = data.withUnsafeBytes { fileOutputString.write($0, maxLength: data.count) }
                    }
                } else {
                    let message = "Target \(target) was found at index \(resultFinal) within the array\n"
                    if let data = message.data(using: .utf8) {
                        _ = data.withUnsafeBytes { fileOutputString.write($0, maxLength: data.count) }
                    }
                }
                i += 2
            }
            // closes resources
            fileOutputString.close()
        } catch {
            // For when no input file is found.
            print("Error: \(error)")
        }
        // program finished
        print("Done")
    }
    
     // This function uses recursion to find the search number in the array.
    static func recBinSearch(target: Int, arrayNum: [Int], low: Int, high: Int) -> Int {
        if high >= low {
            let mid = low + (high - low) / 2
            if arrayNum[mid] == target {
                return mid
            } else if arrayNum[mid] > target {
                return recBinSearch(target: target, arrayNum: arrayNum, low: low, high: mid - 1)
            } else {
                return recBinSearch(target: target, arrayNum: arrayNum, low: mid + 1, high: high)
            }
        } else {
            return -1
        }
    }
}

// Run the main method
BinSearch.main()
