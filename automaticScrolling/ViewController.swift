//
//  ViewController.swift
//  automaticScrolling
//
//  Created by diwakar thapa on 8/8/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var x:CGFloat = 0
    var totalItem = 15
    var visibleCellSize:CGFloat?
    var spacingBetweenCell:CGFloat = 10.0
    var items:[Int] = [1,2,3,4,5,6,7,8,9,10]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        startAnimation()
    }
 
    func startAnimation() {
//        UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear,.repeat,.autoreverse], animations: {
//            self.startAnimate()
//        }, completion: nil)
       Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(startAnimate), userInfo: nil, repeats: true)
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.x = scrollView.contentOffset.x
    }

    @objc func startAnimate() {
        
            UIView.animate(withDuration: 0.1, delay: 0, options: [.curveLinear,.allowUserInteraction], animations: {
                let x = self.collectionView.contentOffset.x
                let with = self.view.frame.width
                print("x",self.collectionView.contentOffset.x + with,"width",self.collectionView.contentSize.width)
//                if (x + with) < self.collectionView.contentSize.width {
                    self.x += 5
                 self.collectionView.contentOffset.x = self.x
//                }
            }, completion: nil)
          
        
//        UIView.animate(withDuration: 1, delay: 0, options: [.curveLinear,.repeat,.autoreverse], animations: {
//            let x = self.collectionView.contentOffset.x
//            let with = self.view.frame.width
//            print("x",self.collectionView.contentOffset.x + with,"width",self.collectionView.contentSize.width)
//            if (x + with) < self.collectionView.contentSize.width {
//                self.collectionView.scrollRectToVisible(CGRect(x: (self.visibleCellSize ?? 0) + (self.collectionView.contentOffset.x + self.spacingBetweenCell), y: self.collectionView.contentOffset.y, width: self.collectionView.frame.width, height: self.collectionView.frame.height), animated: true)
//            } else {
//
//                self.collectionView.scrollRectToVisible(CGRect(x: 0 , y: self.collectionView.contentOffset.y, width: self.collectionView.frame.width, height: self.collectionView.frame.height), animated: true)
//            }
//        }, completion: nil)
    }
//    if x < (totalItem - 1) {
//    x += 1
//    self.collectionView.scrollToItem(at: IndexPath(item: x, section: 0), at: .centeredHorizontally, animated: true)
//    } else {
//    self.x = 0
//    self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
//    }
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count * 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        visibleCellSize = self.collectionView.visibleCells.first?.frame.width
        var index = indexPath.item
        if index > items.count - 1 {
            index -= items.count
        }
        collectionViewCell.items.text = "\(items[index % items.count])"
        print("x:",collectionView.contentOffset.x)
        return collectionViewCell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // if collection view scrolls horizontally, use offset.x else comment below line of code
        // In my case the collectionview scrolls vertically this I am commenting below line of code
                let width = collectionView.contentSize.width
                var offset = collectionView.contentOffset
//                let height = collectionView.contentSize.height
                if offset.x < width/4 {
                    offset.x += width/2
                    collectionView.setContentOffset(offset, animated: false)
                } else if offset.x > width/4 * 3 {
                    offset.x -= width/2
                    collectionView.setContentOffset(offset, animated: false)
                }
    }
    
    
}
