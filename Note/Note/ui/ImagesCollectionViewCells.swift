//
//  ImagesCollectionViewCells.swift
//  Note
//
//  Created by Pavel N on 7/19/19.
//  Copyright © 2019 Pavel N. All rights reserved.
//

import UIKit

class ImagesCollectionViewCells: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        
    }
    func  setImage(image:UIImage) {
        imageView.image = image
        setNeedsDisplay()
    }

}
