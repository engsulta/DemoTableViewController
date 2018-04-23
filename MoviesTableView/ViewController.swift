//
//  ViewController.swift
//  MoviesTableView
//
//  Created by JETS Mobile Lab-10 on 3/25/18.
//  Copyright © 2018 JETS Mobile Lab-10. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    
    @IBOutlet weak var moviePic: UIImageView!
    var val: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        movieTitle.text = val?.title
        movieDate.text = val?.releaseYear
        movieRate.text = val?.rating
        movieGenre.text = val?.genre
        
        moviePic.__sd_setImage(with: URL(string: (val?.image!)!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

