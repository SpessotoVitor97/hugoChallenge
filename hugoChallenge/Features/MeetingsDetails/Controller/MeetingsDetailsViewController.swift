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
    var meetingDetails: Meeting?
    
    //*************************************************
    // MARK: - lifecycle
    //*************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Project Workshop"
        setupTextView(meetingsDetailsTextView)
        setupDetails()
    }
    
    //*************************************************
    // MARK: - Internal methods
    //*************************************************
    func setupTextView(_ textView: UITextView) {
        self.view.addSubview(textView)
        textView.pinEdges(to: self.view)
    }
    
    func setupDetails() {
        guard let meeting = meetingDetails else { return }
        self.navigationItem.title = meeting.title
        
        let url = "https://hg-ios-test.s3-us-west-2.amazonaws.com/meetings/\(meeting.id).json"
        if let baseURL = URL(string: url) {
            let client = ApiClient(baseURL: baseURL, session: .shared, responseQueue: .main)
            
            _ = client.fetchDetails(completionHandler: { details, error in
                if error != nil {
                    print("Something wrong happened while we attemped to fetch your meetings.\n", error!)
                    return
                }
                
                guard let details = details else { return }
                self.meetingsDetailsTextView.text = details.htmlContent.htmlToString
            })
        } else {
            print("Please, check the provided base url.")
        }
    }
}
