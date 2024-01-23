//
//  Pokemon.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 24/1/2567 BE.
//

import Foundation


struct Pokemon: Identifiable, Codable {
    let id: String
    let name: String
    let imageUrl: URL?
    let xDescription: String
    let yDescription: String
    let height: String
    let category: String
    let weight: String
    let types: [String]
    let weaknesses: [String]
    let evolutions: [String]
    let abilities: [String]
    let hp: Int
    let attack: Int
    let defense: Int
    let specialAttack: Int?
    let specialDefense: Int?
    let speed: Int
    let total: Int
    let malePercentage: String?
    let femalePercentage: String?
    let genderless: Int
    let cycles: String
    let eggGroups: String
    let evolvedFrom: String?
    let reason: String?
    let baseExp: String

    enum CodingKeys: String, CodingKey {
        case id, name, xDescription = "xdescription", yDescription = "ydescription"
        case height, category, weight, types = "typeofpokemon", weaknesses, evolutions, abilities
        case hp, attack, defense, specialAttack = "special_attack", specialDefense = "special_defense", speed, total
        case malePercentage = "male_percentage", femalePercentage = "female_percentage", genderless, cycles, eggGroups = "egg_groups"
        case evolvedFrom = "evolvedfrom", reason, baseExp = "base_exp", imageUrl = "imageurl"
    }
}

