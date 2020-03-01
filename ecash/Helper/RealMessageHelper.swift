//
//  RealMessageHelper.swift
//  ecash
//
//  Created by phong070 on 11/20/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//
import Firebase
import FirebaseDatabase
class RealtimeMessageHelper {
    static let instance = RealtimeMessageHelper()
    func doInitKey(){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let mFirebase = ref.child("firebase_token")
        let mId = mFirebase.childByAutoId().key
        mFirebase.child(mId ?? "").setValue(FirebaseTokenRequestModel().dict)
    }
}
