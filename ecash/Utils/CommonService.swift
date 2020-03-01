//
//  CommonService.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/25/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase
import BigInt
import ZXingObjC
class CommonService {
    
    static let isInput = true
    
    /**
     getConfigurationData
     */
    static func getConfigurationData() -> ConfigurationStoreModel? {
        if let saved = StorageHelper.getData(key: StorageKey.configData) {
            if let loaded = self.dataToObject(ConfigurationStoreModel.self, data: saved) {
                return loaded
            }
        }
        return nil
    }
    
    /**
     getBaseUrl
     */
    static func getBaseUrl() -> String {
        if let config = self.getConfigurationData() {
            return config.serverUrl
        }
        return ApiEndPointUrl.BaseUrl.infoForKey() ?? ""
    }
    
    /**
     getCurrentSessionId
     */
    static func getCurrentSessionId() -> String? {
        guard let data = CommonService.getSignInData() else {
            return "ldman12345679"
        }
        return data.sessionId ?? ""
    }
    
    /**
     getAccessToken
     */
    static func getAccessToken() -> String{
        guard let value = CommonService.getSignInData() else{
            return ""
        }
        return value.sessionId?.description ?? ""
    }
    
    /**
     getCurrentUserId
     */
    static func getCurrentUserId() -> Int {
        return 0
    }
    
    /*
     getUsername
     */
    static func getUsername() -> String? {
        guard let value = CommonService.getSignInData() else{
            return nil
        }
        return value.username
    }
    
    /*
     get current sign up username
     */
    static func getCurrentSignUpUsername() -> String? {
        guard let value = CommonService.getSignUpStoreData() else{
            return nil
        }
        return value.username
    }
    
    /** Decode data to Object
     */
    static func dataToObject<T : Decodable>(_ type: T.Type, data : Data) -> T? {
        let decoder = JSONDecoder()
        if let loaded = try? decoder.decode(type, from: data) {
            return loaded
        }
        return nil
    }
    
    /** Decode data to Object(Callback)
     */
    static func dataToObject<T : Decodable>(_ type: T.Type, data : Data,callBack : () -> (Void)){
        let decoder = JSONDecoder()
        if let _ = try? decoder.decode(type, from: data) {
            callBack()
        }
    }
    
    /** Decode data to Object
     */
    static func objectToData<T : Encodable>(_ data: T ) -> Data? {
        let encoder = JSONEncoder()
        if let loaded = try? encoder.encode(data) {
            return loaded
        }
        return nil
    }
    
    /**
     setConfigurationData
     */
    static func setConfigurationData(configuration: ConfigurationStoreModel) {
        if let encoded = self.objectToData(configuration) {
            StorageHelper.setObject(key: StorageKey.configData, value: encoded)
        }
    }
    
    /**
     getUserData
     */
    static func getSignInData() -> SignInStoreModel? {
        if let saved = StorageHelper.getData(key: StorageKey.signInData) {
            if let loaded = self.dataToObject(SignInStoreModel.self, data: saved) {
                return loaded
            }
        }
        return nil
    }
    
    /**
     setUserData
     */
    static func setSignInData(storeInfo: SignInStoreModel) {
        if let encoded = self.objectToData(storeInfo) {
            StorageHelper.setObject(key: StorageKey.signInData, value: encoded)
        }
    }
    
    /**
     getAlreadyStore
     */
    static func getIsAlreadyStore() -> Bool? {
        return StorageHelper.getBool(key: StorageKey.isAlreadyStore)
    }
    
    /**
     setStore
     */
    static func setIsAlreadyStore(value : Bool) {
        StorageHelper.setObject(key: StorageKey.isAlreadyStore, value:value)
    }
    
    /**
       getAlreadyStore
    */
    static func getIsNewApp() -> Bool? {
        return StorageHelper.getBool(key: StorageKey.newApp)
    }
       
    /**
    setStore
    */
    static func setIsNewApp(value : Bool) {
        StorageHelper.setObject(key: StorageKey.newApp, value:value)
    }
       
    /**
     geteDongStoreData
     */
    static func geteDongStoreData() -> eDongStoreModel? {
        if let saved = StorageHelper.getData(key: StorageKey.eDongInfoData) {
            if let loaded = self.dataToObject(eDongStoreModel.self, data: saved) {
                return loaded
            }
        }
        return nil
    }
    
    /**
     seteDongStoreData
     */
    static func seteDongStoreData(storeInfo: eDongStoreModel) {
        if let encoded = self.objectToData(storeInfo) {
            StorageHelper.setObject(key: StorageKey.eDongInfoData, value: encoded)
        }
    }
    
    /**
     getMasterKey
     */
    static func getMasterKey() -> String?{
        let keychain = KeychainSwiftHelper()
        if let saved = keychain.get(StorageKey.masterkey){
            return saved
        }
        return nil
    }
    
    /**
     setMasterKey
     */
    static func setMasterKey(data : String){
        let keychain = KeychainSwiftHelper()
        keychain.set(data, forKey: StorageKey.masterkey)
    }
    
    /**
    getLastAccessTime
    */
    static func getLastAccessTimeKey() -> String?{
        let keychain = KeychainSwiftHelper()
        if let saved = keychain.get(StorageKey.lastAccessTime){
            return saved
        }
        return nil
    }
       
    /**
    setLastAccessTime
    */
    static func setLastAccessTimeKey(data : String){
        let keychain = KeychainSwiftHelper()
        keychain.set(data, forKey: StorageKey.lastAccessTime)
    }
    
    /**
    setMasterKey
    */
    static func setFirstCreatedKeyChain(data : String){
        let keychain = KeychainSwiftHelper()
        keychain.set(data, forKey: StorageKey.firstCreatedKeyChain)
    }
    
    /**
    getFirstCreatedKeyChain
    */
    static func getFirstKeyChain() -> String?{
         let keychain = KeychainSwiftHelper()
         if let saved = keychain.get(StorageKey.firstCreatedKeyChain){
             return saved
         }
         return nil
     }
     
    /**
     getChannel public key
     */
    static func getChannelPublicKey() -> String?{
        let keychain = KeychainSwiftHelper()
        if let saved = keychain.get(StorageKey.channelPublicKey){
            return saved
        }
        return nil
    }
    
    /**
     setChannel public key
     */
    static func setChannelPublicKey(data : String){
        let keychain = KeychainSwiftHelper()
        keychain.set(data, forKey: StorageKey.channelPublicKey)
    }
    
    
    /**
     get client public key
     */
    static func getClientPublicKey() -> String?{
        if let mData = CommonService.getKeychainFirebaseData(){
            return mData.clientKp ?? ""
        }
        return nil
    }
    
