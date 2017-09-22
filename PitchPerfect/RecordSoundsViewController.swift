//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Justin Priday on 2017/09/21.
//  Copyright © 2017 Justin Priday. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!

    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet var recordButtonHeight: NSLayoutConstraint!
    @IBOutlet var stopRecordingButtonHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Prevent incorrect aspect ratio in button images.
        recordButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        stopRecordingButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        setUI(recording: false, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func recordAudio(_ sender: Any) {
        setUI(recording: true, animated: true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath!)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        setUI(recording: false, animated: true)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func setUI(recording: Bool, animated: Bool) {
        //Sets up the user interface based on the recording parameter.
        //Since button layouts are altered and set up when views load the
        //animated parameter is required to determine whether the layout of
        //buttons should happen in an animation block or not.
        recordingLabel.text = (recording) ? "Recording In Progress" : "Tap To Record"
        recordButton.isEnabled = !recording
        stopRecordingButton.isEnabled = recording

        recordButtonHeight.isActive = recording
        stopRecordingButtonHeight.isActive = !recording
        
        if (animated) {
            UIView.animate(withDuration: 0.4, animations: {
                self.buttonStack.layoutIfNeeded();
            });
        } else {
            buttonStack.layoutIfNeeded()
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Recording was not successful")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }

}

