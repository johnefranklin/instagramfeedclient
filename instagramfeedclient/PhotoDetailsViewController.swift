//
//  PhotoDetailsViewController.swift
//  instagramfeedclient
//
//  Created by John Franklin on 9/11/15.
//  Copyright © 2015 JF. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var image: UIImage?
    var captionText: String?
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print(indexPath.row)
        let cell = tableView.dequeueReusableCellWithIdentifier("com.jf.DetailTableViewCell", forIndexPath: indexPath) as! DetailTableViewCell
        cell.detailLabel.text = captionText;
        cell.detailImageView.image = image
        return cell
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 320

        // Do any additional setup after loading the view.
        tableView.dataSource = self;
        tableView.delegate = self;
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
