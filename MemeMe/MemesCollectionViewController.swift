//
//  MemesCollectionViewController.swift
//  MemeMe
//
//  Created by Sarthak on 3/2/17.
//  Copyright © 2017 Sarthak. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MemesCollectionCell"

class MemesCollectionViewController: UICollectionViewController {
    var memes:[Meme]!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        let space:CGFloat = 3.0
        let dimension:CGFloat = (view.frame.size.width - (2 * space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        collectionView?.reloadData()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeCollectionViewCell
        cell.memeImg.image=memes[indexPath.row].memedImage
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller:MemeDetailViewController
        controller=storyboard?.instantiateViewController(withIdentifier: "memeDetail") as! MemeDetailViewController
        controller.meme=self.memes[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
        
    }

   


}
