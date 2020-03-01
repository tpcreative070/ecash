//
//  ContactManager.swift
//  ecash
//
//  Created by phong070 on 10/28/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//
import UIKit
import Contacts
import ContactsUI

class ContactHelper {
    static let instance = ContactHelper()
    func getContact() -> [ContactsEntityModel]?{
        var mList = [ContactsEntityModel]()
        let contactStore = CNContactStore()
        var contacts = [CNContact]()
        let keys = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey
            ] as [Any]
        let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
        do {
            try contactStore.enumerateContacts(with: request){
                (contact, stop) in
                // Array containing all unified contacts from everywhere
                contacts.append(contact)
                for phoneNumber in contact.phoneNumbers {
                    if let number = phoneNumber.value as? CNPhoneNumber{
                        //let localizedLabel = CNLabeledValue<CNPhoneNumber>.localizedString(forLabel: label)
                        //print("\(contact.givenName) \(contact.familyName) tel:\(localizedLabel) -- \(number.stringValue), email: \(contact.emailAddresses)")
                        mList.append(ContactsEntityModel(contact: contact, phoneNumber : number.stringValue))
                        //debugPrint("Phone number \(number.stringValue)")
                    }
                }
            }
            return mList
        } catch {
            print("unable to fetch contacts")
        }
        return nil
    }
    
    func getRealContactPhoneNumber()->[String]?{
        var mList = [String]()
        if let mContact = ContactHelper.instance.getContact() {
            for index in mContact {
                if let mValue = index.phone?.toPhoneNumber(){
                    if  mValue != CommonService.getPhoneNumber() {
                        mList.append(mValue)
                    }
                }
            }
        }
        if mList.count > 0{
            return mList
        }
        return nil
    }
    
    func getPhoneMapByFullName() -> [String: String]?{
        var mHashValue = [String:String]()
        if let mContact = ContactHelper.instance.getContact() {
            for index in mContact {
                if let mValue = index.phone?.toPhoneNumber(){
                    mHashValue[mValue] = index.fullName
                }
            }
        }
        if mHashValue.count > 0{
            return mHashValue
        }
        return nil

    }
    
    
}
