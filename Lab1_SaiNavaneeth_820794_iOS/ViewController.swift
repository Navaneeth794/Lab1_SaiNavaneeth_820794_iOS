//
//  ViewController.swift
//  Lab1_SaiNavaneeth_820794_iOS
//
//  Created by Sai Navaneeth on 18/01/22.
//  Copyright © 2022 Navaneeth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var labelX: UILabel!
    @IBOutlet weak var labelO: UILabel!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var swipeView: UIView!
    
    var currentPlayer = ""
    
    var x = 0
    var o = 0
    
    var rules = [[0,1,2],[3,4,5],[6,7,8],[1,4,7],[2,5,8],[0,4,8],[2,4,6],[0,3,6]]
    
    var board = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addGestureRecognizer(leftSwipeGestureRecognizer)
        self.view.addGestureRecognizer(rightSwipeGestureRecognizer)
        
        loadBoard()
        print(board)
    }
    
    @objc func swipedLeft(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            reset()
            print("Swiped left")
        }
    }
    
    @objc func swipedRight(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            reset()
            print("Swiped right")
        }
    }
    
    lazy var leftSwipeGestureRecognizer: UISwipeGestureRecognizer = {
        let gesture = UISwipeGestureRecognizer()
        gesture.direction = .left
        gesture.addTarget(self, action: #selector(swipedLeft))
        return gesture
    }()
    
    lazy var rightSwipeGestureRecognizer: UISwipeGestureRecognizer = {
        let gesture = UISwipeGestureRecognizer()
        gesture.direction = .right
        gesture.addTarget(self, action: #selector(swipedRight))
        return gesture
    }()
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let index = buttons.firstIndex(of: 	sender)!
        print(index)
        
        if !board[index].isEmpty {return}
        if(currentPlayer == "X"){
            sender.setTitle("X", for: .normal)
            currentPlayer = "O"
            board[index] = "X"
        }else{
            sender.setTitle("O", for: .normal)
            currentPlayer = "X"
            board[index] = "O"
        }
        whoWins()
    }
    
    func whoWins(){
        for rule in rules {
            let player1 = board[rule[0]]
            let player2 = board[rule[1]]
            let player3 = board[rule[2]]
            
            if player1 == player2,
                player2 == player3,
                !player1.isEmpty {
                print ("winner is \(player2)")
                showAlert(msg: "Player \(player3) You've won!")
                
                if player1 == "X" {
                    x=x+1
                    labelX.text = String(x);
                }else{
                    o=o+1
                    labelO.text = String(o);
                }
                return
            }
        }
        if !board.contains(""){
            showAlert(msg: "It's a Draw!")
        }
    }
    
    func showAlert(msg: String) {
        let alert  = UIAlertController(title: "Success",message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) {
            _ in self.reset()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func reset() {
        board.removeAll()
        loadBoard()
        
        for button in buttons {
            button.setTitle(nil, for: .normal)
        }
    }
    
    func loadBoard(){
        for i in 0..<buttons.count {
            board.append("")
        }
    }
}

