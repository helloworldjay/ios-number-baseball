//
//  NumberBaseball - main.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import Foundation

var randomAnswer = [Int]()
var gameCount: Int = 9

enum InputType {
    case menuInput, gameInput
}

struct NumberBaseball{
    let gameMenuMessages = "1. 게임시작\n2. 게임종료\n원하는 기능을 선택해주세요 : "
    let gameInputMessages = "숫자 3개를 띄어쓰기로 구분하여 입력해주세요.\n중복 숫자는 허용하지 않습니다.\n입력 : "
    
    func generateRandomNumber() -> [Int] {
        var result = [Int]()
        while result.count < 3 {
            let number = Int.random(in: 1...9)
            if result.contains(number) { continue }
            result.append(number)
        }
        return result
    }
    
    func getResult(userInput: [Int], answer: [Int]) -> [Int] {
        var strike: Int = 0
        var ball: Int = 0
        for i in 0..<userInput.count {
            if userInput[i] == answer[i] {
                strike += 1
            } else if answer.contains(userInput[i]){
                ball += 1
            }
        }
        return [strike, ball]
    }
    
    func getUserInput(toPrint: String) -> String? {
        print(toPrint, terminator: "")
        return readLine()
    }
    
    func checkValidation(inputType: InputType, userInput: String?) -> [Int] {
        let inputErrorMessage = "입력이 잘못되었습니다"
        
        switch inputType {
        case InputType.menuInput:
            // 숫자 입력 체크
            guard let _userInput = Int(userInput!) else {
                print(inputErrorMessage)
                return checkValidation(inputType: InputType.menuInput, userInput: getUserInput(toPrint: gameMenuMessages))
            }
            switch _userInput {
            case 1: return checkValidation(inputType: InputType.gameInput, userInput: getUserInput(toPrint: gameInputMessages))
            case 2: exit(0)
            default:
                print(inputErrorMessage)
                return checkValidation(inputType: InputType.menuInput, userInput: getUserInput(toPrint: gameMenuMessages))
            }
        
        case InputType.gameInput:
            guard let _userInput = userInput else {
                print(inputErrorMessage)
                return checkValidation(inputType: InputType.gameInput, userInput: getUserInput(toPrint: gameInputMessages))
            }
            let inputArray = _userInput.components(separatedBy: " ")
            
            // 입력 개수 체크
            if inputArray.count != 3 {
                print(inputErrorMessage)
                return checkValidation(inputType: InputType.gameInput, userInput: getUserInput(toPrint: gameInputMessages))
            }
            
            for input in inputArray {
                // 숫자 입력 체크
                guard let number = Int(input) else {
                    print(inputErrorMessage)
                    return checkValidation(inputType: InputType.gameInput, userInput: getUserInput(toPrint: gameInputMessages))
                }
                // 숫자 범위 체크
                if number < 1 || number > 9 {
                    print(inputErrorMessage)
                    return checkValidation(inputType: InputType.gameInput, userInput: getUserInput(toPrint: gameInputMessages))
                }
            }
            
            return inputArray.map { Int($0)! }
        }
    }
    
    func printGameResult(gameResult: [Int]) {
        print("\(gameResult[0]) 스트라이크, \(gameResult[1]) 볼")
        
        if gameResult[0] == 3 {
            print("사용자 승리!")
            gameCount = 9
        } else {
        print("남은 기회 : \(gameCount)")
        }
        
        if gameCount == 0 {
            print("컴퓨터 승리...!")
            gameCount = 9
        }
    }
    
    func startGame() {
        let userInput: [Int]
        
        if gameCount == 9 {
            userInput = checkValidation(inputType: InputType.menuInput, userInput: getUserInput(toPrint: gameMenuMessages))
            randomAnswer = generateRandomNumber()
        } else {
            userInput = checkValidation(inputType: InputType.gameInput, userInput: getUserInput(toPrint: gameInputMessages))
        }
        
        gameCount -= 1
        let gameResult: [Int] = getResult(userInput: userInput, answer: randomAnswer)
        printGameResult(gameResult: gameResult)

        startGame()
    }
}

NumberBaseball().startGame()
