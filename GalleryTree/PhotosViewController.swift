//
//  ViewController.swift
//  GalleryTree
//
//  Created by Josiah Gaskin on 5/6/15.
//  Copyright (c) 2015 Josiah Gaskin. All rights reserved.
//

import UIKit
import Alamofire

class PhotosViewController: UIViewController {

    var feed: [String: NSDictionary] = [:]
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSLog("KEY: \(API_KEY), SECRET: \(API_SECRET)")
      
        Alamofire.request(.GET, "https://api.instagram.com/v1/media/popular?client_id=\(API_KEY)")
            .responseJSON { (_, _, JSON, _) in
                if (JSON != nil) {
                    self.feed = JSON as! [String: NSDictionary]
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

