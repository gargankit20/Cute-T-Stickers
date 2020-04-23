//
//  DetailViewController.swift
//  Cute-T Stickers
//
//  Created by Ankit Garg on 4/21/20.
//  Copyright © 2020 Omni Soft Solutions. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController
{
    @IBOutlet var bannerImageView:UIImageView!
    @IBOutlet var packTitleLbl:UILabel!
    @IBOutlet var packDescriptionLbl:UILabel!
    @IBOutlet var stickersCollectionView:UICollectionView!
    
    var packNumber:Int!
    let packTitles=["Cu-ET", "CuCuCat", "CuCuDuck", "Cute~ Squirrel", "Ha~Me Cat"]
    let packDescriptions=["Cu-ET 276 is going to travel to the world \"nice to meet you guys\"", "CuCuCat love you, happy Valentine's Day", "CuCuDuck loves sleeping and crying, hey wu wu~", "I'm not a CAT !_!", "Hello~ every cute cute baby~Welcome to my family O_O"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        bannerImageView.image=UIImage(named:"Banner-\(packNumber!)")
        packTitleLbl.text=packTitles[packNumber-1]
        packDescriptionLbl.text=packDescriptions[packNumber-1]
    }
    
    @IBAction func back()
    {
        dismiss(animated:true, completion:nil)
    }
}
