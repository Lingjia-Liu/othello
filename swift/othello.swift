// USAGE: swift -sdk $OSX_SDK othello.swift
// Example OSX_SDK location:
// /Applications/Xcode6-Beta5.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk

import Foundation

var openString = "----------\n" +
    "Swiftでコマンドラインオセロ！\n" +
    "----------\n"



/**
 * Creates the initial board.
 */
func getInitialBoard() -> [[Int]] {
    var board = [[Int]]()
    var row = [Int]()
    for i in 0..<8 {
        row = [0, 0, 0, 0, 0, 0, 0, 0]
        board.append(row)
    }
    board[3][3] = 1
    board[4][4] = 1
    board[3][4] = 2
    board[4][3] = 2
    return board
}

/**
 * Prints the board, prettified.
 */
func printBoard(board: [[Int]]) {
    for row in board {
        println(row)
    }
}


/**
 * Takes and returns hand coordinates from keyboard
 */
func readNumbers() -> [Int] {
    var s = [Int]()
    var a = getchar()
    while a != 10 {
        // ignore comma
        if a != 44 {
            // Only account for digits
            if a > 48 && a < 58 {
                s.append(Int(a)-48)
            }
        }
        a = getchar()
    }
    return s
}


/**
 * Wrapper for readNumbers(),
 * complete with text prompt.
 */
func getPosition() -> [Int] {
    println("数字を入力してください。(x, y)")
    return readNumbers()
}


/**
 * Takes the current board state and hand info and computes the result.
 * Retuns true if the hand was legal, false otherwise.
 */
func applyHand(board: [[Int]], x: Int, y: Int, val: Int) -> Bool {
    if board[x][y] == 0 {
        // TODO: なぜかこの代入がエラーになる
//        board[x][y] = val
        // TODO: ひっくりかえす
        return true
    } else {
        return false
    }
}


/* MAIN EXECUTION UNIT STARTS HERE */

println(openString)
var board = getInitialBoard()
var yx = [Int]()
var x = 0
var y = 0
var whose = 1
var legal = false
printBoard(board)


// Main Loop
while true {
    println("")
    println("-------")
    println("\(whose)の番です。")
    yx = getPosition()
    x = yx[1]
    y = yx[0]
    legal = applyHand(board, x, y, whose)
    
    if legal {
        board[x][y] = whose
        printBoard(board)
        whose += 1
        if whose == 3 {
            whose = 1
        }
    } else {
        println("無効な手です。")
    }
    
}








