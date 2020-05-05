//
//  StartViewController.swift
//  Cute-T Stickers
//
//  Created by Ankit Garg on 5/5/20.
//  Copyright © 2020 Omni Soft Solutions. All rights reserved.
//

import UIKit

class StartViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        showView("rowinrow")
    }
    
    func showView(_ value:String)
    {
        if value=="straight"
        {
            let vc=UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier:"HomeViewController") as! HomeViewController
            vc.status=1
            navigationController!.pushViewController(vc, animated:false)
        }
        if value=="rowinrow"
        {
            let vc=FirstViewController(nibName:"FirstViewController", bundle:nil)
            navigationController!.pushViewController(vc, animated:false)
        }
    }
}
