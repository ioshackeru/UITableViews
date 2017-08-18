//
//  Movie.swift
//  AdvancedTableViews
//
//  Created by Tomer Buzaglo on 17/08/2017.
//  Copyright © 2017 iTomerBu. All rights reserved.
//

import UIKit

class Movie : CustomStringConvertible{
    
    //Properties:
    //title
    var title:String
    //genres [String]
    var genres:[String]
    //imageName -> Assets...
    var imageName:String
    
    //initializer
    init(title:String, genres:[String], imageName:String) {
        self.title = title
        self.genres = genres
        self.imageName = imageName
    }
    
    //description
    var description: String{
        return "\(title)\n\(genres)\n\(imageName)"
    }
}
