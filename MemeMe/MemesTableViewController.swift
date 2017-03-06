//
//  MemesTableViewController.swift
//  MemeMe
//
//  Created by Sarthak on 3/2/17.
//  Copyright © 2017 Sarthak. All rights reserved.
//

import UIKit

class MemesTableViewController: UITableViewController {
    
    var savedmemes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return savedmemes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemesTableCell", for: indexPath) as! MemeTableViewCell
        cell.memedImage?.image=savedmemes[indexPath.row].memedImage
        cell.memeLabel.text=savedmemes[indexPath.row].topText+"..."+savedmemes[indexPath.row].bottomText

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller:MemeDetailViewController
        controller=storyboard?.instantiateViewController(withIdentifier: "memeDetail") as! MemeDetailViewController
        controller.meme=self.savedmemes[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }

}
