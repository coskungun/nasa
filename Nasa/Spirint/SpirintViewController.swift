//
//  SpirintViewController.swift
//  Nasa
//
//  Created by Coşkun Güngör on 4.05.2022.
//

import Foundation
import UIKit
import InfiniteCarouselCollectionView
import Kingfisher


class SpirintViewController: UIViewController,SpirintViewModelDelegate {
    var viewModel: SpirintViewModel = SpirintViewModel()
    let pageControl = UIPageControl()
    let collectionView = CarouselCollectionView(frame: .zero, collectionViewFlowLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        viewModel = SpirintViewModel()
        viewModel.delegate = self
        viewModel.load(view: self.view)
        viewModel.fetchData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(notdata(notification:)), name: Notification.Name("Spirint"), object: nil)
        
        setupUI()
    }
    
    @objc func notdata(notification: NSNotification){
        if let strData = notification.userInfo?["data"] as? String {
            print("strdata \(strData)")
          }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.frame = view.bounds
        
        pageControl.frame = CGRect.init(x: (self.view.frame.size.width / 2) - 125, y: self.view.frame.size.height - 100, width: 250, height: 60)
        self.view.bringSubviewToFront(pageControl)
    }
    
    func handleViewModelOutput(_ output: SpirintModelViewModelOutput) {
        switch output {
        case .isErrorConnection( _):
            print("Internet connection error message")
        case .reloadData:
            collectionView.alpha = 1
            collectionView.reloadData()
            pageControl.numberOfPages = viewModel.arrData?.count ?? 0
            pageControl.alpha = 1
        case .updateTitle(let title):
            self.title = title
        }
    }
    
    func setupUI(){
        pageControl.alpha = 0
        collectionView.alpha = 0
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        pageControl.numberOfPages = 10
        pageControl.tintColor = .black
        
        collectionView.register(CVCell.self, forCellWithReuseIdentifier:"id")
        collectionView.reloadData()
        collectionView.backgroundColor = .clear
        collectionView.carouselDataSource = self
        collectionView.isAutoscrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.autoscrollTimeInterval = 3.0
        let size = UIScreen.main.bounds.size
        collectionView.flowLayout.itemSize = CGSize(width: size.width, height: size.height)
    }
}


extension SpirintViewController: CarouselCollectionViewDataSource {
    var numberOfItems: Int {
        return viewModel.arrData?.count ?? 0
    }
    
    func carouselCollectionView(_ carouselCollectionView: CarouselCollectionView, cellForItemAt index: Int, fakeIndexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: fakeIndexPath) as! CVCell
        let url = URL(string: viewModel.arrData?[index].img_src ?? "")
        cell.imageView.kf.setImage(with: url)
        
        return cell
    }
    
    func carouselCollectionView(_ carouselCollectionView: CarouselCollectionView, didSelectItemAt index: Int) {
        print("Did select item at \(index)")
    }
    
    func carouselCollectionView(_ carouselCollectionView: CarouselCollectionView, didDisplayItemAt index: Int) {
        pageControl.currentPage = index
    }
}
