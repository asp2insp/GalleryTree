//
//  ViewController.swift
//  GalleryTree
//
//  Created by Josiah Gaskin on 5/6/15.
//  Copyright (c) 2015 Josiah Gaskin. All rights reserved.
//

import UIKit

class PhotosViewController: UITableViewController {

    let manager = AFHTTPRequestOperationManager()
  
    var feedUrls: [NSURL] = []
  
    func extractUrls(feed: NSDictionary) -> [NSURL] {
        if let feed_data = feed["data"] as? [NSDictionary] {
          
          feedUrls = []
          
          for image_data: NSDictionary in feed_data {
              
              
              if let feed_images = image_data["images"] as? NSDictionary {
                if let feed_low_resolution = feed_images["low_resolution"] as? NSDictionary {
                  if let feed_url = feed_low_resolution["url"] as? String {
                    
                    if let url = NSURL(string: feed_url) {
                      
                        feedUrls.append(url)
                    }
                    
                    
                    
                  }
                }
              }
            }
          
          
        }
      
        return feedUrls
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the height of each cell
        tableView.rowHeight = 320
      
        manager.GET("https://api.instagram.com/v1/media/popular?client_id=\(API_KEY)", parameters: nil, success: { (operation, data) -> Void in
          
            println(data)
          
            if let feed = data as? NSDictionary {
                if let feed_meta = feed["meta"] as? NSDictionary {
                    if feed_meta["code"] as? Int == 200 {
                      
                        self.feedUrls = self.extractUrls(feed)
                        self.tableView.reloadData()
                    }
                }
            }
          
        }) { (operation, error) -> Void in
            println(error.localizedDescription)
        }
      
//      
//        Alamofire.request(.GET, "https://api.instagram.com/v1/media/popular?client_id=\(API_KEY)")
//            .responseJSON { (_, _, JSON, _) in
//                if (JSON != nil) {
//                    self.feed = JSON as! [String: NSDictionary]
//                    self.tableView.reloadData()
//                }
//        }
      
      
    }
  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("instagramPhoto", forIndexPath: indexPath) as! PhotoTableViewCell
      
        cell.displayImage.setImageWithURL(self.feedUrls[indexPath.row] ?? nil)

        return cell
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedUrls.count ?? 0
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

