//
//  ViewController.swift
//  PowerUp
//
//  Created by David Kirsch on 3/21/18.
//  Copyright © 2018 David Kirsch. All rights reserved.
//

import UIKit
import AVFoundation
import Darwin



class ViewController: UIViewController {
  
   
    

    @IBOutlet weak var livesIcon: UIImageView!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var effectsSwitch: UISwitch!
    @IBOutlet weak var soundSwitch: UISwitch!
    @IBAction func startBtn(_ sender: Any) {
    }
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var endScreen: UIView!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var levelGUI: UIImageView!
    @IBOutlet weak var correctLights: UIImageView!
    @IBOutlet weak var message_lbl: UILabel!
    @IBOutlet weak var currentLights_lbl: UILabel!
    @IBOutlet weak var lightsOn_lbl: UILabel!
    @IBOutlet weak var startScreen: UIImageView!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var gameScreen: UIView!

    var button1 = 0;
    var button2 = 0
    var button3 = 0
    var button4 = 0
    var button5 = 0
    var button6 = 0
    var button7 = 0
    var button8 = 0
    var currentCount = 0
    var limit = 2
    var number = 0
    var correct = 0
    var level = 1
    var seconds = 45
    var timer1 = Timer()
    var isTimerRunning = false
    var added = 15
    var multiply = 0
    var recordData: String!
    var pointsData: String!
    var totalScore = 0.0
    var score: Int!
    var record: Int!
    var lives = 0


    
   
 
    
  
    
    var player: AVAudioPlayer!
    var soundEffect: AVAudioPlayer!
    var correctSound: AVAudioPlayer!
    var wrongSound: AVAudioPlayer!
    var LevelUP: AVAudioPlayer!
   
    
    override func viewDidLoad() {
     
        super.viewDidLoad()
       
        let path = Bundle.main.path(forResource: "game", ofType: "mp3")!
        let url = URL(fileURLWithPath: path)
        let click = Bundle.main.path(forResource: "click", ofType:"mp3" )!
        let url1 = URL(fileURLWithPath: click)
        let right = Bundle.main.path(forResource: "correct", ofType: "mp3")!
        let url2 = URL(fileURLWithPath: right)
        let wrong = Bundle.main.path(forResource: "wrong", ofType: "mp3")!
        let url3 = URL(fileURLWithPath: wrong)
        let levels = Bundle.main.path(forResource: "Level", ofType: "mp3")!
        let url4 = URL(fileURLWithPath: levels)
        
  
     
       
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            try AVAudioSession.sharedInstance().setActive(true)
            soundEffect = try AVAudioPlayer(contentsOf: url1)
            player = try AVAudioPlayer(contentsOf: url)
            correctSound = try AVAudioPlayer(contentsOf: url2)
            wrongSound = try AVAudioPlayer(contentsOf: url3)
            LevelUP = try AVAudioPlayer(contentsOf: url4)
            player.prepareToPlay()
            soundEffect.prepareToPlay()
            correctSound.prepareToPlay()
            wrongSound.prepareToPlay()
            LevelUP.prepareToPlay()
            player.volume = 0.5
            soundEffect.volume = 1
            correctSound.volume = 1
            wrongSound.volume = 1
            LevelUP.volume = 1
           
            
        } catch let error as NSError{
            print(error.description)
        }
        player.volume = 0.5
        player.play()
        player.numberOfLoops = -1
        
        var number = Int(arc4random_uniform(UInt32(limit)))
        number = 0
        var rand = String(number)
        runTimer()
        
        lightsOn_lbl.text = rand
        
        let userDefaults = Foundation.UserDefaults.standard
        let value = userDefaults.string(forKey: "Record")
        recordData = value
        
