//
//  RecordSoundsViewController+Audio.swift
//  PitchPerfect
//
//  Created by Justin Priday on 2017/09/22.
//  Copyright © 2017 Justin Priday. All rights reserved.
//

import UIKit
import AVFoundation

extension RecordSoundsViewController: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Recording was not successful")
        }
    }

}
