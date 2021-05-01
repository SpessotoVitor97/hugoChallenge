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
    // MARK: - Private Components
    //*************************************************
    private var viewModel = MeetingsViewModel()
    
    //*************************************************
    // MARK: - Internal properties
    //*************************************************
    var meetingsArray: [Meeting] = []
    var router = MainRouter()
    
    //*************************************************
    // MARK: - lifecycle
    //*************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "My mettings"
        configureViewModel()
    }
    
    //*************************************************
    // MARK: - Private methods
    //*************************************************
    private func configureViewModel() {
        viewModel.delegate = self
        viewModel.fetchMeetings()
    }
    
    private func setupTableView(_ tableView: UITableView, with meetings: [Meeting]) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MeetingsTableViewCell.self, forCellReuseIdentifier: MeetingsTableViewCell.identifier)
        
        self.view.addSubview(tableView)
        tableView.pinEdges(to: self.view)
    }
}

//*************************************************
// MARK: - MeetingsViewModelDelegate
//*************************************************
extension ViewController: MeetingsViewModelDelegate {
    func setupTableView(with meetings: [Meeting]) {
        meetingsArray = meetings
        setupTableView(meetingsTableView, with: meetings)
    }
}

//*************************************************
// MARK: - UITableViewDataSource and UITableViewDelegate
//*************************************************
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meetingsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let meetingsCell = tableView.dequeueReusableCell(withIdentifier: MeetingsTableViewCell.identifier, for: indexPath) as? MeetingsTableViewCell else { return UITableViewCell() }
        
        meetingsCell.title = meetingsArray[indexPath.row].title
        meetingsCell.details = viewModel.formatDateDetails(startAt: meetingsArray[indexPath.row].startAt, endAt: meetingsArray[indexPath.row].endAt)
        meetingsCell.setupUI()
        
        return meetingsCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigationController = self.navigationController else { return }
        router.presentMeetingsDetails(in: navigationController, with: meetingsArray[indexPath.row])
    }
}