    /**
     get client public key
     */
    static func getClientSecretKey() -> String?{
        if let mData = CommonService.getKeychainFirebaseData(){
            return mData.clientKs ?? ""
        }
        return nil
    }
    
    
    /**
     setKeyChainDevice
     */
    static func setKeychainData(storeInfo: KeychainDeviceStoreModel) {
        let keychain = KeychainSwiftHelper()
        if let encoded = self.objectToData(storeInfo) {
            keychain.set(encoded, forKey: StorageKey.keychain)
        }
    }
    
    /**
     getKeychainDevice
     */
    static func getKeychainData() -> KeychainDeviceStoreModel? {
        let keychain = KeychainSwiftHelper()
        if let saved = keychain.getData(StorageKey.keychain) {
            if let loaded = self.dataToObject(KeychainDeviceStoreModel.self, data: saved) {
                return loaded
            }
        }
        return nil
    }
    
    
    /**
     setKeyChainFirebase
     */
    static func setKeychainFirebaseData(storeInfo: KeychainFirebaseStoreModel) {
        let keychain = KeychainSwiftHelper()
        if let encoded = self.objectToData(storeInfo) {
            keychain.set(encoded, forKey: StorageKey.keychainFirebase)
        }
    }
    
    /**
     getKeychainFirebase
     */
    static func getKeychainFirebaseData() -> KeychainFirebaseStoreModel? {
        let keychain = KeychainSwiftHelper()
        if let saved = keychain.getData(StorageKey.keychainFirebase) {
            if let loaded = self.dataToObject(KeychainFirebaseStoreModel.self, data: saved) {
                return loaded
            }
        }
        return nil
    }
    
    /**
     setKeyChainDevice
     */
    static func setDeviceIdToKeyChain(value: String) {
        let keychain = KeychainSwiftHelper()
        keychain.set(value, forKey: StorageKey.deviceId)
    }
    
    
    /**
     getKeychain
     */
    static func getDeviceIdToKeyChain() -> String? {
        let keychain = KeychainSwiftHelper()
        if let saved = keychain.get(StorageKey.deviceId){
            return saved
        }
        return nil
    }
    
    /**
     getSignUp
     */
    static func getSignUpStoreData() -> SignUpStoreModel? {
        if let saved = StorageHelper.getData(key: StorageKey.signupData) {
            if let loaded = self.dataToObject(SignUpStoreModel.self, data: saved) {
                return loaded
            }
        }
        return nil
    }
    
    /**
     setSignUp
     */
    static func setSignUpData(storeInfo: SignUpStoreModel) {
        if let encoded = self.objectToData(storeInfo) {
            StorageHelper.setObject(key: StorageKey.signupData, value: encoded)
        }
    }
    
    /**
     getActiveAccount
     */
    static func getActiveAccountStoreData() -> ActiveAccountStoreModel? {
        if let saved = StorageHelper.getData(key: StorageKey.activeAccountData) {
            if let loaded = self.dataToObject(ActiveAccountStoreModel.self, data: saved) {
                return loaded
            }
        }
        return nil
    }
    
    /**
     setActiveAccount
     */
    static func setActiveAccountData(storeInfo: ActiveAccountStoreModel) {
        if let encoded = self.objectToData(storeInfo) {
            StorageHelper.setObject(key: StorageKey.activeAccountData, value: encoded)
        }
    }
    
    /*Generate Unique Id*/
    static func getUniqueId() -> String {
        if let mDeviceId = getDeviceIdToKeyChain(){
            return mDeviceId
        }else{
            guard let id = UIDevice.current.identifierForVendor?.uuidString else {
                guard let mSignUpData = getSignUpStoreData() else {
                    return "ADFSDS123"
                }
                let mId = "ADFSDS123\(mSignUpData.walletId?.description ?? "")"
                setDeviceIdToKeyChain(value: mId)
                return mId
            }
            setDeviceIdToKeyChain(value: id)
            return id
        }
    }
    
    /**
     Fetch device's info
     */
    static func getDeviceInfo() -> String{
        let device = UIDevice.current
        return device.type.rawValue
    }
    
    /*Current wallet Id*/
    static func getWalletId() ->String?{
        guard let mData = CommonService.getSignUpStoreData() else {
            return nil
        }
        return mData.walletId?.description
    }
    
    static func getPhoneNumber() -> String?{
        guard let mData = CommonService.getSignUpStoreData() else {
            return nil
        }
        return mData.personMobilePhone
    }
    
    static func getMediumAvatar() -> String?{
        guard let mData = CommonService.getSignInData() else {
               return nil
        }
        guard let mMedium =   mData.medium else {
            return nil
        }
        if mMedium != ""{
            return mMedium
        }
        return nil
    }
    
    static func getLargeAvatar() -> String?{
         guard let mData = CommonService.getSignInData() else {
                return nil
         }
         guard let mLarge =   mData.large else {
             return nil
         }
         if mLarge != ""{
             return mLarge
         }
         return nil
    }
       
    static func getIdNumber() -> String?{
        guard let mData = CommonService.getSignUpStoreData() else {
            return nil
        }
        return mData.idNumber
    }
    
    static func signOutGlobal(){
        CommonService.setSignInData(storeInfo: SignInStoreModel())
        GIDSignIn.sharedInstance()?.signOut()
    }
    
    static func deleteAccount(){
        CommonService.setSignUpData(storeInfo: SignUpStoreModel())
    }
    
    /*Generate Random Alphanumber String*/
    static func getRandomAlphaNumericString(length: Int) -> String {
        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let allowedCharsCount = UInt32(allowedChars.count)
        var randomString = ""
        for _ in 0..<length {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
            let newCharacter = allowedChars[randomIndex]
            randomString += String(newCharacter)
        }
        return randomString
    }
    
    static func getRandomAlphaNumericInt(length: Int) -> String {
        let allowedChars = "123456789"
        let allowedCharsCount = UInt32(allowedChars.count)
        var randomString = ""
        for _ in 0..<length {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
            let newCharacter = allowedChars[randomIndex]
            randomString += String(newCharacter)
        }
        return randomString
    }
    
    //create imageName
    static func createFileName() -> String {
        let userId = CommonService.getSignInData()?.customerId?.description ?? ""
        let t = Date().timeIntervalSince1970
        return "\(userId)_\(t).jpg"
    }
    
    /*getEncode data(Elliptic)*/
    static func getEncode(ecpoint: ProjectivePoint<WeierstrassCurve<NaivePrimeField<U256>>>) -> Data {
        var bytesX = ecpoint.toAffine().X.bytes
        let bytesY = ecpoint.toAffine().Y.bytes
        var PO = bytesX[0..<bytesX.count]
        PO.append(bytesY)
        return PO
    }
    
    /*getDecode data(Elliptic)*/
    static func getDecode(data: Data) -> AffinePoint<WeierstrassCurve<NaivePrimeField<U256>>> {
        let POX = data[0..<data.count/2]
        let POY = data[data.count/2..<data.count]
        let X = BigUInt(POX)
        let Y = BigUInt(POY)
        let ecpoint = secp256k1Curve.toPoint(X, Y)
        return ecpoint!
    }
    
