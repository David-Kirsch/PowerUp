//
//  StartScreen.swift
//  PowerUp
//
//  Created by David Kirsch on 3/26/18.
//  Copyright © 2018 David Kirsch. All rights reserved.
//

import UIKit
import UserNotifications

class StartScreen: UIViewController {

   
    @IBOutlet weak var highestPoints: UILabel!
    @IBOutlet weak var reset: UIButton!
    @IBOutlet weak var highestLevel: UILabel!
    
    @IBAction func notifier(_ sender: UIButton) {
  
        
        
        
        timedNotifications(inSeconds: 3600 * 30){ (success) in
            if success {
                print("Success")
            }
        }
    }
    
    
    
    func timedNotifications(inSeconds: TimeInterval, completion: @escaping(_ Success: Bool) ->()){
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: true)
        
        let content = UNMutableNotificationContent()
        
        content.title = "Breaking News!"
        content.subtitle = "It's not too late to save a life."
        content.body = "Save Byte city from the monsters that run through the city at night!"
    
        
        let request = UNNotificationRequest(identifier: "customNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                completion(false)
            } else {
                completion(true)
            }
        
        
            
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options:[.alert, .sound, .badge]) { (success, error) in
            if error != nil{
                print("Authorization Failed")
            } else {
                print("Authorization Successful")
            }
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userDefaults = Foundation.UserDefaults.standard
       // let userDefaults1 = Foundation.UserDefaults.standard
        let value = userDefaults.string(forKey: "Record")
        let points = userDefaults.string(forKey: "Points")
        
      
        if(value == nil){
            highestLevel.text = "0"
            
            
        } else {
            highestLevel.text = value
        }
        if(points == nil){
            highestPoints.text = "0.0"
        } else {
            highestPoints.text = points
        }
    }

    @IBAction func reset(_ sender: Any) {
        highestLevel.text = "0"
        highestPoints.text = "0.0"
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
        //highestLevel.text = "0"
    }
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
