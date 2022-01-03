//
//  Toy.swift
//  Sharing Toys
//
//  Created by Willian S. on 04/01/22.

import Foundation

struct Toy {
    let name: String
    let state: Int
    let giver: String
    let address: String
    let phone: String
    let id: String

    func getState() -> String? {
        switch state {
        case 0:
            return "Novo"
        case 1:
            return "Usado"
        case 2:
            return "Precisa reparo"
        default:
            return nil
        }
    }
}
