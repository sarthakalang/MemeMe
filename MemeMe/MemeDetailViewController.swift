//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Sarthak on 3/4/17.
//  Copyright © 2017 Sarthak. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    @IBOutlet weak var MemedImage: UIImageView!
    var meme:Meme!
    override func viewDidLoad() {
        super.viewDidLoad()
        MemedImage.contentMode=UIViewContentMode.scaleAspectFill
        MemedImage.image=meme.memedImage
            }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
            }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 

}
