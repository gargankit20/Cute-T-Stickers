//
//  DetailViewController.swift
//  Cute-T Stickers
//
//  Created by Ankit Garg on 4/21/20.
//  Copyright © 2020 Omni Soft Solutions. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    @IBOutlet var bannerImageView:UIImageView!
    @IBOutlet var packTitleLbl:UILabel!
    @IBOutlet var packDescriptionLbl:UILabel!
    
    var packNumber:Int!
    let numberOfStickers=[0, 24, 24, 18, 12, 24]
    let stickerFormat=["", "GIF", "PNG", "GIF", "GIF", "GIF"]
    let packTitles=["", "Cu-ET", "CuCuCat", "CuCuDuck", "Cute~ Squirrel", "Ha~Me Cat"]
    let packDescriptions=["", "Cu-ET 276 is going to travel to the world \"nice to meet you guys\"", "CuCuCat love you, happy Valentine's Day", "CuCuDuck loves sleeping and crying, hey wu wu~", "I'm not a CAT !_!", "Hello~ every cute cute baby~Welcome to my family O_O"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        bannerImageView.image=UIImage(named:"Banner-\(packNumber!)")
        packTitleLbl.text=packTitles[packNumber]
        packDescriptionLbl.text=packDescriptions[packNumber]
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int)->Int
    {
        return numberOfStickers[packNumber]
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath)->UICollectionViewCell
    {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier:"Cell", for:indexPath) as! StickerCell
        cell.imageView.image=SDAnimatedImage(named:"Pack_\(packNumber!)_\(indexPath.row+1).\(stickerFormat[packNumber])")
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let imagePath=Bundle.main.path(forResource:"Pack_\(packNumber!)_\(indexPath.row+1)", ofType:stickerFormat[packNumber])!
        let shareData=NSData(contentsOfFile:imagePath)
        let items=[shareData as Any]
        let ac=UIActivityViewController(activityItems:items, applicationActivities:nil)
        present(ac, animated:true)
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath)->CGSize
    {
        return CGSize(width:90, height:90)
    }
    
    @IBAction func back()
    {
        dismiss(animated:true, completion:nil)
    }
}
