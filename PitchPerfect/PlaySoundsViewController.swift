//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Justin Priday on 2017/09/21.
//  Copyright © 2017 Justin Priday. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var recordedAudioURL: URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: Any) {
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //avoid incorrect aspect ratio of button images in landscape.
        slowButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit;
        fastButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit;
        highPitchButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit;
        lowPitchButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit;
        echoButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit;
        reverbButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit;
        
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }

}
