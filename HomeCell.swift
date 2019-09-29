//
//  HomeCell.swift
//  righthererightnow
//
//  Created by Nnamdi Okeke on 11/11/15.
//  Copyright © 2015 Oluwatobi Adeleye. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {
    
    @IBOutlet weak var title:UILabel!
    @IBOutlet weak var backImage:UIImageView!
    var more:UIButton!
    var rsv:UIButton!
    var imageMethods:ImageMethods!
    var imageObjects:GlobalImages!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.imageMethods = ImageMethods()
        self.imageObjects = GlobalImages()
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        more = UIButton(frame: CGRect(x: (self.bounds.size.width/2)-50, y: self.frame.size.height-60, width: 37.5, height: 37.5))
        more.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        more.setImage(self.imageObjects.more2, for: UIControlState())
        
        rsv = UIButton(frame: CGRect(x: (self.bounds.size.width/2)+10, y: self.frame.size.height-60, width: 40, height: 40))
        rsv.imageView?.contentMode = UIViewContentMode.scaleAspectFill
        rsv.setImage(self.imageObjects.rsvpImage_Light, for: UIControlState())
        
        
       // self.title.font = QUICK_SAND_REG_28
        
        self.addSubview(more)
        self.addSubview(rsv)


        // Configure the view for the selected state
    }
    
    func cellOnTableView(_ tableView:UITableView, didScrollOnView view:UIView) {
        
        let rectInSuperview = tableView.convert(self.frame, to: view)
        
        let distFromCenter:CGFloat = view.frame.height/2.25 - rectInSuperview.midY
        
        let difference:CGFloat = self.backImage.frame.height - self.frame.height
        let move:CGFloat = (distFromCenter / view.frame.height) * difference
        
        var imageRect:CGRect = self.backImage.frame
        imageRect.origin.y = -(difference/2)+move
        self.backImage.frame = imageRect
        
    }

}
