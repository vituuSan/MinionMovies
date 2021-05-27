//
//  DetailsViewCell.swift
//  MinionMovies
//
//  Created by Vitor Costa on 10/05/21.
//  Copyright © 2021 Vitor Costa. All rights reserved.
//

import UIKit

class DetailsViewCell: UICollectionViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var backView: UIView!
    
    func setup(title: String) {
        labelTitle.text = title
    }
}
