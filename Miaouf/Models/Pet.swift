//
//  Pet.swift
//  Miaouf
//
//  Created by Pierre Sabard on 22/06/2023.
//

import Foundation
struct Pet {
  var name: String?
  var hasMajority: Bool
  var phone: String?
  var race: String?
  var gender: Gender

}
  enum Gender {
    case male
    case female
  }
