//
//  OpportunityViewModel.swift
//  Nasa
//
//  Created by Coşkun Güngör on 4.05.2022.
//

import Foundation
import UIKit

protocol OpportunityViewModelProtocol {
    var delegate: OpportunityViewModelDelegate? { get set }
    func load(view:UIView)
}

protocol OpportunityViewModelDelegate {
    func handleViewModelOutput(_ output: OpportunityModelViewModelOutput)
}

enum OpportunityModelViewModelOutput: Equatable {
    case updateTitle(String)
    case reloadData
    case isErrorConnection(String)
}

class OpportunityViewModel:OpportunityViewModelProtocol
{
    var delegate: OpportunityViewModelDelegate?
    var networkHelper:NetworkHelper? = NetworkHelper() //network operation -> optional (isteğe bağlı)
    var spinner = UIActivityIndicatorView.init(style: .large)
    var arrData:[PhotoObject]?
    
    func load(view: UIView) {
        notify(.updateTitle("Oppurtunity"))
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    private func notify(_ output: OpportunityModelViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
        
    func fetchData()
    {
        showHideIndicator(isStart: true)
        networkHelper?.getAllDataOpportunity(complation: {
            result in
            switch result
            {
            case .success(let response):
                self.arrData = response.photos
                self.showHideIndicator(isStart: false)
                self.notify(.reloadData)
            case .failure(let error):
                print("error \(error)") //error toast or alert
                self.showHideIndicator(isStart: false)
            case .timeOutFailure(let timeoutError):
                print("timeoutError \(timeoutError)") //error toast or alert
            }
        })
    }
    
    func pushViewController(view:UIViewController,storyboard:String,viewID:String,isAnimated:Bool)
    {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let presentScren = storyboard.instantiateViewController(withIdentifier:viewID)
        view.navigationController?.pushViewController(presentScren, animated: true)
    }

    public func showHideIndicator(isStart:Bool)
    {
        if isStart == true
        {
            spinner.startAnimating()
        }else
        {
            spinner.stopAnimating()
        }
    }
}
