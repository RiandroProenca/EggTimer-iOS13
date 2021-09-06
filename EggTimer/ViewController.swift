//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    
    let eggTimes = ["Mole": 300,
                    "Medio": 420,
                    "Duro": 720]
    
    var totalTime = 0.0
    var secondsPass = 0.0
    var timer = Timer()
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        
        totalTime = Double(eggTimes[hardness]!)
        
        textLabel.text = hardness
        progressBar.progress = 0
        secondsPass = 0
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        if secondsPass <= totalTime {
            
            let porcentProgress = Float(secondsPass / totalTime)
            progressBar.progress = porcentProgress
            
            secondsPass += 1
        }
        else{
            timer.invalidate()
            textLabel.text = "Seu Ovo Esta Pronto!"
            playSound()
        }
    }
    
    func playSound (){
        DispatchQueue.main.asyncAfter(deadline: .now()) { [self] in
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
}
