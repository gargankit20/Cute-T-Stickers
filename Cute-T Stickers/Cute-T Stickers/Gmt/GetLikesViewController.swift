//
//  GetLikesViewController.swift
//  Cute-T Stickers
//
//  Created by Ankit Garg on 5/6/20.
//  Copyright © 2020 Omni Soft Solutions. All rights reserved.
//

import UIKit
import SDWebImage
import Toast

class GetLikesViewController: UIViewController, UIWebViewDelegate, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var imageView:UIImageView!
    @IBOutlet var likesLbl:UILabel!
    @IBOutlet var tableView:UITableView!
    
    var imgUrl:String!
    var dataArray=["20", "40", "80", "150", "300", "600", "1200", "2500", "5000"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title="Get Likes"
        
        imageView.sd_setImage(with:URL(string:imgUrl), completed:nil)
        
        tableView.register(UINib(nibName:"GetLikesCell", bundle:nil), forCellReuseIdentifier:"Cell")
        
        getLikesDelivered()
    }
    
    override func viewWillAppear(_ animated:Bool)
    {
        tableView.reloadData()
    }
    
    func getLikesDelivered()
    {
        let urlString="http://cutetstickers.co/temp_sticker_status_l.php"
        let baseURL=URL(string:urlString)
        
        let httpClient=AFHTTPClient(baseURL:baseURL)
        let request=httpClient!.request(withMethod:"GET", path:urlString, parameters:nil)
        
        let operation=AFHTTPRequestOperation(request:request! as URLRequest)
        
        httpClient!.registerHTTPOperationClass(AFHTTPRequestOperation.self)
        
        operation!.setCompletionBlockWithSuccess({operation, responseObject in
            let responseDic=try! JSONSerialization.jsonObject(with:responseObject as! Data, options:.mutableContainers) as! NSDictionary
            self.likesLbl.text="Delivered Like count "+(responseDic["delivered"] as! String)+"/"+(responseDic["totalOrdered"] as! String)
        }, failure:{operation, error in
            
        })
        operation!.start()
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int)->Int
    {
        return dataArray.count+1
    }
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath)->UITableViewCell
    {
        let cell=tableView.dequeueReusableCell(withIdentifier:"Cell") as! GetLikesCell
        
        if indexPath.row==0
        {
            cell.getLikesBtn.setTitle("Get Followers", for:.normal)
            cell.getLikesBtn.backgroundColor=colorWithHex(0x78a840)
            cell.getLikesBtn.addTarget(self, action:#selector(getFollowers(sender:)), for:.touchUpInside)
        }
        else
        {
            cell.getLikesBtn.setTitle("Get "+dataArray[indexPath.row-1]+" Likes", for:.normal)
            cell.getLikesBtn.backgroundColor=colorWithHex(0x5ba899)
            cell.getLikesBtn.addTarget(self, action:#selector(openWebView(sender:)), for:.touchUpInside)
        }

        return cell
    }

    @objc func getFollowers(sender:Any)
    {
        let button=sender as! UIButton
        button.backgroundColor=UIColor(red:81.0/255.0, green:158.0/255.0, blue:143.0/255.0, alpha:1)
        
        let VC=GetFollowersViewController(nibName:"GetFollowersViewController", bundle:nil)
        navigationController!.pushViewController(VC, animated:true)
    }
    
    @objc func openWebView(sender:Any)
    {
        let button=sender as! UIButton
        button.backgroundColor=UIColor(red:92.0/255.0, green:175.0/255.0, blue:164.0/255.0, alpha:1)
        
        let data=imgUrl.data(using:.utf8)
        let base64Encoded=data!.base64EncodedString()
        
        let webView=UIWebView(frame:CGRect(x:0, y:0, width:UIScreen.main.bounds.size.width, height:UIScreen.main.bounds.size.height))
        view.addSubview(webView)
        webView.delegate=self
        
        let request=URLRequest(url:URL(string:"http://cutetstickers.co/get_sticker_l.php?userid="+UserDefaults.standard.string(forKey:"userID")!+"&img_url="+base64Encoded)!, cachePolicy:.reloadIgnoringLocalCacheData, timeoutInterval:60)
        
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
    
    func colorWithHex(_ hexColor:Int)->UIColor
    {
        let red=CGFloat((hexColor&0xFF0000)>>16)/255.0
        let green=CGFloat((hexColor&0x00FF00)>>8)/255.0
        let blue=CGFloat(hexColor&0x0000FF)/255.0
        return UIColor(red:red, green:green, blue:blue, alpha:1)
    }
}
