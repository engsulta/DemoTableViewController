//
//  DetailsViewController.swift
//  MoviesTableView
//
//  Created by JETS Mobile Lab-10 on 3/25/18.
//  Copyright © 2018 JETS Mobile Lab-10. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var genraField: UITextField!
    @IBOutlet weak var releaseField: UITextField!
    @IBOutlet weak var rateField: UITextField!
    @IBOutlet weak var titleMovie: UITextField!
    @IBOutlet weak var imageMovie: UITextField!
    
    var myProtocol : AddMovie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func doneAction(_ sender: AnyObject) {
        var movie : Movie = Movie()
        movie.genre = genraField.text
        movie.image = imageMovie.text
        movie.rating = rateField.text
        movie.title = titleMovie.text
        movie.releaseYear = releaseField.text

        myProtocol?.addMovieToList(movie)
        
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