    /*getData from pont of ellipic*/
    static func getECPointfromPublicKey(data: Data) -> AffinePoint<WeierstrassCurve<NaivePrimeField<U256>>> {
        let POX = data[1..<data.count/2 + 1]
        let POY = data[data.count/2 + 1..<data.count]
        let X = BigUInt(POX)
        let Y = BigUInt(POY)
        let ecpoint = secp256k1Curve.toPoint(X, Y)
        return ecpoint!
    }
    
    /*setCipherKey*/
    static func setCipherKey(value : String){
        StorageHelper.setObject(key: StorageKey.cipherKey, value: value)
    }
    
    /*getcipherKey*/
    static func getCipherKey() -> String?{
        guard let value = StorageHelper.getString(key: StorageKey.cipherKey, defaultValue: "") else{
            return nil
        }
        return value
    }
    
    /*Get value from [String]*/
    static func getValueFromArray(data : [String],insert : String) ->String?{
        if data.count == 3{
            let m1 = data[0]
            let m2 = data[1]
            let enc = data[2]
            let result = "\(m1)\(insert)\(m2)\(insert)\(enc)"
            return result
        }
        return nil
    }
    
    /**
     Alert Message
     */
    static func isAlertMessageUsername(code : String) -> Bool{
        if code != EnumResponseCode.USER_IS_NOT_EXISTED.rawValue {
            return true
        }
        return false
    }
    
    /**
     Preparing web socket
     */
    static func websocketURL() -> URLComponents{
        let channelCode = "MB001"
        let funcCode = EnumFunctionName.WEB_SOCKET.rawValue
        let path = "/sync"
        guard let signUpData = CommonService.getSignUpStoreData() else{
            return URLComponents(string: "")!
        }
        guard let signInData = CommonService.getSignInData() else {
            return URLComponents(string: "")!
        }
        let terminalInfo = signUpData.terminalInfo ?? ""
        let auditNumber = CommonService.getRandomAlphaNumericInt(length: 15)
        let alphobelCodeWallet = "\(signUpData.terminalId ?? "")\(terminalInfo)\(signUpData.walletId?.description ?? "")"
        debugPrint(alphobelCodeWallet)
        let walletSignature = ELGamalHelper.instance.signatureWallet(data: alphobelCodeWallet.sha256Data()) ?? ""
        debugPrint("walletSignature \(walletSignature)")
        let alphobelCodeChannel =  "\(auditNumber)\(channelCode)\(funcCode)\(signInData.sessionId ?? "")\(signUpData.terminalId ?? "")\(terminalInfo)\(signUpData.username ?? "")\(signUpData.walletId?.description ?? "")"
        debugPrint(alphobelCodeChannel)
        let channelSignature = ELGamalHelper.instance.signatureChannel(data: alphobelCodeChannel.sha256Data()) ?? ""
        
        debugPrint("channelSignature \(channelSignature)")
        
        //        var urlComponents: URLComponents {
        //            var components = URLComponents(string: ConfigKey.WSUrl.infoForKey() ?? "")!
        //            components.path = path
        //            components.queryItems  = [
        //                URLQueryItem(name: "auditNumber", value: auditNumber.description),
        //                URLQueryItem(name: "channelCode", value: channelCode),
        //                URLQueryItem(name: "channelSignature", value: channelSignature),
        //                URLQueryItem(name: "functionCode", value: funcCode),
        //                URLQueryItem(name: "sessionId", value: signInData.sessionId ?? ""),
        //                URLQueryItem(name: "terminalId", value:  signUpData.terminalId ?? ""),
        //                URLQueryItem(name: "terminalInfo", value: terminalInfo),
        //                URLQueryItem(name: "username", value: signUpData.username ?? ""),
        //                URLQueryItem(name: "waletId", value: signUpData.walletId?.description ?? ""),
        //                URLQueryItem(name: "walletSignature", value: walletSignature)]
        //            return components
        //        }
        
        let queryParams: [String: String] = [
            "auditNumber" : auditNumber.description,
            "channelCode" : channelCode,
            "channelSignature" : channelSignature,
            "functionCode" : funcCode,
            "sessionId" : signInData.sessionId ?? "",
            "terminalId" :  signUpData.terminalId ?? "",
            "terminalInfo" : terminalInfo,
            "username" : signUpData.username ?? "",
            "waletId" : signUpData.walletId?.description ?? "",
            "walletSignature" : walletSignature]
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "ws"
        urlComponents.host = "10.10.32.102"
        urlComponents.path = path
        urlComponents.port = 8010
        urlComponents.setQueryItems(with: queryParams)
        return urlComponents
    }
    
    /**
     Preparing web socket
     */
    static func websocketURLString() ->String {
        let channelCode = EnumChannelName.MB001.rawValue
        let funcCode = EnumFunctionName.WEB_SOCKET.rawValue
        guard let signUpData = CommonService.getSignUpStoreData() else{
            debugPrint("Break here.........")
            return ConfigKey.WSUrl.infoForKey() ?? ""
        }
    
        guard let _ = signUpData.walletId else {
             return ConfigKey.WSUrl.infoForKey() ?? ""
        }
        
        guard let signInData = CommonService.getSignInData() else {
            debugPrint("Break here.........@@@")
            return ConfigKey.WSUrl.infoForKey() ?? ""
        }
        let terminalInfo = CommonService.getDeviceInfo()
        let terminalId  = CommonService.getUniqueId()
        debugPrint(terminalInfo)
        let auditNumber = CommonService.getRandomAlphaNumericInt(length: 15)
        let alphobelCodeWallet = "\(CommonService.getUniqueId())\(terminalInfo)\(signUpData.walletId?.description ?? "")"
        debugPrint(alphobelCodeWallet)
        let walletSignature = ELGamalHelper.instance.signatureWallet(data: alphobelCodeWallet.sha256Data()) ?? ""
        debugPrint("walletSignature \(walletSignature)")
        let alphobelCodeChannel =  "\(auditNumber)\(channelCode)\(funcCode)\(signInData.sessionId ?? "")\(terminalId)\(terminalInfo)\(signInData.token ?? "")\(signUpData.username ?? "")\(signUpData.walletId?.description ?? "")"
        debugPrint(alphobelCodeChannel)
        let channelSignature = ELGamalHelper.instance.signatureChannel(data: alphobelCodeChannel.sha256Data()) ?? ""
        
        debugPrint("channelSignature \(channelSignature)")
        let allowedCharacterSet = (CharacterSet(charactersIn: "\"!*'();:@&=+$,/?%#[] ").inverted)
        let url = "\(ConfigKey.WSUrl.infoForKey() ?? "")?auditNumber=\(auditNumber.description)&channelCode=\(channelCode)&channelSignature=\(channelSignature.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? "")&functionCode=\(funcCode)&sessionId=\(signInData.sessionId ?? "")&terminalId=\(signInData.terminalId ?? "")&terminalInfo=\(terminalInfo.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? "")&token=\(signInData.token?.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? "")&username=\(signInData.username ?? "")&walletId=\(signUpData.walletId?.description ?? "")&walletSignature=\(walletSignature.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? "")"
        debugPrint("url \(url)")
        return url
    }
    
