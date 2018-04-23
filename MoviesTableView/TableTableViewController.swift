//
//  TableTableViewController.swift
//  MoviesTableView
//
//  Created by JETS Mobile Lab-10 on 3/25/18.
//  Copyright © 2018 JETS Mobile Lab-10. All rights reserved.
//

import UIKit
import SDWebImage
import EDStarRating

class TableTableViewController: UITableViewController,AddMovie {
    var selectedMovie : Movie?
     var movies = [Movie]()
    var networkIndecator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkIndecator.center = view.center
        networkIndecator.startAnimating()
        view.addSubview(networkIndecator)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let  url = URL(string: "https://api.androidhive.info/json/movies.json")
        
        let request = URLRequest(url: url!)
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request, completionHandler: {(data , response , error) in
            do{
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [Dictionary<String, NSObject>]
                
                //var firstDictionary = json[0]
                print(json)
                
                for movieDict in json!{
                    var movie = Movie()
                    movie.title = movieDict["title"] as? String
                    let test = movieDict["rating"] as? Double
                    
                    movie.rating = String(format: "%0.2f",test!)
                    movie.image = movieDict["image"] as? String
                    let test2 = movieDict["releaseYear"] as? Double
                    
                    movie.releaseYear = String(format: "%0.0f",test2!)
                    
                    let genrasArr : [String] = (movieDict["genre"] as? [String])!
                    var str = ""
                    for item in genrasArr{
                        str += item + " ,"
                    }
                    movie.genre = str
                    
                    self.movies.append(movie)
                }
               
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.networkIndecator.stopAnimating()
                    
                    self.tableView.reloadData()

                })
                
            }catch {
                
                
                print(error)
            }
            
            
            
        })
        
        
        
        
        task.resume();

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }

    func addMovieToList(_ newMovie : Movie){
        movies.append(newMovie);
        self.tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let moviePic : UIImageView = cell.viewWithTag(1) as! UIImageView
        
        let movieName : UILabel = cell.viewWithTag(2) as! UILabel
        let movieRate : UILabel = cell.viewWithTag(3) as! UILabel
        let movieDate : UILabel = cell.viewWithTag(4) as! UILabel
        
        /*var moviePic = cell.viewWithTag(7
            ) as! UIImageView*/
        
        movieName.text = movies[indexPath.row].title
        movieRate.text = movies[indexPath.row].rating
        movieDate.text = movies[indexPath.row].releaseYear
        
        let starRating = EDStarRating()
        starRating.starImage = UIImage(contentsOfFile: "star.png")
        
        starRating.starHighlightedImage = UIImage(contentsOfFile: "starhighlighted.png")
        starRating.maxRating = 5;
        //starRating.delegate = self;
        starRating.horizontalMargin = 12;
        starRating.editable = true;
        starRating.displayMode = UInt(EDStarRatingDisplayFull) ;
        
        
        starRating.rating = 2;
        starRating.center = cell.contentView.center
        
        cell.contentView.addSubview(starRating)
        
        moviePic.__sd_setImage(with: URL(string: movies[indexPath.row].image!))
        
        //moviePic.sd_setImage(with: NSURL(string: movies[indexPath.row].i), placeholderImage: UIImage(named: "placeholder.png"))

        

        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMovie = movies[indexPath.row]
        
        
        let second  = self.storyboard?.instantiateViewController(withIdentifier: "details") as! ViewController
        
        second.val = selectedMovie
        self.navigationController?.pushViewController(second, animated: true)
    }
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
  
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detail = segue.destination as! DetailsViewController
        
        detail.myProtocol = self
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
}
