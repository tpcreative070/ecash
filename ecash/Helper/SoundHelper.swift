//
//  SoundHelper.swift
//  ecash
//
//  Created by phong070 on 8/5/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
import AudioToolbox

enum SoundExtension : String{
    case caf
    case aif
    case wav
}
let  defauldSound = "default"

class SoundHelper: NSObject {
    static let shared =  SoundHelper()
    var notificationSoundLookupTable = [String: SystemSoundID]()
    
    func play(sound: String = defauldSound, ofType type: SoundExtension = .wav) {
        if let soundID = notificationSoundLookupTable[sound] {
            AudioServicesPlaySystemSound(soundID)
            return
            
        }
        if let soundURL : CFURL = Bundle.main.url(forResource: sound, withExtension: type.rawValue) as CFURL? {
            var soundID  : SystemSoundID = 0
            let osStatus : OSStatus = AudioServicesCreateSystemSoundID(soundURL, &soundID)
            if osStatus == kAudioServicesNoError {
                AudioServicesPlaySystemSound(soundID);
                notificationSoundLookupTable[sound] = (soundID)
            }
        }
    }
    
    func disposeSoundIDs() {
        for soundID in notificationSoundLookupTable.values {
            AudioServicesDisposeSystemSoundID(soundID)
        }
    }
    
    deinit {
        self.disposeSoundIDs()
    }
}