    /**
     Checking already signed in
     */
    static func isSigined() -> Bool{
        guard let data = CommonService.getSignInData() else {
            return false
        }
        if data.username == nil || data.username == "" {
            return false
        }
        return true
    }
    
    /**
        Getting password
       */
    static func gettingPassword() -> String{
          guard let data = CommonService.getSignInData() else {
              return ""
          }
        
          if let mData = data.token{
             return mData
          }
          return ""
    }
    
    /**
     Empty sign in
     */
    static func isFirstInitialized() -> Bool{
        guard let data = CommonService.getSignUpStoreData() else {
            return true
        }
        if data.username == nil || data.username == "" {
            return true
        }
        return false
    }
    
    /**
     Getting private key
     */
    static func getPrivateKey() -> String?{
        guard let key = CommonService.getKeychainData() else {
            debugPrint("Not found private key")
            return nil
        }
        return key.privateKey
    }
    
    /**
     Getting public key
     */
    static func getPublicKey() -> String?{
        guard let key = CommonService.getKeychainData() else {
            debugPrint("Not found public key")
            return nil
        }
        return key.publicKey
    }
    
    /**
     Hande eCash from api
     */
    
    /*
     TuanLe added 4/2/2020
     This function validate all of record Transactions Logsto make sure that it is not modified by user
     Return true -> everything is OK
     **/
    static func checkTransactionsLogs()->Bool{
        var previousRecord: TransactionsLogsEntityModel
        var mPreviousHash: String
        var isValid = true
        guard let mList = SQLHelper.getListAllTransactionsLogs() else{
            return false
        }
        
        for i in 0...mList.count - 1 {
            if(i == 0){//first record
                previousRecord = mList.last!
                mPreviousHash =  TransactionsLogsEntityModel.caculatePreviousHash(previousRecord)(transactionsLogs: previousRecord)
            }else{
                previousRecord = mList[i-1]
                mPreviousHash =  TransactionsLogsEntityModel.caculatePreviousHash(previousRecord)(transactionsLogs: previousRecord)
            }
            
            if(!(mList[i].previousHash?.compare(mPreviousHash) == .orderedSame) ){
                isValid = false
                break;
            }
            
        }
        return isValid
    }
    
    static func UpdateBlockChains(){
        /*Remember removing note log when eCash go live*/
        //let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        //if( appVersion?.compare("2.8") == .orderedSame || appVersion?.compare("2.9") == .orderedSame || appVersion?.compare("3.0") == .orderedSame || appVersion?.compare("3.1") == .orderedSame){
            UpdateTransactionsLogs()
            UpdateCashLogs()
        //}
    }
    
    static func UpdateTransactionsLogs(){
        var previousRecord: TransactionsLogsEntityModel
        var mPreviousHash: String
        //Update Transaction
        guard let mListTransaction = SQLHelper.getListAllTransactionsLogs() else{
            return
        }
        
        for i in 0...mListTransaction.count - 1 {
            if(i == 0){//first record
                previousRecord = mListTransaction.last!
                mPreviousHash =  TransactionsLogsEntityModel.caculatePreviousHash(previousRecord)(transactionsLogs: previousRecord)
            }else{
                previousRecord = mListTransaction[i-1]
                mPreviousHash =  TransactionsLogsEntityModel.caculatePreviousHash(previousRecord)(transactionsLogs: previousRecord)
            }
            let mId = mListTransaction[i].id ?? 0
            SQLHelper.updatedTransactionsLogs(id: mId , previousHash: mPreviousHash)
        }
    }
    
    static func UpdateCashLogs(){
        var previousRecord: CashLogsEntityModel
        var mPreviousHash: String
        guard let mList = SQLHelper.getListAllCashLogs() else{
            return
        }
        for i in 0...mList.count - 1 {
            if(i == 0){//first record
                previousRecord = mList.last!
                mPreviousHash =  CashLogsEntityModel.caculatePreviousHash(previousRecord)(cashLogs: previousRecord)!
            }else{
                previousRecord = mList[i-1]
                mPreviousHash =  CashLogsEntityModel.caculatePreviousHash(previousRecord)(cashLogs: previousRecord)!
            }
            let mId = mList[i].id ?? 0
            SQLHelper.updatedCashLogs(id: mId , previousHash: mPreviousHash)
        }
    }
    
