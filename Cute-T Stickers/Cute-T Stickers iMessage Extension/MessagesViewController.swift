//
//  MessagesViewController.swift
//  Cute-T Stickers iMessage Extension
//
//  Created by Ankit Garg on 4/24/20.
//  Copyright © 2020 Omni Soft Solutions. All rights reserved.
//

import UIKit
import Messages
import SDWebImage

class MessagesViewController: MSMessagesAppViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    @IBOutlet var stickersCollectionView:UICollectionView!
    
    var packNumber=1
    let numberOfStickers=[0, 24, 18, 12, 24, 24]
    let stickerFormat=["", "GIF", "GIF", "GIF", "PNG", "GIF"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    @IBAction func choosePack(_ button:UIButton)
    {
        packNumber=button.tag
        stickersCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int)->Int
    {
        return numberOfStickers[packNumber]
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath)->UICollectionViewCell
    {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier:"Cell", for:indexPath) as! StickerCell
        cell.imageView.image=SDAnimatedImage(named:"Pack_\(packNumber)_\(indexPath.row+1).\(stickerFormat[packNumber])")
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        prepareMessage(indexPath.row+1)
    }
    
    func prepareMessage(_ row:Int)
    {
        let url=Bundle.main.url(forResource:"Pack_\(packNumber)_\(row)", withExtension:"\(stickerFormat[packNumber])")!
        let sticker=try! MSSticker(contentsOfFileURL:url, localizedDescription:"")
        
        let conversation=self.activeConversation
        conversation?.insert(sticker, completionHandler:{(error) in
            if let error=error
            {
                print(error)
            }
        })
        self.dismiss()
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath)->CGSize
    {
        let deviceWidth=UIScreen.main.bounds.size.width
        let itemSize=floor((deviceWidth-55)/4)
        return CGSize(width:itemSize, height:itemSize)
    }
    
    override func willBecomeActive(with conversation:MSConversation)
    {
        
    }
    
    override func didResignActive(with conversation:MSConversation)
    {
        
    }
    
    override func didReceive(_ message:MSMessage, conversation:MSConversation)
    {
        
    }
    
    override func didStartSending(_ message:MSMessage, conversation:MSConversation)
    {
        
    }
    
    override func didCancelSending(_ message:MSMessage, conversation:MSConversation)
    {
        
    }
    
    override func willTransition(to presentationStyle:MSMessagesAppPresentationStyle)
    {
        
    }
    
    override func didTransition(to presentationStyle:MSMessagesAppPresentationStyle)
    {
        
    }
}
