//
//  DetailModal.swift
//  Nasa
//
//  Created by Coşkun Güngör on 5.05.2022.
//

import UIKit
import Kingfisher


protocol DetailModalDelegate:class {
    func btnClose(_ button: DetailModal)
}


class DetailModal: UIView {

    weak var delegate: DetailModalDelegate?
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var btnClose: UIButton!
        
    func setupView(pData:PhotoObject?){
        let url = URL(string: pData?.img_src ?? "")
        imgView.kf.indicatorType = .activity
        imgView.kf.setImage(with: url)
        imgView.contentMode = .scaleToFill
        
            
    }

    @IBAction func btnCloseClick(_ sender: Any) {
        
        delegate?.btnClose(self)
    }
}
