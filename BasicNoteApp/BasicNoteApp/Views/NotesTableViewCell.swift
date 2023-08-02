//
//  NotesTableViewCell.swift
//  BasicNoteApp
//
//  Created by Furkan on 19.07.2023.
//

import UIKit

class NotesTableViewCell: UITableViewCell {
    
    static let identifier = "NotesTableViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.interSemiBold, size: .h6)
        label.textColor = .appBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    let noteLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.interMedium, size: .h6)
        label.textColor = .appDarkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(noteLabel)
        applyConstraints()
    }
    // swiftlint:disable fatal_error
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // swiftlint:enable fatal_error
    
    private func applyConstraints() {
        
        let stackViewConstraint = [
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
        ]
        NSLayoutConstraint.activate(stackViewConstraint)
    }
    
    func configure(with noteData: NoteDataModel) {
        titleLabel.text = noteData.title
        noteLabel.text = noteData.note
    }
    
    func getNoteData(id: Int) {
        NoteService().getNotesDetail(id: id) { note in
            switch note {
            case.success(let noteDetail):
                self.titleLabel.text = noteDetail.data.title
                self.noteLabel.text = noteDetail.data.note
            case.failure(let error):
                print(error)
                
            }
        }
    }
}
