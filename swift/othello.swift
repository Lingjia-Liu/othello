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
    var black = 0
    var white = 0
    for row in board {
        println(row)
        for el in row {
            if el == 1 {
                black++
            } else if el == 2 {
                white++
            }
        }
    }
    println()
    println("Black: \(black)   White: \(white)")
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
            if a > 47 && a < 58 {
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
 * Retuns an empty array if the result is illegal.
 */
func applyHand(var board: [[Int]], x: Int, y: Int, val: Int) -> [[Int]] {
    if board[x][y] == 0 {
        board[x][y] = val
        var turned = false
        var buff: [[Int]] = [[]]
        for xi in [1, 0, -1] {
            for yi in [1, 0, -1] {
                if yi == 0 && xi == 0 {
                    continue
                }
                buff = findTurn(board, x, y, [xi, yi])
                if buff.count > 0 {
                    board = buff
                    turned = true
                }
            }
        }
        if turned {
            return board
        } else {
            return []
        }
    } else {
        return []
    }
}


func findTurn(var board: [[Int]], x: Int, y:Int, dir:[Int]) -> [[Int]] {
    var stroke = 0
    var closed = false
    var hand = board[x][y]
    for i in 1..<8 {
        var xx = x + i*dir[0]
        var yy = y + i*dir[1]
        // If out of range, then break out
        if xx < 0 || xx > 7 || yy < 0 || yy > 7 {
            break
        }
        // If the same side's stone exists, break out
        if board[xx][yy] == hand {
            closed = true
        } else if board[xx][yy] == 0 {
            break
        } else {
            stroke++
            board[xx][yy] = hand
        }
    }
    if stroke > 0 && closed {
        return board
    } else {
        return []
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
    var next: [[Int]] = applyHand(board, x, y, whose)
    
    if next.count > 0 {
        println()
        printBoard(next)
        board = next
        whose += 1
        if whose == 3 {
            whose = 1
        }
    } else {
        println("無効な手です。")
    }
    
}








