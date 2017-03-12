//
//  ViewController.swift
//  SpeechRecognition
//
//  Created by Igor Lantushenko on 12/03/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    var sound: AVAudioPlayer!
    var path: URL!
    
    @IBOutlet weak var translatedText: UITextView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden  = true
        
        path = Bundle.main.url(forResource: "translate", withExtension: "mp3")
        
        do {
            try sound = AVAudioPlayer(contentsOf: path!)
            sound.prepareToPlay()
            sound.delegate = self
        } catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        sound.stop()
        spinner.stopAnimating()
        spinner.isHidden  = true
    }
    @IBAction func recognizeBtnClicked(_ sender: Any) {
        spinner.isHidden  = false
        spinner.startAnimating() 
        requestSpeechAuth()
    }
    
    func requestSpeechAuth() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                self.sound.play()
                
                let recognizer = SFSpeechRecognizer()
                let request =  SFSpeechURLRecognitionRequest(url: self.path)
                recognizer?.recognitionTask(with: request) { (result, error) in
                    if let error = error {
                        self.translatedText.text = "There was an error: \(error)"
                    } else {
                        self.translatedText.text = result?.bestTranscription.formattedString
                    }
                }
            }
        }
    }
    
    func speechResultHandler(result: SFSpeechRecognitionResult, error: Error?) {
        
        if let error = error {
            translatedText.text = "There was an error: \(error)"
        } else {
            translatedText.text = result.bestTranscription.formattedString
        }
        spinner.isHidden  = true
        
    }
}

