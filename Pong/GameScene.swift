//
//  GameScene.swift
//  Pong
//
//  Created by Denielle Kirk Abaquita on 5/14/17.
//  Copyright © 2017 Denielle Kirk Abaquita. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // Variables
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var user = SKSpriteNode()
    
    var score = [Int]() // Clean score keeping
    
    var topLbl = SKLabelNode()
    var bottomLbl = SKLabelNode()
    
    
    
    // Basically the start of the game
    override func didMove(to view: SKView) {
        
        topLbl = self.childNode(withName: "topLabel") as! SKLabelNode
        bottomLbl = self.childNode(withName: "bottomLabel") as! SKLabelNode
        
        // Settings nodes to variables
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemyPaddle") as! SKSpriteNode
        user = self.childNode(withName: "userPaddle") as! SKSpriteNode
        
        // Allows the ball to move in 45 degree angle towards top right corner
        ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        
        // declaring the border as a phyics body
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1 // lets things bounce off
        
        self.physicsBody = border
        
        startGame()
        
          }
    
    
    // Resets score
    func startGame() {
        score = [0,0]  // [myscore, enemyscore]
        bottomLbl.text = "\(score[0])"
        topLbl.text = "\(score[1])"
        ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
    }
    
    
    // Updates score
    func addScore(playerWon : SKSpriteNode) {
        
        // Placing ball at center and removing all impulses
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWon == user {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
        
        }
        else if playerWon == enemy {
            score[1]  += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -10, dy: -10))
        }
        
        
        
        bottomLbl.text = "\(score[0])"
        topLbl.text = "\(score[1])"
    }
    
    
    // Start of the touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Detects and responds to the touches
        for touch in touches {
            let location = touch.location(in: self)
            
            user.run(SKAction.moveTo(x: location.x, duration: 0.2))
            
        }
        
    }
    
    
    // Updated touch when dragging
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Detects and responds to the touches
        for touch in touches {
            let location = touch.location(in: self)
            
            user.run(SKAction.moveTo(x: location.x, duration: 0.2))
            
        }

        
    }
    
    // Tests variables as the game is being played
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // enemy moves with delay along with the ball
        enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
        
        if ball.position.y <= user.position.y - 70 {
            addScore(playerWon: enemy)
            
        }
        else if ball.position.y <= enemy.position.y + 70 {
            addScore(playerWon: user)
            
        }
        
    }
}
