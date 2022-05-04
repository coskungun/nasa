//
//  CuriosityViewModel.swift
//  Nasa
//
//  Created by Coşkun Güngör on 4.05.2022.
//

import Foundation
import UIKit

protocol CuriosityViewModelProtocol {
    var delegate: CuriosityViewModelDelegate? { get set }
    func load(view:UIView)
}

protocol CuriosityViewModelDelegate {
    func handleViewModelOutput(_ output: CuriosityModelViewModelOutput)
}

enum CuriosityModelViewModelOutput: Equatable {
    case updateTitle(String)
    case reloadData
    case isErrorConnection(String)
}

class CuriosityViewModel:CuriosityViewModelProtocol
{
    var delegate: CuriosityViewModelDelegate?
    var networkHelper:NetworkHelper? = NetworkHelper() //network operation -> optional (isteğe bağlı)
    var spinner = UIActivityIndicatorView.init(style: .large)
    var arrData:[PhotoObject]?
    var arrCache:[PhotoObject]?
    
    func load(view: UIView) {
        notify(.updateTitle("Curiosity"))
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    private func notify(_ output: CuriosityModelViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
        
    func fetchData()
    {
        showHideIndicator(isStart: true)
        networkHelper?.getAllDataCuriosity(complation: {
            result in
            switch result
            {
            case .success(let response):
                self.arrCache = response.photos
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
