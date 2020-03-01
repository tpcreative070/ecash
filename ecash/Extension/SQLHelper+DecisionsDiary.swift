//
//  SQLHelper+DecisionsDiary.swift
//  ecash
//
//  Created by phong070 on 9/21/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
extension SQLHelper {
    
    /*******************************DECISIONA DIARY**********************************/
    
    /*Create decisions diary*/
    class open func createDecisionsDiary(){
        guard let db = connection() else {
            return
        }
        DecisionsDiaryEntity.instance.createTable(db: db)
    }
    
    /*Insert decisions diary*/
    class open func insertedDecisionsDiary(data : DecisionsDiaryEntityModel) -> Bool{
        guard let db = connection() else {
            return false
        }
        return DecisionsDiaryEntity.instance.insert(db: db, data: data)
    }
    
    /*Get object decisions diary*/
    class open func getDecisionsDiary(key : String) -> DecisionsDiaryEntityModel?{
        guard let db = connection() else {
            return nil
        }
        return DecisionsDiaryEntity.instance.getObject(db: db, key: key)
    }
    
    /*Get list decisions diary*/
    class open func getListDecisionsDiary() -> [DecisionsDiaryEntityModel]?{
        guard let db = connection() else {
            return nil
        }
        return DecisionsDiaryEntity.instance.getList(db: db)
    }
}
