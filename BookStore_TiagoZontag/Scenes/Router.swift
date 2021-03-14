//
//  Router.swift
//  BookStore_TiagoZontag
//
//  Created by Tiago Zontag on 13/03/21.
//

import Foundation
import UIKit

enum Route {
    case detail(BookModel)
    case safari(URL)
}

protocol Router {
    func routeTo(_ route: Route)
}

protocol Routering {
    var router: Router? { get }
}

extension UIViewController: Routering {
    var router: Router? {
        self.navigationController as? Router
    }
}
