//
//  UiView + Extension.swift
//  Homework21-Alamofire
//
//  Created by Михаил Латий on 06.09.2023.
//

import UIKit

extension UIView {

    func addSubViews(views: [UIView]) {
        views.forEach { self.addSubview($0)  }
    }
}
