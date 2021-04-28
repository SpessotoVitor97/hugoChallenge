//
//  MeetingsDetailsViewController.swift
//  hugoChallenge
//
//  Created by Vitor Spessoto on 26/04/21.
//

import UIKit

class MeetingsDetailsViewController: UIViewController {
    //*************************************************
    // MARK: - UI Shared Components
    //*************************************************
    private let meetingsDetailsTextView = UITextView()
    
    //*************************************************
    // MARK: - Properties
    //*************************************************
    var meetingDetails: [String: String] = [:]
    
    //*************************************************
    // MARK: - lifecycle
    //*************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        setupTextView(meetingsDetailsTextView)
    }
    
    func setupTextView(_ textView: UITextView) {
        self.view.addSubview(textView)
        textView.pinEdges(to: self.view)
    }
}
