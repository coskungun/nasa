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

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblRoverName: UILabel!
    @IBOutlet weak var lblCameraName: UILabel!
    @IBOutlet weak var lblRoverStatus: UILabel!
    
    @IBOutlet weak var lblStartDate: UILabel!

    
    @IBOutlet weak var lblFinishDate: UILabel!
    
    weak var delegate: DetailModalDelegate?

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var btnClose: UIButton!
    
    var item:PhotoObject? {
        didSet {
            let url = URL(string: item?.img_src ?? "")
            imgView.kf.indicatorType = .activity
            imgView.kf.setImage(with: url)
            imgView.contentMode = .scaleToFill
            lblDate.text =  Helpers.getFormattedDate(stringDate: item?.earth_date ?? "", defaultFormat: "yyyy-MM-dd", convertFormat: "dd.MM.yyyy")
            lblRoverName.text = item?.rover?.name
            lblCameraName.text = item?.camera?.full_name
            lblStartDate.text =  Helpers.getFormattedDate(stringDate: item?.rover?.launch_date ?? "", defaultFormat: "yyyy-MM-dd", convertFormat: "dd.MM.yyyy")
            lblFinishDate.text = Helpers.getFormattedDate(stringDate: item?.rover?.landing_date ?? "", defaultFormat: "yyyy-MM-dd", convertFormat: "dd.MM.yyyy")
            lblRoverStatus.text = item?.rover?.status
        }
    }

    @IBAction func btnCloseClick(_ sender: Any) {
        
        delegate?.btnClose(self)
    }
    
    
    override func awakeFromNib() {
        self.btnClose.setTitle(NSLocalizedString("close", comment: ""), for: .normal)
    }
}
