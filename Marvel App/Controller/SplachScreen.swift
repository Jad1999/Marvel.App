//
//  SplachScreen.swift
//  Marvel App
//
//  Created by Jad Ghoson on 08/12/2023.
//

import UIKit

class SplachScreen: UIViewController {

    
    
    @IBOutlet weak var loadingScreen: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingScreen.text = ""
        var charIndex = 0.0
        let titleText = "Loading..."
       
            for letter in titleText{
                Timer.scheduledTimer(withTimeInterval: 1.0 * charIndex , repeats: false){(timer) in
                    
                    self.loadingScreen.text?.append(letter)
                }
                charIndex += 1
                
            }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0 ){
            self.performSegue(withIdentifier: "OpenPage", sender: nil)
        }
    }
    



}
