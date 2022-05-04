//
//  MainTabbarController.swift
//  Nasa
//
//  Created by Coşkun Güngör on 29.04.2022.
//

import UIKit

class MainTabbarController: UITabBarController, MainTabbarViewModelDelegate {
    
    var viewModel: MainTabbarViewModel = MainTabbarViewModel()
    var viewFilterMenu:UIView!
    var tabbarSelectedIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainTabbarViewModel()
        viewModel.delegate = self
        viewModel.load(view: self.view)
        viewModel.fetchData()
        setupUI()
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        viewFilterMenu.alpha = 1
        if item == (self.tabBar.items!)[0]{
            tabbarSelectedIndex = 0
        }
        if item == (self.tabBar.items!)[1]{
            tabbarSelectedIndex = 1
        }
        if item == (self.tabBar.items!)[2]{
            tabbarSelectedIndex = 2
        }
        if item == (self.tabBar.items!)[3]{
            viewFilterMenu.alpha = 0
            tabbarSelectedIndex = 3
        }
    }
    
    func setupUI() {
        
        self.viewFilterMenu = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 80))
        self.viewFilterMenu.backgroundColor = .white
        self.view.addSubview(self.viewFilterMenu)
        
        let filterButton = UIButton(type: .system, primaryAction: UIAction(title: "Filter", handler: { _ in
            if self.tabbarSelectedIndex == 0 {
                self.createActionSheet(output: .curiosity)
            }else if self.tabbarSelectedIndex == 1 {
                self.createActionSheet(output: .opportunity)
            }else if self.tabbarSelectedIndex == 2 {
                self.createActionSheet(output: .spirit)
            }
            
        }))
        filterButton.frame = CGRect.init(x: viewFilterMenu.frame.size.width - 100, y: 30, width: 100, height: 50)
        filterButton.backgroundColor = .clear
        viewFilterMenu.addSubview(filterButton)
    }
    
    func createActionSheet(output:Constant.FilterOutput){
        let alert = UIAlertController(title: "Camera Filter", message: "Please Select an Camera", preferredStyle: .actionSheet)
        
        switch output {
        case .curiosity:
            for i in 0...Constant.arrFilterCuriosity.count - 1 {
                alert.addAction(UIAlertAction(title: Constant.arrFilterCuriosity[i], style: .default , handler:{ (UIAlertAction)in
                    print(Constant.arrFilterCuriosity[i])
                }))
            }
        case .opportunity:
            for i in 0...Constant.arrFilterOpportunity.count - 1 {
                alert.addAction(UIAlertAction(title: Constant.arrFilterOpportunity[i], style: .default , handler:{ (UIAlertAction)in
                    print(Constant.arrFilterOpportunity[i])
                }))
            }
        case .spirit:
            for i in 0...Constant.arrFilterSpirit.count - 1 {
                alert.addAction(UIAlertAction(title: Constant.arrFilterSpirit[i], style: .default , handler:{ (UIAlertAction)in
                    print(Constant.arrFilterSpirit[i])
                }))
            }
        }
    
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
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