    /*Handle transactions log*/
    static func handleTransactionsLogs(transferData : TransferDataModel, completion: @escaping (_ result: TransactionsModel)->()){
        debugPrint("transactions id \(transferData.id ?? "")")
        var transactionsLogs : TransactionsLogsEntityModel!
        if let mTransferExisting = SQLHelper.getLatestTransactionsLogs(){
            transactionsLogs = TransactionsLogsEntityModel(data: transferData,dataExisting: mTransferExisting)
            debugPrint("Exsiting value.......")
            if (SQLHelper.insertedTransactionLogs(data: transactionsLogs)){
                if let mFirstData = SQLHelper.getFirstRowTransactionsLogs(){
                    let mId = mFirstData.id ?? 0
                    let mPreviousHash =  TransactionsLogsEntityModel.caculatePreviousHash(transactionsLogs)(transactionsLogs: transactionsLogs)
                    SQLHelper.updatedTransactionsLogs(id: mId , previousHash: mPreviousHash)
                    //let aaa = checkTransactionsLogs()
                }
                let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.TRANSACTIONS_LOGS.rawValue , handleAction: EnumTransactionsAction.INSERT_TRANSACTION_SUCCESS.rawValue,transferData : transferData)
                completion(mTransactionModel)
            }
        }else{
            debugPrint("Not exsiting value.......")
            transactionsLogs = TransactionsLogsEntityModel(data: transferData,dataExisting: nil)
            if (SQLHelper.insertedTransactionLogs(data: transactionsLogs)){
                let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.TRANSACTIONS_LOGS.rawValue , handleAction: EnumTransactionsAction.INSERT_TRANSACTION_SUCCESS.rawValue,transferData : transferData)
                completion(mTransactionModel)
                debugPrint("Inserted transactions successfully")
            }
        }
    }
    
    /*
     TuanLe added 4/2/2020
     This function validate all of records Cash Logs to make sure that it is not modified by user
     Return true -> everything is OK
     **/
    static func checkCashLogs()->Bool{
        var previousRecord: CashLogsEntityModel
        var mPreviousHash: String
        var isValid = true
        guard let mList = SQLHelper.getListAllCashLogs() else{
            return false
        }
        
        for i in 0...mList.count - 1 {
            if(i == 0){//first record
                previousRecord = mList.last!
                mPreviousHash =  CashLogsEntityModel.caculatePreviousHash(previousRecord)(cashLogs: previousRecord)!
            }else{
                previousRecord = mList[i-1]
                mPreviousHash =  CashLogsEntityModel.caculatePreviousHash(previousRecord)(cashLogs: previousRecord)!
            }
            
            if(!(mList[i].previousHash?.compare(mPreviousHash) == .orderedSame) ){
                isValid = false
                break;
            }
            
        }
        return isValid
    }
    
    /*
     Getting count of list
     **/
    
    static func checkCountCash() -> Bool {
        guard let mList = SQLHelper.getListAllCashLogs() else{
            return false
        }
        if mList.count > 0 {
            return true
        }
        return false
    }
    
    /*Handle cash logs temporary*/
    static func handCashLogs(transferData : TransferDataModel,completion: @escaping (_ result: TransactionsModel)->()){
        let data = transferData.cashEnc?.stringToArray(separatedBy: "$")
        guard let moneyEncrypted = data else {
            return
        }
        debugPrint(moneyEncrypted)
        let decryptedData = ELGamalHelper.instance.decryptedPackage(receiverPrivateKey: CommonService.getPrivateKey() ?? "", encData: moneyEncrypted)
        debugPrint("Count decrypted \(decryptedData.count)")
        var mCount = 0
        decryptedData.forEach { value in
           
            let transferValue = CashEncModel(dataPackage: value,transactionSignature: transferData.id ?? "")
            var cashLogs : CashLogsEntityModel!
            if let eCashExisting = SQLHelper.getLatestCashLogs(){
                cashLogs = CashLogsEntityModel(data: transferValue, inputOutput: CommonService.isInput,dataExisting: eCashExisting)
                debugPrint("Exsiting value.......")
                if (SQLHelper.allowInput(mSerial: cashLogs.serial ?? 0) && SQLHelper.insertedCashLogs(data: cashLogs)){
                    if let mFirstData = SQLHelper.getFirstRowCashLogs(){
                        let mId = mFirstData.id ?? 0
                        let mPreviousHash =  CashLogsEntityModel.caculatePreviousHash(cashLogs)(cashLogs: cashLogs)!
                        SQLHelper.updatedCashLogs(id: mId , previousHash: mPreviousHash)
                        
                        //let aaa = checkCashLogs()
                    }
                    let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.CASH_LOGS.rawValue , handleAction: EnumTransactionsAction.INSERT_CASH_LOGS_SUCCESS.rawValue)
                    completion(mTransactionModel)
                }
            }else{
                debugPrint("Not exsiting value.......")
                cashLogs = CashLogsEntityModel(data: transferValue, inputOutput: CommonService.isInput,dataExisting: nil)
                if (SQLHelper.allowInput(mSerial: cashLogs.serial ?? 0) && SQLHelper.insertedCashLogs(data: cashLogs)){
                    debugPrint("Inserted cash successfully")
                    let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.CASH_LOGS.rawValue , handleAction: EnumTransactionsAction.INSERT_CASH_LOGS_SUCCESS.rawValue)
                    completion(mTransactionModel)
                }
            }
            mCount = mCount + 1
            if mCount == decryptedData.count {
                let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.CASH_LOGS.rawValue , handleAction: EnumTransactionsAction.INSERT_CASH_LOGS_COMPLETED.rawValue)
                                  completion(mTransactionModel)
            }
            debugPrint("Serial handCashLogs....\(transferValue.serialNo ?? "")")
        }
    }
    
    /*Handle transactions log*/
    static func handleTransactionsLogsOutput(transferData : TransferDataModel,completion: @escaping (_ result: TransactionsModel)->()){
        debugPrint("transactions id \(transferData.id ?? "")")
        var transactionsLogs : TransactionsLogsEntityModel!
        if let mTransferExisting = SQLHelper.getLatestTransactionsLogs(){
            transactionsLogs = TransactionsLogsEntityModel(data: transferData,dataExisting: mTransferExisting)
            debugPrint("Exsiting value.......")
            if (SQLHelper.insertedTransactionLogs(data: transactionsLogs)){
                if let mFirstData = SQLHelper.getFirstRowTransactionsLogs(){
                    let mId = mFirstData.id ?? 0
                    let mPreviousHash =  TransactionsLogsEntityModel.caculatePreviousHash(transactionsLogs)(transactionsLogs: transactionsLogs)
                    SQLHelper.updatedTransactionsLogs(id: mId , previousHash: mPreviousHash)
                }
                let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.TRANSACTIONS_LOGS.rawValue , handleAction: EnumTransactionsAction.INSERT_TRANSACTION_SUCCESS.rawValue,transferData : transferData)
                completion(mTransactionModel)
            }
        }else{
            debugPrint("Not exsiting value.......")
            transactionsLogs = TransactionsLogsEntityModel(data: transferData,dataExisting: nil)
            if (SQLHelper.insertedTransactionLogs(data: transactionsLogs)){
                let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.TRANSACTIONS_LOGS.rawValue , handleAction: EnumTransactionsAction.INSERT_TRANSACTION_SUCCESS.rawValue,transferData : transferData)
                completion(mTransactionModel)
                debugPrint("Inserted transactions successfully")
            }
        }
    }
    
    /*Handle cash logs*/
    static func handCashLogsOutput(mTransferData : TransferDataModel ,completion: @escaping (_ result: TransactionsModel)->()){
        let data = mTransferData.cashEnc?.stringToArray(separatedBy: "$")
        guard let moneyEncrypted = data else {
            return
        }
        debugPrint(moneyEncrypted)
        let decryptedData = ELGamalHelper.instance.decryptedPackage(receiverPrivateKey: CommonService.getPrivateKey() ?? "", encData: moneyEncrypted)
        debugPrint("Count decrypted \(decryptedData.count)")
        var mCount = 0
        decryptedData.forEach { value in
            let transferValue = CashEncModel(dataPackage: value,transactionSignature: mTransferData.id ?? "")
            var cashLogs : CashLogsEntityModel!
            if let eCashExisting = SQLHelper.getLatestCashLogs(){
                cashLogs = CashLogsEntityModel(data: transferValue, inputOutput: !CommonService.isInput,dataExisting: eCashExisting)
                debugPrint("Exsiting value.......")
                if (SQLHelper.allowOutput(mSerial: cashLogs.serial ?? 0) && SQLHelper.insertedCashLogs(data: cashLogs)){
                    if let mFirstData = SQLHelper.getFirstRowCashLogs(){
                        let mId = mFirstData.id ?? 0
                        let mPreviousHash =  CashLogsEntityModel.caculatePreviousHash(cashLogs)(cashLogs: cashLogs)!
                        SQLHelper.updatedCashLogs(id: mId , previousHash: mPreviousHash)
                    }
                }
            }else{
                debugPrint("Not exsiting value.......")
                cashLogs = CashLogsEntityModel(data: transferValue, inputOutput: !CommonService.isInput,dataExisting: nil)
                if (SQLHelper.allowOutput(mSerial: cashLogs.serial ?? 0) && SQLHelper.insertedCashLogs(data: cashLogs)){
                    debugPrint("Inserted cash successfully")
                }
            }
            mCount += 1
            debugPrint("Serial handCashLogsOutput....\(transferValue.serialNo ?? "")")
            if mCount == decryptedData.count{
                let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.CASH_LOGS.rawValue , handleAction: EnumTransactionsAction.INSERT_CASH_LOGS_SUCCESS.rawValue)
                completion(mTransactionModel)
            }
        }
    }
    
    /*Update UI*/
    static func bindingData(){
        ShareSingleton.shared.set(value: PassDataViewModel(identifier: EnumPassdata.NAVIGATION, navigation: NavigationData(codeAction: EnumResponseAction.TRANSACTION.rawValue)))
        ShareSingleton.shared.bindData()
    }
    
    /*PushValue*/
    static func eventPushViewController(isScanner : Bool, transactionId: String){
        SwiftEventBusHelper.post(ConfigKey.RequestUpdateeDong)
        if isScanner {
            SwiftEventBusHelper.post(ConfigKey.RequestQRCodeResult, sender: ReceiveQRCodeData(transactionsId: transactionId))
        }
    }
    
    /*SaveToPhoto*/
    static func eventPushSaveToPhoto(value : String){
        SwiftEventBusHelper.post(ConfigKey.RequestSaveToPhotos,sender: value)
    }
    
    /*Common event push*/
    static func commonEventPush(event : String){
        SwiftEventBusHelper.post(event)
    }
      
    /*Update Home UI*/
    static func bindingHomeData(isUpdate : Bool? = false ){
        ShareHomeSingleton.shared.set(value: PassDataViewModel(identifier: EnumPassdata.NAVIGATION, navigation: NavigationData(codeAction: isUpdate ?? false ? EnumResponseAction.UPDATE.rawValue : EnumResponseAction.TRANSACTION.rawValue)))
        ShareHomeSingleton.shared.bindData()
    }
    
    static func bindingHomeData(action : EnumResponseAction){
        ShareHomeSingleton.shared.set(value: PassDataViewModel(identifier: EnumPassdata.NAVIGATION, navigation: NavigationData(codeAction: action.rawValue)))
        ShareHomeSingleton.shared.bindData()
    }
    
    /*Push To ScannerResult*/
    static func sendIntentToScannerResult(data :  ReceiveQRCodeData){
        ShareTransactionSingleton.shared.set(value: PassDataViewModel(identifier: EnumPassdata.SCANNER_RESULT, receiveQRCodeData: data))
    }
    
    /*Get result*/
    static func getShareScannerResult() -> ReceiveQRCodeData?{
        if let mData = ShareTransactionSingleton.shared.get(value: PassDataViewModel.self){
            if mData.identifier == EnumPassdata.SCANNER_RESULT.rawValue {
                let mQRCode = mData.receiveQRCodeData
                if let _ = mQRCode.transactionsId {
                    return mQRCode
                }
            }
        }
        return nil
    }
    
    /**
     getting current milliseconds
     */
    static func getCurrentMillis()->Int64 {
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
    
    /**
     push notification
     */
    static func localPush(message : String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.alertRemoteNotification(notification: message)
    }
    
    /**
     Get name file of qrcode
     */
    static func getGenerateQRCode(count : Int ,transactionId : String) -> String?{
        guard let mSignUp = CommonService.getSignUpStoreData() else {
            return nil
        }
        let time = TimeHelper.getString(time: Date(), dateFormat: TimeHelper.FormatTimeSecond)
        let mData = "\(mSignUp.walletId?.description ?? "")_\(transactionId)_\(count.description)_\(time)"
        return mData
    }
    
    /**
     Split file
     */
    static func splitFile(msg : String) -> [QRCodeModel]? {
        let arrQRCode: [String] = msg.substringsOfLength(by: AppConstants.MAX_LENGHT_QRCODE) /*Noi dung content cua QRCode*/
        var mList = [QRCodeModel]()
        let total = arrQRCode.count
        var i = 1
        for QRContent in arrQRCode {
            mList.append(QRCodeModel(cycle: i, total: total, content: QRContent,isDisplay: true))
            i += 1
            debugPrint("Content: \(QRContent)")
        }
        return mList
    }
    
    /**
     Callback after index
     */
    static func saveFile(index : Int,transactionSignature : String ,data : QRCodeModel, completion: @escaping (_ result: Int)->()){
        let time = TimeHelper.getString(time: Date(), dateFormat: TimeHelper.FormatSendEnc)
        if let mData = QRCodeHelper.shared.generateDataQRCode(from: JSONSerializerHelper.toJson(data)){
            if  let fileName = CommonService.getGenerateQRCode(count: index+1, transactionId: time){
                if  QRCodeHelper.shared.saveImage(image: mData, fileName: fileName) {
                    savedTransactionQRToDb(data: data, transactionSignature: transactionSignature)
                    completion(index+1)
                }
            }
        }
        completion(-1)
    }
    
    static func savedTransactionQRToDb(data : QRCodeModel,transactionSignature : String){
        let mData = TransactionQREntityModel(data: data, transactionSignature: transactionSignature)
        if SQLHelper.insertedTransactionQR(data: mData){
            Utils.logMessage(message: "Saved item to TransactionQR successfully")
        }else{
            Utils.logMessage(message: "Saved item to TransactionQR Failure")
        }
    }
    
    /*Saved item to transactionQR*/
    static func savedTransactionQRToDB(index : Int,data : QRCodeModel,transactionSignature : String, completion : @escaping (_ result : Int) -> ()){
        let mData = TransactionQREntityModel(data: data, transactionSignature: transactionSignature)
        CommonService.eventPushSaveToPhoto(value: mData.value ?? "")
        if SQLHelper.insertedTransactionQR(data: mData){
            Utils.logMessage(message: "Saved item to TransactionQR successfully")
        }
        completion(index+1)
    }
    
    /**
     Save Contact
     */
    static func saveContact(index : Int, data : TransferDataSyncContactData,contact : [String : String], completion: @escaping (_ result: Int)->()){
        let fullName = contact[data.personMobilePhone ?? ""]
        if SQLHelper.insertedContacts(data: ContactsEntityModel(data: data,fullName:fullName ?? "Null")){
            completion(index + 1)
        }
        completion(-1)
    }
    
    /**
     Push data to Exchange cash
     */
    static func sendDataToExchangeCash(data : ExchangeeCashData,isResponse : Bool){
        Utils.logMessage(message:  "sendDataToExchangeCash......")
        Utils.logMessage(object: data.listExchangeCash)
        ShareExchangeCashSingleton.shared.set(value: PassDataViewModel(identifier: EnumPassdata.EXCHANGE_CASH,exchangeeCash: data))
        if isResponse {
            ShareExchangeCashSingleton.shared.bindData()
        }
    }
    
    static func getShareExchangeCash() -> ExchangeeCashData?{
        if let mData = ShareExchangeCashSingleton.shared.get(value: PassDataViewModel.self){
            if mData.identifier == EnumPassdata.EXCHANGE_CASH.rawValue {
                let mExchangeCash = mData.exchangeeCash
                if let _ = mExchangeCash.isExchangeCash {
                    return mExchangeCash
                }
            }
        }
        return nil
    }
    
    static func getSharePassDataViewModel() -> PassDataViewModel? {
        if let mData = ShareExchangeCashSingleton.shared.get(value: PassDataViewModel.self){
            return mData
        }
        return nil
    }
    
    static func clearExchangeCashData() {
        ShareExchangeCashSingleton.shared.set(value: PassDataViewModel(identifier: EnumPassdata.EXCHANGE_CASH,exchangeeCash: ExchangeeCashData()))
    }
    
    //Save to contact
    static func saveItemToContact(contact : ContactsEntityModel){
        let _ = SQLHelper.insertedContacts(data: contact)
    }
    
    
    /**
     Push data to Contact
     */
    static func sendDataToContactEntities(data : ContactsEntityModel, isResponse : Bool){
        ShareSyncContactSingleton.shared.set(value: PassDataViewModel(identifier: EnumPassdata.CONTACT_ENTITIES,contact: data))
        if isResponse {
            ShareSyncContactSingleton.shared.bindData()
        }
    }
    
    static func getShareContactEntities() -> ContactsEntityModel?{
        if let mData = ShareSyncContactSingleton.shared.get(value: PassDataViewModel.self){
            if mData.identifier == EnumPassdata.CONTACT_ENTITIES.rawValue {
                let mContact = mData.contact
                if let _ = mContact.walletId {
                    return mContact
                }
            }
        }
        return nil
    }
    
    /**
     Push data to Transfer eCashToeCash
     */
    static func sendDataToeCashToeCash(data : eCashToeCashPassData, isResponse : Bool){
        ShareTransactionSingleton.shared.set(value: PassDataViewModel(identifier: EnumPassdata.CONTACT_ENTITIES,eCashToeCash: data))
        if isResponse {
            ShareTransactionSingleton.shared.bindData()
        }
    }
    
    static func getShareeCashToeCash() -> eCashToeCashPassData?{
        if let mData = ShareTransactionSingleton.shared.get(value: PassDataViewModel.self){
            if mData.identifier == EnumPassdata.CONTACT_ENTITIES.rawValue {
                let mContact = mData.eCashtoeCash
                if let _ = mContact.eCash {
                    return mContact
                }
                if let _ = mContact.ecashArray {
                    return mContact
                }
            }
        }
        return nil
    }
    
    /**
     Push data to transaction logs
     */
    
    static func sendDataToTransactionLogsHistory(data : FilterData, isResponse : Bool){
        ShareTransactionLogsHistorySingleton.shared.set(value: PassDataViewModel(identifier: EnumPassdata.TRANSACTION_LOGS_HISTORY,filter: data))
        if isResponse {
            ShareTransactionLogsHistorySingleton.shared.bindData()
        }
    }
    
    static func getShareTransactionLogsHistory() -> FilterData?{
        if let mData = ShareTransactionLogsHistorySingleton.shared.get(value: PassDataViewModel.self){
            if mData.identifier == EnumPassdata.TRANSACTION_LOGS_HISTORY.rawValue {
                let mContact = mData.filter
                if let _ = mContact.status{
                    return mContact
                }
                if let _ = mContact.time {
                    return mContact
                }
                if let _ = mContact.type {
                    return mContact
                }
            }
        }
        return nil
    }
    
    /**
     Push data to transaction logs detail
     */
    
    static func sendDataToTransactionLogsDetail(data : TransactionLogsData, isResponse : Bool){
        ShareTransactionLogsHistorySingleton.shared.set(value: PassDataViewModel(identifier: EnumPassdata.TRANSACTION_LOGS_DETAIL,transactionLogs : data))
        if isResponse {
            ShareTransactionLogsHistorySingleton.shared.bindData()
        }
    }
    
    static func getShareTransactionLogsDetail() -> TransactionLogsData?{
        if let mData = ShareTransactionLogsHistorySingleton.shared.get(value: PassDataViewModel.self){
            if mData.identifier == EnumPassdata.TRANSACTION_LOGS_DETAIL.rawValue {
                let mTransaction = mData.transactionLogs
                if let _ = mTransaction.transactionType{
                    return mTransaction
                }
            }
        }
        return nil
    }
    
    
    /**
     Push data to Transfer eCashToeCash
     */
    static func sendDataToDestroyWalletOptions(data : DestroyWalletOptionsData, isResponse : Bool){
        ShareTransactionSingleton.shared.set(value: PassDataViewModel(identifier: EnumPassdata.DESTROY_WALLET_OPTIONS,destroyWalletOptions: data))
        if isResponse {
            ShareTransactionSingleton.shared.bindData()
        }
    }
    
    static func getShareDestroyWalletOptions() -> DestroyWalletOptionsData?{
        if let mData = ShareTransactionSingleton.shared.get(value: PassDataViewModel.self){
            if mData.identifier == EnumPassdata.DESTROY_WALLET_OPTIONS.rawValue {
                let mContact = mData.destroyWalletOptions
                if let _ = mContact.balance {
                    return mContact
                }
            }
        }
        return nil
    }
    
    /**
     Push data to share to otp value
     */
    static func sendDataToOTP(data : OTPShareData, isResponse : Bool){
        ShareTransactionSingleton.shared.set(value: PassDataViewModel(identifier: EnumPassdata.OTP,otpShareData: data))
        if isResponse {
            ShareTransactionSingleton.shared.bindData()
        }
    }
    
    static func getShareOTP() -> OTPShareData?{
        if let mData = ShareTransactionSingleton.shared.get(value: PassDataViewModel.self){
            if mData.identifier == EnumPassdata.OTP.rawValue {
                let mData = mData.otpShareData
                if let _ = mData.transactionCode {
                    return mData
                }
            }
        }
        return nil
    }
    
    /**
     Push data to share to otp value
     */
    static func sendDataToUpdatedForgotPasswordCompleted(data : ForgotPasswordShareData, isResponse : Bool){
        ShareForgotPasswordSingleton.shared.set(value: PassDataViewModel(identifier: EnumPassdata.UPDATED_FORGOT_PASSWORD_COMPLETED,forgotPassword: data))
        if isResponse {
            ShareForgotPasswordSingleton.shared.bindData()
        }
    }
    
    static func getShareUpdatedForgotPasswordCompleted() -> ForgotPasswordShareData?{
        if let mData = ShareForgotPasswordSingleton.shared.get(value: PassDataViewModel.self){
            if mData.identifier == EnumPassdata.UPDATED_FORGOT_PASSWORD_COMPLETED.rawValue {
                let mData = mData.forgotPasswordCompleted
                if let _ = mData.title {
                    return mData
                }
            }
        }
        return nil
    }
    
    /**
     get multiple languages
     */
    static func getMultipleLanguages() -> String? {
        if let saved = StorageHelper.getString(key: StorageKey.multipleLanguages) {
            return saved
        }
        return nil
    }
    
    /**
     set multiple languages
     */
    static func setMultipleLanguages(value: String) {
        StorageHelper.setObject(key: StorageKey.multipleLanguages, value: value)
    }
    
    static func getContactList(data : [TransferDataSyncContactData])-> [TransferDataSyncContactData] {
        var mList = [TransferDataSyncContactData]()
        for index in data{
            if CommonService.getWalletId() != index.walletId?.description && CommonService.getPhoneNumber() != index.personMobilePhone{
                mList.append(index)
            }
        }
        return mList
    }
    
    
    /**
     set firebase token
     */
    static func setFirebaseToken(data: String) {
        StorageHelper.setObject(key: StorageKey.firebaseToken, value: data)
    }
    
    /**
     get firebase token
     */
    static func getFirebaseToken() -> String? {
        if let saved = StorageHelper.getString(key: StorageKey.firebaseToken){
            return saved
        }
        return nil
    }
    
    /**
     set is intro
     */
    static func setIsIntro(data: Bool) {
        StorageHelper.setObject(key: StorageKey.isIntro, value: data)
    }
    
    /**
     get is intro
     */
    static func getIsIntro() -> Bool {
        let value =  StorageHelper.getBool(key: StorageKey.isIntro)
        return value
    }
    
    /**
      Init tab
    */
    static func initTab(){
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.initTabBarController(selectedIndex: 0)
    }
    
    /*Init sqline**/
    static func initSQLine(){
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.initSQLine()
    }
    
   
    //reader QRCode
    static func onReaderQRcode(tempImage : CGImage, completion : @escaping (_ result : String?) -> ()) {
         do {
             // initializers are imported without "initWith"
             let source: ZXLuminanceSource = ZXCGImageLuminanceSource(cgImage: tempImage)
             let binazer = ZXHybridBinarizer(source: source)
             let bitmap = ZXBinaryBitmap(binarizer: binazer)
             let hints = ZXDecodeHints()
             let reader = ZXMultiFormatReader()
             // 1) you missed the name of the method, "decode", and
             // 2) use optional binding to make sure you get a value
             let result = try reader.decode(bitmap, hints:hints)
             let text = result.text ?? "Unknow"
             completion(text)
         }catch {
             completion(nil)
         }
     }
    
      /**
          set sign out
      */
      static func getIsSignOut() -> Bool? {
          return  StorageHelper.getBool(key: StorageKey.isSignOut)
       }
       
       /**
        set sign out
        */
       static func setIsSignOut(value: Bool) {
           StorageHelper.setObject(key: StorageKey.isSignOut, value: value)
       }
    
       /**
          Push data gallery options
        */
         
       static func sendDataToGalleryOption(data : GalleryOptionsData, isResponse : Bool){
           ShareSingleton.shared.set(value: PassDataViewModel(identifier: EnumPassdata.GALLERY_OPTIONS,galleryOptions : data))
           if isResponse {
                ShareSingleton.shared.bindData()
           }
       }
         
       static func getShareGalleryOptions() -> GalleryOptionsData?{
           if let mData = ShareSingleton.shared.get(value: PassDataViewModel.self){
              if mData.identifier == EnumPassdata.GALLERY_OPTIONS.rawValue {
                 let mGalleryOptions = mData.galleryOptions
                if let _ = mGalleryOptions.bIconLarge {
                    return mGalleryOptions
                }
                if let _ = mGalleryOptions.isAvatar {
                    return mGalleryOptions
                }
              }
          }
          return nil
      }
    
    /*
       Push data to share to otp value
    */
     static func sendDataToReceivedLixiOptions(data : ReceiveLixiOptionsData, isResponse : Bool){
        ShareGeneralSingleton.shared.set(value: PassDataViewModel(identifier: EnumPassdata.ReceiveLixiOptions,receiveLixiOptions : data))
         if isResponse {
             ShareGeneralSingleton.shared.bindData()
         }
     }
     
     static func getShareReceivedLixiOptions() -> ReceiveLixiOptionsData?{
         if let mData = ShareGeneralSingleton.shared.get(value: PassDataViewModel.self){
            if mData.identifier == EnumPassdata.ReceiveLixiOptions.rawValue {
                let mData = mData.receiveLixiOptions
                if let _ = mData.id {
                    return mData
                }
             }
         }
         return nil
     }
    
    static func eventPushActionToView(data : EnumResponseToView){
        SwiftEventBusHelper.post(ConfigKey.ActionToView, sender: data.rawValue)
    }
    
    static func eventPushActionToObjectView(obj: EventBusObjectData){
        SwiftEventBusHelper.post(ConfigKey.ActionToObjectView, sender: obj)
    }
    
    static func doVerifyData(result : TransferDataModel,completion: @escaping (_ result: TransferDataModel?)->()){
       GlobalRequestApiHelper.shared.doGetPublicKey(transferData: result) { (mResponsePublicKey) in
                   if mResponsePublicKey.handleAction == EnumTransactionsAction.WALLET_PUBLIC_KEY_SUCCESS.rawValue {
                       debugPrint("data  \(result.dataeCashToeCash())")
                       debugPrint("Starting \(TimeHelper.getString(time: Date(), dateFormat: TimeHelper.FormatTimeSecond))....................................................verify")
                       let verify = ELGamalHelper.instance.verifyData(signature: result.id ?? "", data: result.dataeCashToeCash() , publicKeySender: mResponsePublicKey.publicKeySender ?? "")
                       debugPrint("Ending  \(TimeHelper.getString(time: Date(), dateFormat: TimeHelper.FormatTimeSecond))....................................................veriy")
                       //let verify = true
                       debugPrint("Public key sender \(mResponsePublicKey.publicKeySender ?? "")")
                       Utils.logMessage(message: "Data \(verify.description)")
                       if verify {
                           if result.type == EnumTransferType.LIXI.rawValue {
                               completion(result)
                               debugPrint("This is lixi")
                           }else{
                            completion(nil)
                        }
                       }else{
                           debugPrint("Message \(mResponsePublicKey.message ?? "")")
                           completion(nil)
                       }
                   }else{
                    completion(nil)
        }
         }
    }
    
    static func getErrorMessageFromSystem(code : String)-> String{
        let message  = String(format: LanguageHelper.getTranslationByKey(LanguageKey.ErrorOccurredFromSystem) ?? "", arguments: [code])
       return message
    }
    
    static func isActiveAccount() -> Bool {
        guard let _ = CommonService.getWalletId() else {
            return false
        }
        return true
    }
    
   
}
