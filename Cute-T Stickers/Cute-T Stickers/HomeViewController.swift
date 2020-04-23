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
    override func viewDidLoad()
    {
        super.viewDidLoad()
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
