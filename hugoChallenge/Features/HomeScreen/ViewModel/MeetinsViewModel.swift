//
//  MeetinsViewModel.swift
//  hugoChallenge
//
//  Created by Vitor Spessoto on 25/04/21.
//

import UIKit

class MeetingsViewModel {
    //*************************************************
    // MARK: - Private properties
    //*************************************************
    private (set) var meetings: [Meeting]? {
        didSet {
            self.delegate?.setupTableView(with: meetings!)
        }
    }
    
    //*************************************************
    // MARK: - Internal properties
    //*************************************************
    weak var delegate: MeetingsViewModelDelegate?
    
    //*************************************************
    // MARK: - Internal methods
    //*************************************************
    func fetchMeetings() {
        if let baseURL = URL(string: "https://hg-ios-test.s3-us-west-2.amazonaws.com/meetings.json") {
            let client = ApiClient(baseURL: baseURL, session: .shared, responseQueue: .main)
            
            _ = client.fetchMeetings { meetings, error in
                if error != nil {
                    print("Something wrong happened while we attemped to fetch your meetings.\n", error!)
                    return
                }
                
                guard let meetingsArray = meetings else { return }
                self.meetings = meetingsArray
            }
        } else {
            print("Please, check the provided base url.")
        }
    }
    
    func formatDateDetails(startAt: String, endAt: String) -> (String, String) {
        var todayLabel = ""
        
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        guard let startDate = formatter.date(from:startAt), let endDate = formatter.date(from: endAt) else {
            let errorMsg = "There is a problem with tha date details, please, check with the meeting responsible."
            return (errorMsg, todayLabel)
        }
        
        let startComponents = calendar.dateComponents([.year, .month, .day, .weekday, .hour, .minute], from: startDate)
        let endComponents   = calendar.dateComponents([.year, .month, .day, .weekday, .hour, .minute], from: endDate)
        
        if startComponents.day != endComponents.day {
            let errorMsg = "The meeting happens in difrent days, please, confirm with the responsable."
            return (errorMsg, todayLabel)
        }
        
        let finalStartDate = calendar.date(from:startComponents)
        let finalEndDate   = calendar.date(from: endComponents)
        
        if finalStartDate == Date() {
            todayLabel = "Today"
        }
        
        let startDateStr = getDateString(from: finalStartDate, withFormat: "EEEE, MMMM dd, HH:mm")
        let endDateStr = getDateString(from: finalEndDate, withFormat: "HH:mm")
        
        let dateDetails = startDateStr + " - " + endDateStr
        
        return (dateDetails, todayLabel)
    }
    
    //*************************************************
    // MARK: - Private methods
    //*************************************************
    private func getDateString(from date: Date?, withFormat format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        guard let date = date else {
            let errorMsg = "There is a problem with tha date details, please, check with the meeting responsible."
            return errorMsg
        }
        
        let dateString = formatter.string(from: date)
        return dateString
    }
}

//*************************************************
// MARK: - MeetingsViewModelDelegate
//*************************************************
protocol MeetingsViewModelDelegate: NSObject {
    func setupTableView(with meetings: [Meeting])
}
