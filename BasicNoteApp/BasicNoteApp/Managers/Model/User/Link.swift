//
//  Link.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

// MARK: - Link
struct Link: Codable {
    let url: String?
    let label: String
    let active: Bool
}
