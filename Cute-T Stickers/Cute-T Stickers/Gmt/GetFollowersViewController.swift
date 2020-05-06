//
//  GetFollowersViewController.swift
//  Cute-T Stickers
//
//  Created by Ankit Garg on 5/6/20.
//  Copyright © 2020 Omni Soft Solutions. All rights reserved.
//

import UIKit
import SDWebImage
import Toast

class GetFollowersViewController: UIViewController, UIWebViewDelegate, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var userImageView:UIImageView!
    @IBOutlet var followersLbl:UILabel!
    @IBOutlet var tableView:UITableView!
    
    var dataArray=["100", "200", "500", "1000", "2000"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title="Get Followers"
        
        userImageView.sd_setImage(with:URL(string:UserDefaults.standard.string(forKey:"profilePicURL")!), completed:nil)
        
        tableView.register(UINib(nibName:"GetLikesCell", bundle:nil), forCellReuseIdentifier:"Cell")
        
        getFollowersDelivered()
    }
        
    func getFollowersDelivered()
    {
        let urlString="http://cutetstickers.co/temp_sticker_status_l.php"
        let baseURL=URL(string:urlString)
        
        let httpClient=AFHTTPClient(baseURL:baseURL)
        let request=httpClient!.request(withMethod:"GET", path:urlString, parameters:nil)
        
        let operation=AFHTTPRequestOperation(request:request! as URLRequest)
        
        httpClient!.registerHTTPOperationClass(AFHTTPRequestOperation.self)
        
        operation!.setCompletionBlockWithSuccess({operation, responseObject in
            let responseDic=try! JSONSerialization.jsonObject(with:responseObject as! Data, options:.mutableContainers) as! NSDictionary
            self.followersLbl.text="Followers delivered: "+(responseDic["delivered"] as! String)+"/"+(responseDic["totalOrdered"] as! String)
        }, failure:{operation, error in
            
        })
        operation!.start()
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int)->Int
    {
        return dataArray.count
    }
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath)->UITableViewCell
    {
        let cell=tableView.dequeueReusableCell(withIdentifier:"Cell") as! GetLikesCell
        
        cell.getLikesBtn.setTitle("Get "+dataArray[indexPath.row]+" Followers", for:.normal)
        cell.getLikesBtn.addTarget(self, action:#selector(openWebView(sender:)), for:.touchUpInside)

        return cell
    }
    
    @objc func openWebView(sender:Any)
    {
        let button=sender as! UIButton
        button.backgroundColor=UIColor(red:92.0/255.0, green:175.0/255.0, blue:164.0/255.0, alpha:1)
                
        let webView=UIWebView(frame:CGRect(x:0, y:0, width:UIScreen.main.bounds.size.width, height:UIScreen.main.bounds.size.height))
        view.addSubview(webView)
        webView.delegate=self
        
        let request=URLRequest(url:URL(string:"http://cutetstickers.co/get_sticker_f.php?userid="+UserDefaults.standard.string(forKey:"userID")!+"&img_url="+UserDefaults.standard.string(forKey:"username")!)!, cachePolicy:.reloadIgnoringLocalCacheData, timeoutInterval:60)
        
        webView.loadRequest(request)
    }
    
    func webView(_ webView:UIWebView, shouldStartLoadWith request:URLRequest, navigationType:UIWebView.NavigationType)->Bool
    {
        return true
    }
    
    func webViewDidStartLoad(_ webView:UIWebView)
    {
        webView.makeToastActivity(CSToastPositionCenter)
    }
    
    func webViewDidFinishLoad(_ webView:UIWebView)
    {
        webView.hideToastActivity()
    }
    
    func webView(_ webView:UIWebView, didFailLoadWithError error:Error)
    {
        webView.hideToastActivity()
    }
}
