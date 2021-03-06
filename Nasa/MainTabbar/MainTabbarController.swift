//
//  MainTabbarController.swift
//  Nasa
//
//  Created by Coşkun Güngör on 29.04.2022.
//

import UIKit
import FirebaseRemoteConfig
import FirebaseAnalytics


class MainTabbarController: UITabBarController, MainTabbarViewModelDelegate {
    
    var viewModel: MainTabbarViewModel = MainTabbarViewModel()
    var viewFilterMenu:UIView!
    var tabbarSelectedIndex = 0
    var strTitle:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainTabbarViewModel()
        viewModel.delegate = self
        viewModel.load(view: self.view)
        setupUI()
        createRemoteConfig()
        
    }
    
    
    func createRemoteConfig() {
        
        let remoteConfig = RemoteConfig.remoteConfig()
        let defaultVal : [String:NSObject] = [
            "isLogin": false as NSObject
        ]
        
        remoteConfig.setDefaults(defaultVal)
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        remoteConfig.fetch(withExpirationDuration: 0, completionHandler: {
            status,error in
            
            if status == .success , error == nil {
                
                remoteConfig.activate(completion:{ success,error in
                    guard error == nil else {
                        return
                    }
                    let value = remoteConfig.configValue(forKey: "isLogin").boolValue
                    if value == true {
                        DispatchQueue.main.async {
                            self.showAlert()
                        }
                    }
                } )
            }else {
                print("else")
            }
        })
        
    }
    func showAlert(){
        let alert = UIAlertController(title: "remoteTitle".localized, message: "remoteMessage".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "close".localized, style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        viewFilterMenu.alpha = 1
        if item == (self.tabBar.items!)[0]{
            tabbarSelectedIndex = 0
            self.strTitle.text = "Curiosity"
        }
        if item == (self.tabBar.items!)[1]{
            tabbarSelectedIndex = 1
            self.strTitle.text = "Opportunity"
        }
        if item == (self.tabBar.items!)[2]{
            tabbarSelectedIndex = 2
            self.strTitle.text = "Spirint"
        }
        
    }
    
    func setupUI() {
        
        self.viewFilterMenu = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 80))
        self.viewFilterMenu.backgroundColor = .white
        self.view.addSubview(self.viewFilterMenu)
        
        let filterButton = UIButton(type: .system, primaryAction: UIAction(title:"lblFilter".localized, handler: { _ in
            if self.tabbarSelectedIndex == 0 {
                self.createActionSheet(output: .curiosity)
            }else if self.tabbarSelectedIndex == 1 {
                self.createActionSheet(output: .opportunity)
            }else if self.tabbarSelectedIndex == 2 {
                self.createActionSheet(output: .spirit)
            }
            
        }))
        filterButton.frame = CGRect.init(x: viewFilterMenu.frame.size.width - 100, y: 40, width: 100, height: 40)
        filterButton.backgroundColor = .clear
        viewFilterMenu.addSubview(filterButton)
        
        self.strTitle = UILabel.init(frame: CGRect.init(x: 0, y: 40, width: self.view.frame.size.width, height: 40))
        self.strTitle.text = "Curiosity"
        self.strTitle.textAlignment = .center
        viewFilterMenu.addSubview(self.strTitle)
        
    }
    
    func createActionSheet(output:Constant.FilterOutput){
        let alert = UIAlertController(title: "lblFilterTitle".localized, message: "lblFilterContent".localized, preferredStyle: .actionSheet)
        
        switch output {
        case .curiosity:
            for i in 0...Constant.arrFilterCuriosity.count - 1 {
                alert.addAction(UIAlertAction(title: Constant.arrFilterCuriosity[i], style: .default , handler:{ (UIAlertAction)in
                    let data:[String:String] = ["data":Constant.arrFilterCuriosity[i]]
                    NotificationCenter.default.post(name: NSNotification.Name("Curiosity"), object: nil,userInfo:data )
                }))
            }
        case .opportunity:
            for i in 0...Constant.arrFilterOpportunity.count - 1 {
                alert.addAction(UIAlertAction(title: Constant.arrFilterOpportunity[i], style: .default , handler:{ (UIAlertAction)in
                    
                    let data:[String:String] = ["data":Constant.arrFilterOpportunity[i]]
                    NotificationCenter.default.post(name: NSNotification.Name("Opportunity"), object: nil,userInfo:data )
                }))
            }
        case .spirit:
            for i in 0...Constant.arrFilterSpirit.count - 1 {
                alert.addAction(UIAlertAction(title: Constant.arrFilterSpirit[i], style: .default , handler:{ (UIAlertAction)in
                    let data:[String:String] = ["data":Constant.arrFilterOpportunity[i]]
                    NotificationCenter.default.post(name: NSNotification.Name("Spirint"), object: nil,userInfo:data )
                }))
            }
        }
        
        alert.addAction(UIAlertAction(title: "lbldissmis".localized, style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    
    func handleViewModelOutput(_ output: MainTabbarModelViewModelOutput) {
        switch output {
        case .isErrorConnection( _):
            print("Internet connection error message")
        case .reloadData:
            print("Load Data")
        case .updateTitle(let title):
            self.title = title
        }
    }
    
}
