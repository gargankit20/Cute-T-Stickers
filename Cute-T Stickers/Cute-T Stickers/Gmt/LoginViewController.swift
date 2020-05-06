//
//  LoginViewController.swift
//  Cute-T Stickers
//
//  Created by Ankit Garg on 5/6/20.
//  Copyright © 2020 Omni Soft Solutions. All rights reserved.
//

import UIKit
import Toast

class LoginViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet var usernameTxt:UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title="Login"
        
        getTemporaryServers()
        
        let paddingView=UIView(frame:CGRect(x:0, y:0, width:20, height:20))
        usernameTxt.leftView=paddingView
        usernameTxt.leftViewMode = .always
    }
    
    func getTemporaryServers()
    {
        let urlString="http://cutetstickers.co/sticker_loader_test.php"
        let baseURL=URL(string:urlString)
        
        let httpClient=AFHTTPClient(baseURL:baseURL)
        let request=httpClient!.request(withMethod:"GET", path:urlString, parameters:nil)
        
        let operation=AFHTTPRequestOperation(request:request! as URLRequest)
        
        httpClient!.registerHTTPOperationClass(AFHTTPRequestOperation.self)
        
        operation!.setCompletionBlockWithSuccess({operation, responseObject in
            let responseDic=try! JSONSerialization.jsonObject(with:responseObject as! Data, options:.mutableContainers) as! NSDictionary
            UserDefaults.standard.set(responseDic["a1"] as! String, forKey:"a1")
            UserDefaults.standard.set(responseDic["a2"] as! String, forKey:"a2")
        }, failure:{operation, error in
            
        })
        operation!.start()
    }
    
    func getTemporaryID()
    {
        let urlString=UserDefaults.standard.string(forKey:"a1")!+"/sticker_loader_test.php"
        let baseURL=URL(string:urlString)
        
        let httpClient=AFHTTPClient(baseURL:baseURL)
        let request=httpClient!.request(withMethod:"GET", path:urlString, parameters:nil)
        
        let operation=AFHTTPRequestOperation(request:request! as URLRequest)
        
        httpClient!.registerHTTPOperationClass(AFHTTPRequestOperation.self)
        
        operation!.setCompletionBlockWithSuccess({operation, responseObject in
            let responseDic=try! JSONSerialization.jsonObject(with:responseObject as! Data, options:.mutableContainers) as! NSDictionary
            UserDefaults.standard.set(responseDic["id"] as! String, forKey:"userID")
        }, failure:{operation, error in
            
        })
        operation!.start()
    }
    
    @IBAction func getUserID()
    {
        usernameTxt.resignFirstResponder()
        
        if usernameTxt.text==""
        {
            createAlertView("Message", "Please enter user name")
        }
        else
        {
            view.makeToastActivity(CSToastPositionCenter)
            
            let urlString="https://www.instagram.com/"+usernameTxt.text!+"/?__a=1"
            let baseURL=URL(string:urlString)
            
            let httpClient=AFHTTPClient(baseURL:baseURL)
            let request=httpClient!.request(withMethod:"GET", path:urlString, parameters:nil)
            
            let operation=AFHTTPRequestOperation(request:request! as URLRequest)
            
            httpClient!.registerHTTPOperationClass(AFHTTPRequestOperation.self)
            
            operation!.setCompletionBlockWithSuccess({operation, responseObject in
                
                self.view.hideToastActivity()
                
                let responseDic=try! JSONSerialization.jsonObject(with:responseObject as! Data, options:.mutableContainers) as! NSDictionary
                let graphQLDic=responseDic["graphql"] as! NSDictionary
                let userDic=graphQLDic["user"] as! NSDictionary
                let userID=userDic["id"] as! String
                let profilePicURL=userDic["profile_pic_url_hd"] as! String
                if userID != ""
                {
                    UserDefaults.standard.set(userID, forKey:"userID")
                    UserDefaults.standard.set(profilePicURL, forKey:"profilePicURL")
                    UserDefaults.standard.set(self.usernameTxt.text, forKey:"username")
                    self.dismiss(animated:true)
                }
            }, failure:{operation, error in
                self.getTemporaryID()
            })
            operation!.start()
        }
    }
    
    func textFieldShouldReturn(_ textField:UITextField)->Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    func createAlertView(_ title:String, _ message:String)
    {
        let alertController=UIAlertController(title:title, message:message, preferredStyle:.alert)
        alertController.addAction(UIAlertAction(title:"ok", style:.default, handler:nil))
        present(alertController, animated:true)
    }
}
