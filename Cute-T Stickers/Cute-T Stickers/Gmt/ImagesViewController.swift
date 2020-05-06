//
//  ImagesViewController.swift
//  Cute-T Stickers
//
//  Created by Ankit Garg on 5/6/20.
//  Copyright © 2020 Omni Soft Solutions. All rights reserved.
//

import UIKit
import MessageUI
import Toast
import StoreKit

class ImagesViewController: UIViewController, MFMailComposeViewControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    @IBOutlet var collectionView:UICollectionView!
    @IBOutlet var settingsView:UIView!
    
    var smallThumbnailsArray:NSMutableArray!
    var largeThumbnailsArray:NSMutableArray!
    var likesCountArray:NSMutableArray!
    var shortCodesArray:NSMutableArray!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName:"ImageCell", bundle:nil), forCellWithReuseIdentifier:"Cell")
    }
    
    override func viewWillAppear(_ animated:Bool)
    {
        self.title="Get Likes"
        
        smallThumbnailsArray=NSMutableArray()
        largeThumbnailsArray=NSMutableArray()
        likesCountArray=NSMutableArray()
        shortCodesArray=NSMutableArray()
        
        if let _=UserDefaults.standard.string(forKey:"userID")
        {
            getAllPhotos()
        }
        else
        {
            let VC=LoginViewController(nibName:"LoginViewController", bundle:nil)
            VC.modalPresentationStyle = .fullScreen
            present(VC, animated:true)
        }
    }
    
    func getAllPhotos()
    {
        view.makeToastActivity(CSToastPositionCenter)
        
        let urlString="https://www.instagram.com/graphql/query/?query_id=17888483320059182&variables={\"first\":100,\"id\":\"\(UserDefaults.standard.string(forKey:"userID")!)\"}".addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!
        let baseURL=URL(string:urlString)
        
        let httpClient=AFHTTPClient(baseURL:baseURL)
        let request=httpClient!.request(withMethod:"GET", path:urlString, parameters:nil)
        
        let operation=AFHTTPRequestOperation(request:request! as URLRequest)
        
        httpClient!.registerHTTPOperationClass(AFHTTPRequestOperation.self)
        
        operation!.setCompletionBlockWithSuccess({operation, responseObject in
            
            self.view.hideToastActivity()
            
            let responseDic=try! JSONSerialization.jsonObject(with:responseObject as! Data, options:.mutableContainers) as! NSDictionary
            let dataDic=responseDic["data"] as! NSDictionary
            let userDic=dataDic["user"] as! NSDictionary
            let mediaDic=userDic["edge_owner_to_timeline_media"] as! NSDictionary
            let edgesArray=mediaDic["edges"] as! NSArray
            
            for i in 0..<edgesArray.count
            {
                let edgeDic=edgesArray[i] as! NSDictionary
                let nodeDic=edgeDic["node"] as! NSDictionary
                let likesDic=nodeDic["edge_media_preview_like"] as! NSDictionary
                let thumbnailsArray=nodeDic["thumbnail_resources"] as! NSArray
                let zeroDic=thumbnailsArray[0] as! NSDictionary
                let secondDic=thumbnailsArray[2] as! NSDictionary
                
                self.smallThumbnailsArray.add(zeroDic["src"] as! String)
                self.largeThumbnailsArray.add(secondDic["src"] as! String)
                self.likesCountArray.add(likesDic["count"] as! Int)
                self.shortCodesArray.add(nodeDic["shortcode"] as! String)
            }
            
            self.collectionView.reloadData()
        }, failure:{operation, error in
            self.getTemporaryData()
        })
        operation!.start()
    }
    
    @IBAction func pressRate()
    {
        if #available(iOS 10.3, *)
        {
            SKStoreReviewController.requestReview()
        }
        else
        {
            UIApplication.shared.open(URL(string:"itms-apps://itunes.apple.com/app/id1508943983")!, options:[:], completionHandler:nil)
        }
    }
    
    @IBAction func pressEmail()
    {
        if MFMailComposeViewController.canSendMail()
        {
            let mail=MFMailComposeViewController()
            mail.mailComposeDelegate=self
            mail.setToRecipients(["2047636989@qq.com"])
            mail.setSubject("Cool like")
            mail.setMessageBody("Type here for the problems/issues you have in this app", isHTML:false)
            present(mail, animated:true, completion:nil)
        }
        else
        {
            createAlertView("Something is going wrong", "Please check if you have email added in Settings -> Mail, Contacts, Calendars")
        }
    }
    
    func mailComposeController(_ controller:MFMailComposeViewController, didFinishWith result:MFMailComposeResult, error:Error?)
    {
        switch result
        {
        case .cancelled:
            break;
        case .saved:
            break;
        case .sent:
            break;
        case .failed:
            failMail()
            break;
        default:
            break;
        }
        
        dismiss(animated:true)
    }
    
    func failMail()
    {
        createAlertView("Failed", "Please try to send it again")
    }

    @IBAction func pressLogout()
    {
        let appDomain=Bundle.main.bundleIdentifier
        UserDefaults.standard.removePersistentDomain(forName:appDomain!)
        
        dismiss(animated:true)
    }
    
    @IBAction func showHideSettingsView()
    {
        if settingsView.isHidden
        {
            settingsView.isHidden=false
        }
        else
        {
            settingsView.isHidden=true
        }
    }
    
    func createAlertView(_ title:String, _ message:String)
    {
        let alertController=UIAlertController(title:title, message:message, preferredStyle:.alert)
        alertController.addAction(UIAlertAction(title:"ok", style:.default, handler:nil))
        present(alertController, animated:true)
    }
    
    func getTemporaryData()
    {
        let urlString=UserDefaults.standard.string(forKey:"a2")!+"/get_img.php"
        let baseURL=URL(string:urlString)
        
        let httpClient=AFHTTPClient(baseURL:baseURL)
        let request=httpClient!.request(withMethod:"GET", path:urlString, parameters:nil)
        
        let operation=AFHTTPRequestOperation(request:request! as URLRequest)
        
        httpClient!.registerHTTPOperationClass(AFHTTPRequestOperation.self)
        
        operation!.setCompletionBlockWithSuccess({operation, responseObject in
            let responseArray=try! JSONSerialization.jsonObject(with:responseObject as! Data, options:.mutableContainers) as! NSArray
            
            for i in 0..<responseArray.count
            {
                let tempDic=responseArray[i] as! NSDictionary
                
                self.smallThumbnailsArray.add(tempDic["link"] as! String)
            }
            
            self.collectionView.reloadData()
        }, failure:{operation, error in
            
        })
        operation!.start()
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int)->Int
    {
        return smallThumbnailsArray.count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath)->UICollectionViewCell
    {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier:"Cell", for:indexPath) as! ImageCell

        cell.imageView.sd_setImage(with:URL(string:smallThumbnailsArray[indexPath.row] as! String), completed:nil)
        cell.likesLbl.text="\(likesCountArray[indexPath.row] as! Int)"
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let VC=GetLikesViewController(nibName:"GetLikesViewController", bundle:nil)
        VC.imgUrl=largeThumbnailsArray[indexPath.row] as? String
        navigationController?.pushViewController(VC, animated:true)
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath)->CGSize
    {
        return CGSize(width:(collectionView.frame.size.width-10)/3, height:130)
    }
}
