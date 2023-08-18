//
//  NoteViewModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

protocol PreviewViewModelProtocol {
    var note: NoteDataModel? {get}
}

class PreviewViewModel: PreviewViewModelProtocol {
    var note: NoteDataModel?
}
