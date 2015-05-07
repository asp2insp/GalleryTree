//
//  ViewController.swift
//  GalleryTree
//
//  Created by Josiah Gaskin on 5/6/15.
//  Copyright (c) 2015 Josiah Gaskin. All rights reserved.
//

import UIKit
import Alamofire


class PhotosViewController: UITableViewController {

    var feed: [String: NSDictionary] = [:]
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the height of each cell
        tableView.rowHeight = 320
      
        Alamofire.request(.GET, "https://api.instagram.com/v1/media/popular?client_id=\(API_KEY)")
            .responseJSON { (_, _, JSON, _) in
                if (JSON != nil) {
                    self.feed = JSON as! [String: NSDictionary]
                    self.tableView.reloadData()
                }
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return feed["data"]?.count ?? 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

