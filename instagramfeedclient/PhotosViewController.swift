//
//  PhotosViewController.swift
//  
//
//  Created by John Franklin on 9/10/15.
//
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var photos: NSArray = []
    var lowresImages: [UIImage] = []
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(photos.count)
        return photos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print(indexPath.row)
        let cell = tableView.dequeueReusableCellWithIdentifier("com.jf.InstafeedTableViewCell", forIndexPath: indexPath) as! TableViewCell
        let caption = self.photos[indexPath.row]["caption"] as! NSDictionary
        let captionText = caption["text"] as! String
        cell.instafeedDescLabel.text = captionText
        let images = self.photos[indexPath.row]["images"] as! NSDictionary
        let lowresImage = images["low_resolution"] as! NSDictionary
        let imageUrl = lowresImage["url"] as! String
        let url = NSURL(string: imageUrl)!
        //cell.instafeedImageView.setImageWithURL(url);
        let request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            if error == nil {
                let image = UIImage (data: data!)
                cell.instafeedImageView.image = image
            }
        }

        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.rowHeight = 320;
        tableView.dataSource = self;
        tableView.delegate = self;
        
        let clientId = "0cb0c253b9c140da8dd8c086acbb350a"
        
        let url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=\(clientId)")!
        let request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
            
            self.photos = responseDictionary["data"] as! NSArray
            
            self.tableView.reloadData()
        }
        
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
    }
    
    func refresh(sender:AnyObject)
    {
        let clientId = "0cb0c253b9c140da8dd8c086acbb350a"
        
        let url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=\(clientId)")!
        let request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
            
            self.photos = responseDictionary["data"] as! NSArray
            
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let vc = segue.destinationViewController as! PhotoDetailsViewController
        
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        
        
        let cell = sender as! TableViewCell
        vc.image = cell.instafeedImageView.image
        
        let user = self.photos[indexPath!.row]["user"] as! NSDictionary
        let userName = user["full_name"] as! String
        vc.navigationItem.title = "Posted by " + userName
        let caption = self.photos[indexPath!.row]["caption"] as! NSDictionary
        let captionText = caption["text"] as! String
        vc.captionText = captionText
        
    }
    

}
