//
//  HomeViewController.swift
//  Cute-T Stickers
//
//  Created by Ankit Garg on 4/21/20.
//  Copyright © 2020 Omni Soft Solutions. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController
{
    @IBOutlet var categoriesViewHeightConstraint:NSLayoutConstraint!
    @IBOutlet var categoriesLeftViewWidthConstraint:NSLayoutConstraint!
    @IBOutlet var categoriesRightViewWidthConstraint:NSLayoutConstraint!
    @IBOutlet var bottomBarLeftViewWidthConstraint:NSLayoutConstraint!
    @IBOutlet var bottomBarRightViewWidthConstraint:NSLayoutConstraint!
    @IBOutlet var categoriesViewTopConstraint:NSLayoutConstraint!
    @IBOutlet var bottomBarImageViewHeightConstraint:NSLayoutConstraint!
    @IBOutlet var dotsButtonBottomConstraint:NSLayoutConstraint!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let deviceHeight=UIScreen.main.bounds.size.height
        let categoriesViewHeight=(deviceHeight/568)*240+20
        categoriesViewHeightConstraint.constant=categoriesViewHeight
        
        if UIDevice.current.userInterfaceIdiom == .pad
        {
            let deviceWidth=UIScreen.main.bounds.size.width
            categoriesLeftViewWidthConstraint.constant=(deviceWidth-600)/2
            categoriesRightViewWidthConstraint.constant=(deviceWidth-600)/2
            bottomBarLeftViewWidthConstraint.constant=(deviceWidth-600)/2
            bottomBarRightViewWidthConstraint.constant=(deviceWidth-600)/2
            categoriesViewTopConstraint.constant=180
            bottomBarImageViewHeightConstraint.constant=100
            dotsButtonBottomConstraint.constant=53
        }
    }
    
    @IBAction func choosePack(_ button:UIButton)
    {
        let storyBoard=UIStoryboard(name:"Main", bundle:nil)
        let vc=storyBoard.instantiateViewController(withIdentifier:"DetailViewController") as! DetailViewController
        vc.modalPresentationStyle = .fullScreen
        vc.packNumber=button.tag
        present(vc, animated:true, completion:nil)
    }
}
