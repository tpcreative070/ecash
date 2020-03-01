//
//  GlobalVariableHelper.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/25/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import AVFoundation
class PlaySoundManager  : NSObject{
    // MARK: - Singleton
    static let sharedInstance = PlaySoundManager()
    private var objPlayer : AVAudioPlayer?
    override init(){}
    func registationAudio(){
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
            print("Playback OK")
            try AVAudioSession.sharedInstance().setActive(true)
            print("Session is Active")
        } catch {
            print(error)
        }
        do {
            try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch _ {
        }
    }
    
    func playAudioFile(fileName : String,mRepeat : Int) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            objPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            guard let aPlayer = objPlayer.self else { return }
            aPlayer.volume = 50
            aPlayer.numberOfLoops = mRepeat
            aPlayer.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func stopPlayer(){
        if let play = objPlayer{
            play.stop()
            print("Stop play sound")
        }
        else{
            print("Player is nil")
        }
    }
}