        let userDefaults1 = Foundation.UserDefaults.standard
        let value1 = userDefaults1.string(forKey: "Points")
        pointsData = value1
    }


    @IBAction func check(_ sender: AnyObject) {
        
        
        if(currentCount == number){
            
            totalScore = totalScore + (Double(seconds) / 10)
            print(totalScore)
            points.text = String(format: "%.1f", (totalScore))
//            points.text = "\(totalScore)"
            print(totalScore)
            if(correct == 5){
                correct = -1
                level += 1
                limit = limit * 2
                if(limit > 256){
                    limit = 2
                    lives+=1
                    
                    
                }
                LevelUP.currentTime = 0
                  LevelUP.play()
                 //AudioServicesPlaySystemSound(levels)
              
                
                
                message_lbl.text = "Level"
                
            }
          
        
            if(level > 8 && level < 17){
                multiply = 1
                levelGUI.image = UIImage(named: "Red.png")
                background.image = UIImage(named: "Red.png")
                currentLights_lbl.isHidden = true
            }
            if(level > 16 && level < 25){
                levelGUI.image = UIImage(named: "Orange.png")
                background.image = UIImage(named: "Orange.png")
                multiply = 2
            }
            if(level > 24 && level < 33){
                levelGUI.image = UIImage(named: "Yellow.png")
                background.image = UIImage(named: "Yellow.png")
                multiply = 3
            }
            if(level > 32 && level < 41){
                multiply = 4
                
                
            }
            number = Int(arc4random_uniform(UInt32(limit)))
            var rand = String(number)
            lightsOn_lbl.text = rand
            correctSound.currentTime = 0
            correctSound.play()
            //AudioServicesPlaySystemSound(ding)
            message_lbl.text = "Correct!"
            correct += 1
            print ("number correct: ", correct, "current level ", level, "Limit: ", limit)
            if(correct == 0){
                seconds = 46 + (added * multiply)
                correctLights.image = UIImage(named: "0lights.png")
                message_lbl.text = "Level \(level)"
            }
             else if ( correct == 1){
                correctLights.image = UIImage(named: "1lights.png")
            }
             else if(correct == 2){
                 correctLights.image = UIImage(named: "2lights.png")
            }
             else if(correct == 3){
                correctLights.image = UIImage(named: "3lights.png")
            }
             else if(correct == 4){
                correctLights.image = UIImage(named: "4lights.png")
            }
             else if(correct == 5){
                correctLights.image = UIImage(named: "5lights.png")
            }
            
          
            
        } else {
            totalScore = totalScore - (Double(seconds) / 10)
//            totalScore = totalScore - (Double(seconds) / 10.0)
            if(totalScore < 0){
                totalScore = 0
            }
            points.text = String(format: "%.1f", (totalScore))
            correct -= 1
            if(correct < 0){
                correct = 0
            }
            message_lbl.text = "Sorry, try again."
            wrongSound.currentTime = 0
         wrongSound.play()
         //   AudioServicesPlaySystemSound(errr)
            if(correct == 0){
                correctLights.image = UIImage(named: "0lights.png")
                
            }
            else if ( correct == 1){
                correctLights.image = UIImage(named: "1lights.png")
            }
            else if(correct == 2){
                correctLights.image = UIImage(named: "2lights.png")
            }
            else if(correct == 3){
                correctLights.image = UIImage(named: "3lights.png")
            }
            else if(correct == 4){
                correctLights.image = UIImage(named: "4lights.png")
            }
            else if(correct == 5){
                correctLights.image = UIImage(named: "5lights.png")
            }
        }
        print(number)
        
    }
    
    
    @IBAction func btn1_Pressed(_ sender: AnyObject) {
        
         //AudioServicesPlaySystemSound(click)
        soundEffect.currentTime = 0
        soundEffect.play()
        if(button1 == 0){
            sender.setImage(UIImage(named: "LightOn.png"), for: UIControlState())
            button1 = 1
            currentCount += 1
        } else {
            sender.setImage(UIImage(named: "LightOff.png"), for: UIControlState())
            button1 = 0
            currentCount -= 1
        }
         message_lbl.text = ""
        var cCount = String(currentCount)
        currentLights_lbl.text = cCount
    }
    @IBAction func btn2_Pressed(_ sender: AnyObject) {
        soundEffect.currentTime = 0
          soundEffect.play()
         //AudioServicesPlaySystemSound(click)
        if(button2 == 0){
            sender.setImage(UIImage(named: "LightOn.png"), for: UIControlState())
            button2 = 1
            currentCount += 2
        } else {
            sender.setImage(UIImage(named: "LightOff.png"), for: UIControlState())
            button2 = 0
            currentCount -= 2
        }
         message_lbl.text = ""
        var cCount = String(currentCount)
        currentLights_lbl.text = cCount
    }
    @IBAction func button3_Pressed(_ sender: AnyObject) {
        soundEffect.currentTime = 0
          soundEffect.play()
       //AudioServicesPlaySystemSound(click)
        if(button3 == 0){
            sender.setImage(UIImage(named: "LightOn.png"), for: UIControlState())
            button3 = 1
            currentCount += 4
        } else {
            sender.setImage(UIImage(named: "LightOff.png"), for: UIControlState())
            button3 = 0
            currentCount -= 4
        }
         message_lbl.text = ""
        var cCount = String(currentCount)
        currentLights_lbl.text = cCount
    }
    @IBAction func button4_Pressed(_ sender: AnyObject) {
        soundEffect.currentTime = 0
          soundEffect.play()
        // AudioServicesPlaySystemSound(click)
        if(button4 == 0){
            sender.setImage(UIImage(named: "LightOn.png"), for: UIControlState())
            button4 = 1
            currentCount += 8
        } else {
            sender.setImage(UIImage(named: "LightOff.png"), for: UIControlState())
            button4 = 0
            currentCount -= 8
        }
         message_lbl.text = ""
        var cCount = String(currentCount)
        currentLights_lbl.text = cCount
    }
    @IBAction func button5_Pressed(_ sender: AnyObject) {
        soundEffect.currentTime = 0
          soundEffect.play()
          //AudioServicesPlaySystemSound(click)
        if(button5 == 0){
            sender.setImage(UIImage(named: "LightOn.png"), for: UIControlState())
            button5 = 1
            currentCount += 16
        } else {
            sender.setImage(UIImage(named: "LightOff.png"), for: UIControlState())
            button5 = 0
            currentCount -= 16
        }
         message_lbl.text = ""
        var cCount = String(currentCount)
        currentLights_lbl.text = cCount
    }
    @IBAction func button6_Pressed(_ sender: AnyObject) {
        soundEffect.currentTime = 0
          soundEffect.play()
        //AudioServicesPlaySystemSound(click)
        if(button6 == 0){
            sender.setImage(UIImage(named: "LightOn.png"), for: UIControlState())
            button6 = 1
            currentCount += 32
        } else {
            sender.setImage(UIImage(named: "LightOff.png"), for: UIControlState())
            button6 = 0
            currentCount -= 32
        }
         message_lbl.text = ""
        var cCount = String(currentCount)
        currentLights_lbl.text = cCount
    }
    @IBAction func button7_Pressed(_ sender: AnyObject) {
        soundEffect.currentTime = 0
          soundEffect.play()
        // AudioServicesPlaySystemSound(click)
        if(button7 == 0){
            sender.setImage(UIImage(named: "LightOn.png"), for: UIControlState())
            button7 = 1
            currentCount += 64
        } else {
            sender.setImage(UIImage(named: "LightOff.png"), for: UIControlState())
            button7 = 0
            currentCount -= 64
        }
         message_lbl.text = ""
        var cCount = String(currentCount)
        currentLights_lbl.text = cCount
    }
    @IBAction func button8_Pressed(_ sender: AnyObject) {
        soundEffect.currentTime = 0
          soundEffect.play()
         //AudioServicesPlaySystemSound(click)
        if(button8 == 0){
            sender.setImage(UIImage(named: "LightOn.png"), for: UIControlState())
            button8 = 1
            currentCount += 128
            
        } else {
            sender.setImage(UIImage(named: "LightOff.png"), for: UIControlState())
            button8 = 0
            currentCount -= 128
            
        }
         message_lbl.text = ""
        var cCount = String(currentCount)
        currentLights_lbl.text = cCount
    }
    
    func runTimer(){
        timer1 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    @objc func updateTimer(){
        if(lives == 0){
            livesIcon.image = UIImage(named: "0lives.png")
            
        } else if (lives == 1){
            livesIcon.image = UIImage(named: "1lives.png")
        } else if (lives == 2){
            livesIcon.image = UIImage(named: "2lives.png")
        } else if (lives == 3){
            livesIcon.image = UIImage(named: "3lives.png")
        } else if (lives == 4){
            livesIcon.image = UIImage(named: "4lives.png")
        } else if (lives == 5){
            livesIcon.image = UIImage(named: "5lives.png")
        } else if (lives == 6){
            livesIcon.image = UIImage(named: "6lives.png")
        }
       
        seconds -= 1
        timer.text = "\(seconds)"
        if(seconds < 1){
            if(lives > 0){
                seconds = 30
                lives-=1
            } else {
            if(recordData == nil){
                let savedLevel = Int(level)
                let userDefaults = Foundation.UserDefaults.standard
                userDefaults.set(savedLevel, forKey: "Record")
            } else {
                score = Int(level)
                record = Int(recordData)
                
                if(score! > record!){
                    let savedLevel = Int(level)
                    let userDefaults = Foundation.UserDefaults.standard
                    userDefaults.set(savedLevel, forKey: "Record")
                }
            }
            if(pointsData == nil){
                let savedScore = Double(totalScore)
                let userDefaults/**/ = Foundation.UserDefaults.standard
                userDefaults/**/.set(savedScore, forKey: "Points")
            } else {
                let finalPoints = Double(totalScore)
                let finalP = Double(pointsData)
                /*let finalPoints: Double? = Double(totalScore)
                let finalP: Double? = Double(pointsData)*/
               
                if(score > record){
                
                  
                    let savedScore = Double(totalScore)
                    let userDefaults/**/ = Foundation.UserDefaults.standard
                    userDefaults/**/.set(savedScore, forKey: "Points")
                    
               
                } else if(score == record){
                    if(finalPoints >= finalP!){
                        let savedScore = Double(totalScore)
                        let userDefaults/**/ = Foundation.UserDefaults.standard
                        userDefaults/**/.set(savedScore, forKey: "Points")
                    }
                }
                    
                
            }
            
            
         
            
           // let vc = UIStoryboard(name: "main", bundle: nil).instantiateViewController(withIdentifier: "end") as! EndScreen
           //vc.scoreData = level
           // self.present(vc, animated: true, completion: nil)
            self.performSegue(withIdentifier: "EndScreen", sender:self)
            player.stop()
            
        }
    
    }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is EndScreen{
            let vc = segue.destination as? EndScreen
            vc?.scoreData = level
            vc?.pointsData = totalScore
        }
    }
  

    @IBAction func soundButton(_ sender: UISwitch) {
        if(soundSwitch.isOn){
            player.volume = 1
            
        } else {
            player.volume = 0
           
            
        }
    }
    @IBAction func effectButton(_ sender: UISwitch) {
        if(effectsSwitch.isOn){
            soundEffect.volume = 0.5
            correctSound.volume = 1
            wrongSound.volume = 1
            LevelUP.volume = 1
        } else {
            soundEffect.volume = 0
            correctSound.volume = 0
            wrongSound.volume = 0
            LevelUP.volume = 0
        }
    }
  
    



}

