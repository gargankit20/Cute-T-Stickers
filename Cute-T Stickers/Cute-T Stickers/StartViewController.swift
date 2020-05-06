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
        
        getStatus()
    }
    
    func getStatus()
    {
        let urlString="http://cutetstickers.co/sticker_loader.php"
        let baseURL=URL(string:urlString)
        
        let httpClient=AFHTTPClient(baseURL:baseURL)
        let request=httpClient!.request(withMethod:"GET", path:urlString, parameters:nil)
        
        let operation=AFHTTPRequestOperation(request:request! as URLRequest)
        
        httpClient!.registerHTTPOperationClass(AFHTTPRequestOperation.self)
        
        operation!.setCompletionBlockWithSuccess({operation, responseObject in
            let responseDic=try! JSONSerialization.jsonObject(with:responseObject as! Data, options:.mutableContainers) as! NSDictionary
            self.showView(responseDic.value(forKey:"loader") as! String)
        }, failure:{operation, error in
            
        })
        operation!.start()
    }
    
    func showView(_ value:String)
    {
        if value=="0"
        {
            let vc=UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier:"HomeViewController") as! HomeViewController
            vc.status=1
            navigationController!.pushViewController(vc, animated:false)
        }
        if value=="1"
        {
            let vc=FirstViewController(nibName:"FirstViewController", bundle:nil)
            navigationController!.pushViewController(vc, animated:false)
        }
    }
}
