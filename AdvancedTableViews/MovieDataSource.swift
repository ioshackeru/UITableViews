//
//  MovieDataSource.swift
//  AdvancedTableViews
//
//  Created by Tomer Buzaglo on 17/08/2017.
//  Copyright © 2017 iTomerBu. All rights reserved.
//

import UIKit

class MovieDataSource {
    
    static func getMovies() -> [MovieSet]{
        var comedy = [Movie]()
        var action = [Movie]()
        //init a bounch of movies and add them to an Array of MovieSets
        for _ in 0...1{
            comedy.append(Movie(title: "The Boss Baby", genres: ["Comedy"], imageName: "bossbaby"))
            comedy.append(Movie(title: "Zach Braff", genres: ["Comedy"], imageName: "ZachBraff"))
            comedy.append(Movie(title: "CHiPS (2017)", genres: ["Comdey"], imageName: "CHiPS"))
            comedy.append(Movie(title: "Smurfs", genres: ["Comedy"], imageName: "smurfs"))

            action.append(Movie(title: "Logan the Wolverine", genres: ["action"], imageName: "logan"))
            
           action.append(Movie(title: "The Amazing Spider-Man", genres: ["action"], imageName: "spiderman"))
 
        }
        
        var data = [MovieSet]()
        data.append(MovieSet(genre: "Comedy", movies: comedy))
        data.append(MovieSet(genre: "Action", movies: action))
        
        return data
    }
}

class MovieSet : CustomStringConvertible{
    //Properties:
    var genre:String
    var movies:[Movie]
    
    //init
    init(genre:String, movies:[Movie]) {
        self.genre = genre
        self.movies = movies
    }
    
    //description
    var description: String{
        return "\(genre)\n\(movies)"
    }
}
