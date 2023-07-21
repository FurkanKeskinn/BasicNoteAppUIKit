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
        button.addTarget(self, action: #selector(addNoteTapped) , for: .touchUpInside)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        view.addSubview(addButton)
        applyConstraints()
        setupNavigationBar()
        navigationController?.navigationBar.barTintColor = .appWhite
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
//MARK: - TabelView
extension NotesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotesTableViewCell.identifier, for: indexPath) as? NotesTableViewCell else {
            return UITableViewCell()
        }
        cell.titleLabel.text = "Lemon Cake & Blueberry"
        cell.noteLabel.text = "Sunshine-sweet lemon blueberry layer cake dotted with juicy berries and topped with lush cream cheese…"
        return cell
    }
}
//MARK: - Layout
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
//MARK: - Action
extension NotesViewController {
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: imageButton)
        imageButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        searchBarItem.delegate = self
        navigationItem.titleView = searchBarItem
    }
    
    @objc private func menuButtonTapped() {
        //
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    @objc private func profileButtonTapped() {
        self.navigationController?.isNavigationBarHidden = false
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)

    }
    @objc private func addNoteTapped() {
        let addNoteViewController = AddNoteViewController()
        navigationController?.pushViewController(addNoteViewController, animated: true)
    }
}
//MARK: - SearchBar
extension NotesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3 else {
            return
        }
        //
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
    }
}
import SwiftUI
#if DEBUG

@available(iOS 13, *)
struct NotesViewControllerPreview: PreviewProvider {
    static var previews: some View {
        NotesViewController().showPreview()
    }
}
#endif
