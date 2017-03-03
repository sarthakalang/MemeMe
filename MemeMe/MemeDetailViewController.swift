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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
