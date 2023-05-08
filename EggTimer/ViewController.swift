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
    var player: AVAudioPlayer?
    
    let eggTimes = [ "Soft" : 3, "Medium" : 420, "Hard" : 720]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        player?.stop()
        progressBar.progress = 0.0
        secondsPassed = 0
        let hardness = sender.currentTitle!
        titleLabel.text = hardness
        
        totalTime = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            let persentageProggress = Float(secondsPassed) / Float(totalTime)
            progressBar.progress = persentageProggress
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            playSound()
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!, fileTypeHint: AVFileType.mp3.rawValue)
        player?.play()
    }
}
