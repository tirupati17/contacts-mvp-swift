//
//  UIImageView+Extension.swift
//  Contacts
//
//  Created by Tirupati Balan on 17/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//

import Foundation

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
