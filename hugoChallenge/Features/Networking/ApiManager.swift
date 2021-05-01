//
//  ApiManager.swift
//  hugoChallenge
//
//  Created by Vitor Spessoto on 24/04/21.
//

import Foundation

class ApiClient {
    //*************************************************
    // MARK: - Aliases
    //*************************************************
    typealias fetchMeetingsHandler = ([Meeting]?, Error?) -> Void
    typealias fetchDetailsHandler = (MeetingDetailsModel?, Error?) -> Void
    
    //*************************************************
    // MARK: - Properties
    //*************************************************
    let baseURL: URL
    let session: URLSession
    let responseQueue: DispatchQueue?
    
    //*************************************************
    // MARK: - Init
    //*************************************************
    init(baseURL: URL, session: URLSession, responseQueue: DispatchQueue?) {
        self.baseURL = baseURL
        self.session = session
        self.responseQueue = responseQueue
    }
    
    //*************************************************
    // MARK: - Internal methods
    //*************************************************
    func fetchMeetings(completionHandler: @escaping fetchMeetingsHandler) -> URLSessionTask {
        let url = baseURL
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200, error == nil,
                  let data = data else { return }
            
            let decoder = JSONDecoder()
            do {
                let meetings = try decoder.decode([Meeting].self, from: data)
                self.dispatchResult(model: meetings, completionHandler: completionHandler)
            } catch {
                self.dispatchResult(error: error, completionHandler: completionHandler)
            }
        }
        task.resume()
        return task
    }
    
    func fetchDetails(completionHandler: @escaping fetchDetailsHandler) -> URLSessionTask {
        let url = baseURL
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200, error == nil,
                  let data = data else { return }
            
            let decoder = JSONDecoder()
            do {
                let details = try decoder.decode(MeetingDetailsModel.self, from: data)
                self.dispatchResult(model: details, completionHandler: completionHandler)
            } catch {
                self.dispatchResult(error: error, completionHandler: completionHandler)
            }
        }
        task.resume()
        return task
    }
    
    //*************************************************
    // MARK: - Private methods
    //*************************************************
    private func dispatchResult<Type>(model: Type? = nil, error: Error? = nil, completionHandler: @escaping (Type?, Error?) -> Void) {
        guard let responseQueue = responseQueue else {
            completionHandler(model, error)
            return
        }
        responseQueue.async {
            completionHandler(model, error)
        }
    }
}
