//
//  ViewController.swift
//  AdvancedTableViews
//
//  Created by Tomer Buzaglo on 17/08/2017.
//  Copyright © 2017 iTomerBu. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    //will not be nil after viewDidLoad
    @IBOutlet var poster: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    
    //property observer.
    var data:Movie!{
        didSet{
            updateUI()
        }
    }
    
    //why the optional ??? ? ?? ?
    //only if the outlet is already connected
    func updateUI(){
        poster?.image = UIImage(named: data.imageName)
        movieTitle?.text = data.title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

