//
//  MoviesTableViewController.swift
//  AdvancedTableViews
//
//  Created by Tomer Buzaglo on 17/08/2017.
//  Copyright © 2017 iTomerBu. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {
    
    //Type Method... (Not an Instance Method)
    var ds:[MovieSet] = MovieDataSource.getMovies()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    //MARK: Inserting Items
    //this is a UIViewController Method:
    //a callback for editing mode change.
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if isSwipe{return}

        tableView.beginUpdates()// call this method whenever we batch multiple operations
        for (i, movieSet) in ds.enumerated(){
            let idx = IndexPath(row: movieSet.movies.count, section: i)
            
            if editing{
                tableView.insertRows(at: [idx], with: .automatic)
            }else{
                tableView.deleteRows(at: [idx], with: .automatic)
            }
        }
        tableView.endUpdates()
    }
    
    //MARK: swipe to delete
    var isSwipe:Bool = false{
        didSet{
            self.navigationItem.rightBarButtonItem?.isEnabled = !isSwipe
        }
    }
    
    override func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        isSwipe = true
    }
    
    override func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        isSwipe = false
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        
        if indexPath.row >= ds[indexPath.section].movies.count{
            return .insert
        }
        
        return .delete
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return ds.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let addition = isEditing ? 1 : 0 // trinary if operator
        return ds[section].movies.count + addition
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
        
        //the section we are in (Genre)
        let section = indexPath.section
        let row = indexPath.row
        
        if ds[section].movies.count == row{
            //tableview recycles
            cell.poster.image = nil
            cell.title.text = "Add A New Movie"
        }
            // Data Binding with the cell...
        else{
            let movie  = ds[section].movies[row]
            
            cell.title?.text = movie.title
            cell.poster?.image = UIImage(named: movie.imageName)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 + 20
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ds[section].genre
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(100)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if we are passing to movieDetailsViewController-> pass the movie in to the dest
        if let dest = segue.destination as? DetailsViewController,
            let movie = sender as? Movie{
            dest.data = movie
        }
        else if let dest = segue.destination as? EditMovieViewController,
            let movie = sender as? Movie{
            dest.data = movie
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row >= ds[indexPath.section].movies.count{
            addNewItem(atIndexPath: indexPath)
            return
        }
        //1) get the movie
        let movie = ds[indexPath.section].movies[indexPath.row]
        
        if isEditing{
            //2) perform the segue with movie as the sender
            performSegue(withIdentifier: "masterToEdit", sender: movie)
            //3) prepare for segue and put the movie in the destination view controller
        }else{
            //2) perform the segue with movie as the sender
            performSegue(withIdentifier: "masterToDetail", sender: movie)
            //3) prepare for segue and put the movie in the destination view controller
        }
      
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            ds[indexPath.section].movies.remove(at: indexPath.row)
            // Delete a new row to the table view
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
          addNewItem(atIndexPath: indexPath)
        }
    }
    
    func addNewItem(atIndexPath indexPath: IndexPath){
        // Create a new instance of the appropriate class, Movie()
        let newMovie = Movie(title: "Your Title Here", genres: [], imageName: "placeholder")
        
        // insert it into the array, //into the datasource you go ds.insert the movie
        let genre = ds[indexPath.section].genre
        newMovie.genres.append(genre)
        
        ds[indexPath.section].movies.append(newMovie)
        
        // and add a new row to the table view //notify the tableview that you add an item
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        
        let section = proposedDestinationIndexPath.section
        var row = proposedDestinationIndexPath.row
        let count = ds[section].movies.count
        
        if row >= count{
            //the fix
            row = count - 1
            if row < 0 {row = 0}
            return IndexPath(row: row, section: section)
        }

        return proposedDestinationIndexPath
    }
 
    //MARK: Rearranging
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        //move in the datasource
        let fromRow = fromIndexPath.row
        let fromSection = fromIndexPath.section
        
        //1) var movie = remove movies(fromIndexPath)
        let movie = ds[fromSection].movies.remove(at: fromRow)
        
        //2) insert movie to (to)
        if to.row >= ds[to.section].movies.count{
            ds[to.section].movies.append(movie)
        }else{
        ds[to.section].movies.insert(movie, at: to.row)
        }
        //notify the tableview
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        if  ds[indexPath.section].movies.count == indexPath.row{
            return false
        }
        return true
    }
}








//MARK: for loops!
/*
 //fori + foreach = enumareted
 for (i, movieSet) in ds.enumerated(){
 
 }
 
 //foreach
 for i in 0...ds.count{
 let ms = ds[i]
 
 }
 
 //fori
 for movieSet in ds{
 
 }
 */
