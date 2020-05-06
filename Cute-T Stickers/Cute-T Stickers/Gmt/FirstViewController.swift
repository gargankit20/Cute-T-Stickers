//
//  FirstViewController.swift
//  Cute-T Stickers
//
//  Created by Ankit Garg on 5/6/20.
//  Copyright © 2020 Omni Soft Solutions. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    @IBAction func useStickers()
    {
        let vc=UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier:"HomeViewController")
        navigationController!.pushViewController(vc, animated:true)
    }
    
    @IBAction func clickGetLikes()
    {
        let VC=ImagesViewController(nibName:"ImagesViewController", bundle:nil)
        
        let navigationController=UINavigationController(rootViewController:VC)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.navigationBar.isTranslucent=false
        
        self.navigationController!.present(navigationController, animated:false, completion:nil)
    }
}
