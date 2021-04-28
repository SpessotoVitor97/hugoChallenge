//
//  MeetingsDetailsRouter.swift
//  hugoChallenge
//
//  Created by Vitor Spessoto on 26/04/21.
//

import UIKit

class MeetingsDetailsRouter {
    func present(in navigationController: UINavigationController) {
        let detailsViewController = MeetingsDetailsViewController()
        navigationController.pushViewController(detailsViewController, animated: true)
    }
}
