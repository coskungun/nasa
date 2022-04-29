//
//  InfinityCollectionViewCell.swift
//  Nasa
//
//  Created by Coşkun Güngör on 29.04.2022.
//

import UIKit
import Kingfisher


class InfinityCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    var item:PhotoObject?
    {
        didSet
        {
            if let url = URL(string:item?.img_src ?? "") {
                imageView.kf.setImage(with: url, placeholder: UIImage.init(named: "profile_avatar_1"), options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ], completionHandler:nil)
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
