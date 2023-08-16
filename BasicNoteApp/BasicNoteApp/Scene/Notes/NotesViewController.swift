//
//  NotesViewController.swift
//  BasicNoteApp
//
//  Created by Furkan on 19.07.2023.
//

import UIKit

class NotesViewController: UIViewController, UIGestureRecognizerDelegate {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(NotesTableViewCell.self, forCellReuseIdentifier: NotesTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle(L10n.General.addNote, for: .normal)
        button.titleLabel?.text = L10n.General.addNote
        button.setImage(UIImage(asset: Asset.Icons.icAddnote), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        button.titleLabel?.font = .font(.interSemiBold, size: .h6)
        button.titleLabel?.textColor = .appWhite
        button.backgroundColor = .appPurple100
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addNoteTapped), for: .touchUpInside)
        return button
    }()
    
    private let menuButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(asset: Asset.Icons.icMenu), for: .normal)
        return button
    }()
    
    private let imageButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(asset: Asset.Images.imgUser), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let searchBarItem: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = L10n.Placeholder.search
        search.translatesAutoresizingMaskIntoConstraints = false
        search.searchTextField.layer.borderColor = UIColor.appLightGray.cgColor
        search.searchTextField.backgroundColor = .appWhite
        search.searchTextField.layer.borderWidth = 1
        search.searchTextField.tintColor = .appBlack
        search.searchTextField.layer.cornerRadius = 4
        search.searchTextField.clearButtonMode = .never
        search.tintColor = .appPurple100
        return search
    }()
    
    private var viewModel: NotesViewModelProtocol
    private var viewModelEdit : EditNoteViewModelProtocol
    private var allNote: [NoteDataModel] = [NoteDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        view.addSubview(addButton)
        applyConstraints()
        setupNavigationBar()
        navigationController?.navigationBar.barTintColor = .appWhite
        subscribeNotesViewModel()
        viewModel.getallNotesData()
    }
    
    init(viewModel: NotesViewModelProtocol, viewModelEdit: EditNoteViewModelProtocol) {
        self.viewModel = viewModel
        self.viewModelEdit = viewModelEdit
        super.init(nibName: nil, bundle: nil)
    }
    
    // swiftlint:disable fatal_error
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // swiftlint:enable fatal_error
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

// MARK: - TabelView
extension NotesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allNote.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotesTableViewCell.identifier, for: indexPath) as? NotesTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: allNote[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        PreviewViewController.id = allNote[indexPath.row].id
        let previewVC = PreviewViewController()
        navigationController?.pushViewController(previewVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "") { (action, view, completion) in
            
            self.editItem(at: indexPath)
            completion(true)
        }
        editAction.backgroundColor = .appYellow
        editAction.image = UIImage(asset: Asset.Icons.icEdit)
        
        let deleteAction = UIContextualAction(style: .normal, title: "") { (action, view, completion) in
            
            let alertController = UIAlertController(title: "Delete Note", message: "Are you sure you want to deletethis note.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let deleteConfirmAction = UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                self.deleteItem(at: indexPath)
            })
            
            alertController.addAction(cancelAction)
            alertController.addAction(deleteConfirmAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        deleteAction.backgroundColor = .appRed
        deleteAction.image = UIImage(asset: Asset.Icons.icTrash)
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return configuration
    }
    
    func editItem(at indexPath: IndexPath) {
        viewModelEdit.id = allNote[indexPath.row].id
        
        let editNoteViewController = EditNoteViewController(coder: NSCoder())!
        navigationController?.pushViewController(editNoteViewController, animated: true)
        
    }
    func deleteItem(at indexPath: IndexPath) {
        let noteToDelete = allNote[indexPath.row]
        
        viewModel.deleteNote(id: noteToDelete.id, completion: { _ in
            DispatchQueue.main.async { [weak self] in
                self?.allNote.remove(at: indexPath.row)
                self?.tableView.reloadData()
            }
        })
    }
}

// MARK: - Layout
extension NotesViewController {
    
    private func applyConstraints() {
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        let addButtonConstraints = [
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -58),
            addButton.widthAnchor.constraint(equalToConstant: 142),
            addButton.heightAnchor.constraint(equalToConstant: 41)
        ]
        let allConstraints = [tableViewConstraints, addButtonConstraints]
        NSLayoutConstraint.activate(allConstraints.flatMap { $0 })
    }
}

// MARK: - Action
extension NotesViewController {
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: imageButton)
        imageButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        searchBarItem.delegate = self
        navigationItem.titleView = searchBarItem
    }
    
    @objc private func menuButtonTapped() {
        let loginViewController = LoginViewController(viewModel: LoginViewModel())
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    @objc private func profileButtonTapped() {
        self.navigationController?.isNavigationBarHidden = false
        let profileViewController = ProfileViewController(viewModel: UserUpdateViewModel())
        navigationController?.pushViewController(profileViewController, animated: true)
        
    }
    @objc private func addNoteTapped() {
        let addNoteViewController = AddNoteViewController(viewModel: AddNoteViewModel())
        navigationController?.pushViewController(addNoteViewController, animated: true)
    }
}

// MARK: - SearchBar
extension NotesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3 else {
            return
        }
        filterContentForSearchText(searchText)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        let filteredData = allNote.filter { note in
            return note.title.lowercased().contains(searchText.lowercased())
        }
        allNote = filteredData
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        navigationItem.rightBarButtonItem = nil
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: imageButton)
        resetSearchResults()
    }
    
    func resetSearchResults() {
        viewModel.getallNotesData()
        tableView.reloadData()
    }
}

// MARK: - Response Data
extension NotesViewController {
    func subscribeNotesViewModel() {
        viewModel.reloadData = { notes in
            self.allNote = notes
            self.tableView.reloadData()
        }
    }
}

import SwiftUI
#if DEBUG

@available(iOS 13, *)
struct NotesViewControllerPreview: PreviewProvider {
    static var previews: some View {
        NotesViewController(viewModel: NotesViewModel(), viewModelEdit: EditNoteViewModel()).showPreview()
    }
}
#endif
