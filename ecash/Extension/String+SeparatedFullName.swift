//
//  String+SeparatedFullName.swift
//  ecash
//
//  Created by phong070 on 9/3/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

extension  String {
    func toSeparatedName() -> SeparatedFullName {
            let name =  self
            let array = name.components(separatedBy:" ")
            let spaceCount = array.count - 1
            var separatedName = SeparatedFullName(firstName: "", lastName: "", middleName: "")
            if spaceCount == 0{
                separatedName.firstName = array[0]
                debugPrint(separatedName)
                return separatedName
            }
            if spaceCount == 1{
                separatedName.firstName = array[0]
                separatedName.lastName = array[1]
                debugPrint(separatedName)
                return separatedName
            }
            if spaceCount == 2{
                separatedName.firstName = array[0]
                separatedName.middleName = array[1]
                separatedName.lastName = array[2]
                debugPrint(separatedName)
                return separatedName
            }else{
                separatedName.firstName = array[0]
                var middleName = ""
                for i in 0..<array.count {
                    if i != 0 && i != spaceCount{
                        if middleName == ""{
                            middleName += "\(array[i])"
                        }else{
                            middleName += " \(array[i])"
                        }
                    }
                }
                separatedName.middleName = middleName
                separatedName.lastName = array[spaceCount]
                debugPrint(separatedName)
                return separatedName
            }
    }
}
