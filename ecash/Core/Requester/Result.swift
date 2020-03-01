//
//  Result.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/25/19.
//  Copyright © 2019 Mac10. All rights reserved.
//
import Foundation

enum Result<T, U> where U: Error  {
  case success(T?)
  case failure(U)
}

enum ResultFunc<T, U> where U: Error {
  case success(T?)
  case failure(U?)
}
