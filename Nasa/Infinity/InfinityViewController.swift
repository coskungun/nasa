//
//  InfinityViewController.swift
//  Nasa
//
//  Created by Coşkun Güngör on 29.04.2022.
//

import Foundation
import UIKit
import InfiniteCarouselCollectionView
import Kingfisher

final class CVCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class InfinityViewController: UIViewController,InfinityViewModelDelegate {
    var viewModel: InfinityViewModel = InfinityViewModel()
    let pageControl = UIPageControl()
    let collectionView = CarouselCollectionView(frame: .zero, collectionViewFlowLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        viewModel = InfinityViewModel()
        viewModel.delegate = self
        viewModel.load(view: self.view)
        viewModel.fetchData()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.frame = view.bounds
        
        pageControl.frame = CGRect.init(x: (self.view.frame.size.width / 2) - 125, y: self.view.frame.size.height - 100, width: 250, height: 60)
        self.view.bringSubviewToFront(pageControl)
    }
    
    func handleViewModelOutput(_ output: InfinityModelViewModelOutput) {
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
        collectionView.isAutoscrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.autoscrollTimeInterval = 3.0
        let size = UIScreen.main.bounds.size
        collectionView.flowLayout.itemSize = CGSize(width: size.width, height: size.height)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("ellendi")
    }
}


extension InfinityViewController: CarouselCollectionViewDataSource {
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
