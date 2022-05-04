//
//  DetailSingleton.swift
//  Nasa
//
//  Created by Coşkun Güngör on 5.05.2022.
//

import Foundation
import UIKit

final class DetailSingleton: NSObject, DetailModalDelegate {
 
    weak var vcMain:UIViewController?
   static let sharedInstance = DetailSingleton()

   private override init() { }

    func showModal(vc:UIViewController,pData:PhotoObject?) {
        
        vcMain = vc
        let viewBackround:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: vc.view.frame.size.width, height: vc.view.frame.size.height))
        viewBackround.backgroundColor = .black
        viewBackround.tag = 123123
        viewBackround.alpha = 0.0
        vc.view.addSubview(viewBackround)
        
        var cRect:CGRect!
        cRect = CGRect.init(x: 0, y: 0, width: vc.view.frame.size
            .width - 20, height: vc.view.frame.size.height-300)
        
         
        let myView:DetailModal = DetailModal().loadNib() as! DetailModal
        myView.layer.cornerRadius = 6
        myView.frame = cRect
        myView.tag = 10203050
        myView.setupView(pData: pData)
        myView.center = CGPoint(x: vc.view.bounds.maxX/2, y: vc.view.bounds.maxY/2)
        myView.delegate = self
        vc.view.addSubview(myView)
        
        UIView.animate(withDuration: 0.3, animations:{
            viewBackround.alpha = 0.4
            myView.alpha = 1
        },completion: nil)
        
        
    }
    
    func btnClose(_ button: DetailModal) {
        dismissView(vc: self.vcMain ?? UIViewController())
    }
    
    private func dismissView(vc:UIViewController)
       {
           for view:UIView in vc.view.subviews
           {
               if view.isKind(of:DetailModal.self)
               {
                   UIView.animate(withDuration: 0.3, animations:{
                       view.alpha = 0
                   },completion:{ (finished: Bool) in
                       view.removeFromSuperview()
                   })
                   
               }
               if view.tag == 123123
               {
                   UIView.animate(withDuration: 0.3, animations:{
                       view.alpha = 0
                   },completion:{ (finished: Bool) in
                       view.removeFromSuperview()
                   })
                   
               }
               
           }
       }
}
