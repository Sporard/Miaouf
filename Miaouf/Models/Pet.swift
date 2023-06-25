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
    var status: Status {
        if name == nil || name == "" {
          return .rejected("Vous n'avez pas indiqué votre nom !")
        }
        if phone == nil || phone == "" {
          return .rejected("Vous n'avez pas indiqué votre téléphone !")
        }
        if race == nil || race == "" {
          return .rejected("Quel est votre race ?")
        }
        if !hasMajority {
          return .rejected("Les mineurs ne sont pas admis.")
        }

        return .accepted
    }

  enum Gender {
    case male
    case female
  }
    enum Status {
        case accepted
        case rejected(String)
    }
}
