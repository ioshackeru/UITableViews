//
//  EditMovieViewController.swift
//  AdvancedTableViews
//
//  Created by Tomer Buzaglo on 17/08/2017.
//  Copyright © 2017 iTomerBu. All rights reserved.
//

import UIKit

class EditMovieViewController: UIViewController {
    @IBOutlet var movieTitle: UITextField!

    @IBOutlet weak var image: UIImageView!
    
    var data:Movie!{
        didSet{
            updateUI()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    func updateUI(){
        
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
