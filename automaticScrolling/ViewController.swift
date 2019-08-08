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
    var x = 0
    var totalItem = 15
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        startAnimation()
    }
 
    func startAnimation() {
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(startAnimate), userInfo: nil, repeats: true)
    }

    @objc func startAnimate() {
        if x < (totalItem - 1) {
            x += 1
            self.collectionView.scrollToItem(at: IndexPath(item: x, section: 0), at: .centeredHorizontally, animated: true)
        } else {
            self.x = 0
            self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalItem
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        print("x:",collectionView.contentOffset.x)
        return collectionViewCell
    }
    
    
}
