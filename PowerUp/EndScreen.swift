//
//  EndScreen.swift
//  PowerUp
//
//  Created by David Kirsch on 3/26/18.
//  Copyright © 2018 David Kirsch. All rights reserved.
//

import UIKit

class EndScreen: UIViewController{
    
    

   
    @IBOutlet weak var pointsLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    var scoreData = 0
    var pointsData = 0.0
    
 
   

    @IBAction func EndBtn(_ sender: Any) {
        
        exit(0)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLbl.text = "\(scoreData)"
        pointsLbl.text = String(format: "%.1f", (pointsData))
       

        // Do any additional setup after loading the view.
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
