//
//  ViewController.swift
//  hugoChallenge
//
//  Created by Vitor Spessoto on 24/04/21.
//

import UIKit

class ViewController: UIViewController {
    //*************************************************
    // MARK: - UI Shared Components
    //*************************************************
    private let meetingsTableView = UITableView()
    
    //*************************************************
    // MARK: - Properties
    //*************************************************
    var meetingsArray: [String] = []
    
    //*************************************************
    // MARK: - lifecycle
    //*************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView(meetingsTableView)
    }
    
    //*************************************************
    // MARK: - Private methods
    //*************************************************
    private func setupNavigationBar() {
        self.navigationItem.title = "My mettings"
    }
    
    private func setupTableView(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MeetingsTableViewCell.self, forCellReuseIdentifier: MeetingsTableViewCell.identifier)
        
        self.view.addSubview(tableView)
        tableView.pinEdges(to: self.view)
    }
}

//*************************************************
// MARK: - UITableViewDataSource and UITableViewDelegate
//*************************************************
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let meetingsCell = tableView.dequeueReusableCell(withIdentifier: MeetingsTableViewCell.identifier, for: indexPath) as? MeetingsTableViewCell else { return UITableViewCell() }
        return meetingsCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row \(indexPath) tapped.")
    }
}

