//
//  ScrollCell.swift
//  righthererightnow
//
//  Created by Nnamdi Okeke on 11/13/15.
//  Copyright © 2015 Oluwatobi Adeleye. All rights reserved.
//

import UIKit

class ScrollCell: UICollectionViewCell {
    
    
    var title:UILabel!
    var backImage:UIImageView!
    var more:UIButton!
    var rsv:UIButton!
    var imageMethods:ImageMethods!
    var imageObjects:GlobalImages!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageMethods = ImageMethods()
        self.imageObjects = GlobalImages()
        
        let x:CGFloat = -20.0
        let width:CGFloat = frame.size.width+40.0;
        let height:CGFloat = frame.size.height;
        
        backImage = UIImageView(frame: CGRect(x: x, y: 0, width: width, height: height))
        self.addSubview(backImage)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func cellOnTableView(_ tableView:UITableView, didScrollOnView view:UIView) {
        
        let rectInSuperview = tableView.convert(self.frame, to: view)
        
        let distFromCenter:CGFloat = view.frame.width/2.25 - rectInSuperview.midX
        
        let difference:CGFloat = self.backImage.frame.width - self.frame.width
        let move:CGFloat = (distFromCenter / view.frame.width) * difference
        
        var imageRect:CGRect = self.backImage.frame
        imageRect.origin.x = -(difference/2)+move
        self.backImage.frame = imageRect
        
    }
    

    
}
