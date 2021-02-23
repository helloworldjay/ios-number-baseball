//
//  NumberBaseball - main.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import Foundation

var randomAnswer = [Int]()
var gameCount: Int = 9

struct NumberBaseball{
    // 게임 메뉴 및 사용자 입력 메세지 구현
    let gameMenuMessage = ""
    let inputMessage = ""
    
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
    
    // 사용자 입력 받는 함수(유효성 검사를 다른 함수에서 하기 위해서는 string으로 반환되어야함)
    func getUserInput() -> String {
        return "1 2 3"
    }
    
    func checkValidation(userInput: String) -> Bool {
        // 문자열인지 확인
        
        // 중복여부 & 3개 입력받았는지 확인
        if userInput.count != 3 || Array(Set(userInput)).count != 3 {
            return false
        }
        return true
    }
    
    func printGameResult(userInput: [Int], gameResult: [Int], gameCount: Int) {
        print("임의의 수: \(userInput[0]) \(userInput[1]) \(userInput[2])")
        if gameCount == 0 {
            print("컴퓨터 승리...!")
        }
        print("\(gameResult[0]) 스트라이크, \(gameResult[1]) 볼")
        if gameResult[0] == 3 {
            print("사용자 승리!")
        } else {
        print("남은 기회 : \(gameCount)")
        }
    }
    
    func startGame() {
        gameCount -= 1
        let input = generateRandomNumber()
        let userInput = generateRandomNumber()
        randomAnswer = generateRandomNumber()
        // 메뉴 출력
        print(gameMenuMessage)
        // get userMenuInput
        // 입력 메세지 출력
        print(inputMessage)
        // get userNumberInput
        // validation check -> boolean
        // valid하면 게임실행하고 아니면 다시 입력
        let gameResult: [Int] = getResult(userInput: input, answer: randomAnswer)
        printGameResult(userInput: userInput, gameResult: gameResult, gameCount: gameCount)
        if gameCount > 0 {
            startGame()
        }
    }
}

NumberBaseball().startGame()
