//
//  LargeFeedCell.swift
//  righthererightnow
//
//  Created by Nnamdi Okeke on 8/3/15.
//  Copyright (c) 2015 Oluwatobi Adeleye. All rights reserved.
//

import UIKit

class LargeFeedCell: UITableViewCell {
    
    var cellFrame:CGRect = CGRect()
    var feedObj:feedObject = feedObject()
    
    var initRects:NSMutableArray = NSMutableArray()
    var recRects:NSMutableArray = NSMutableArray()
    var loaded:Bool = false;
    
    var TOP_PADDING:CGFloat = 30.0
    
    var tagString = ""
    
    var tagLabel:UILabel!
    
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, framee:CGRect) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.cellFrame = framee
        self.prepareForReuse()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.loaded = false
        //self.cellFrame = CGRectMake(0, 0, width, 200)
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setFeedObject(_ feed:feedObject) {
        
        print("SETFEEDOBJ START")
        self.feedObj = feed
        
        self.backgroundColor = UIColor.white
        
        self.processInitPositions(self.feedObj.connectIDs)
        
        if (listOfUserTags.contains(self.feedObj.tag)) {
            self.processReceiverPositions(self.feedObj.otherperson)
        } else {
            self.processReceiverPositions(self.feedObj.events)
        }
        /*
        self.textBack = UIView(frame: CGRectMake(0, 0, self.cellFrame.width, 40))
        self.textBack.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        self.addSubview(self.textBack)
        */
        self.tagString = self.feedObj.tagString
        setLabel(true)
        
        self.loaded = true;
        

        print("SETFEEDOBJ sUCCESS")
        
    }
    
    var textBack:UIView!
    
    func setLabel(_ dark:Bool) {
        
        print("SETLABEL START")
        
        self.tagLabel = UILabel(frame: CGRect(x: self.cellFrame.width/5, y: 0, width: self.cellFrame.width-((self.cellFrame.width/5)+10), height: self.cellFrame.height/2))
        self.tagLabel.font = AVENIR_REG_12
        if (dark) {
            self.tagLabel.textColor = UIColor.black
        } else {
            self.tagLabel.textColor = UIColor.white
        }
        self.tagLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        self.tagLabel.numberOfLines = 2
        
        self.tagLabel.text = self.tagString
        self.tagLabel.numberOfLines = 2
    
        self.addSubview(self.tagLabel)
        print("SETlABEL sUCCESS")
        
        
        
    }
    
    func processReceiverPositions(_ list:NSMutableArray) {
        
        
        print("PROCESS RECEIVER START")
        let recSize:CGFloat = self.cellFrame.width/5
       /*
        if (list.count == 1) {
            
            
                
            var rect:CGRect = CGRectMake((recSize+(recSize/2)-30), 50, 60, 60)
            self.recRects.addObject(NSValue(CGRect:rect))
            
            
        } else if (list.count == 2) {
            
            var rect:CGRect = CGRectMake(recSize+(recSize/3)-30, 50, 60, 60)
            self.recRects.addObject(NSValue(CGRect:rect))
            
            var rect2:CGRect = CGRectMake(recSize+((recSize/3)*2)-30, 50, 60, 60)
            self.recRects.addObject(NSValue(CGRect:rect2))
            
        } else if (list.count == 3) {
            
            var rect:CGRect = CGRectMake(recSize, 50, 60, 60)
            self.recRects.addObject(NSValue(CGRect:rect))
            
            var rect2:CGRect = CGRectMake((recSize)+(recSize/2)-35, 50, 60, 60)
            self.recRects.addObject(NSValue(CGRect:rect2))
            
            
            var rect3:CGRect = CGRectMake((recSize*2)-70, 50, 60, 60)
            self.recRects.addObject(NSValue(CGRect:rect3))
            
        } else {
            */
            let tileWidth:CGFloat = 30
            let tileHeight:CGFloat = 30
            
            for (i in 0 ..< list.count) {
                var yFloat:CGFloat!
                let xFloat:CGFloat = recSize + ((tileWidth+10)*CGFloat(i))
                
                if (i <= 5) {
                    yFloat = self.cellFrame.size.height/2;
                } else {
                    yFloat = 50 + tileHeight + 10
                }
                
                let rect:CGRect = CGRect(x: xFloat, y: yFloat, width: tileWidth, height: tileHeight)
                self.recRects.add(NSValue(cgRect:rect))
                
            }
            
       // }
        print("PROCESS RECEIVER sUCCESS")
    }
    
    func processInitPositions(_ list:NSMutableArray) {
        
        print("PROCESS INIT START")
        
        let recSize:CGFloat = self.cellFrame.height/2-20
        
        if (list.count == 1) {
            
            
            
            let rect:CGRect = CGRect(x: 10, y: 15, width: 30, height: 30)
            self.initRects.add(NSValue(cgRect:rect))
            
            
        } else if (list.count == 2) {
            
            let rect:CGRect = CGRect(x: 0+(recSize/3)-30, y: 50, width: 60, height: 60)
            self.initRects.add(NSValue(cgRect:rect))
            
            let rect2:CGRect = CGRect(x: 0+((recSize/3)*2)-30, y: 50, width: 60, height: 60)
            self.initRects.add(NSValue(cgRect:rect2))
            
        } else if (list.count == 3) {
            
            let rect:CGRect = CGRect(x: recSize+10, y: 50, width: 60, height: 60)
            self.initRects.add(NSValue(cgRect:rect))
            
            let rect2:CGRect = CGRect(x: (recSize)+(recSize/2)-30, y: 50, width: 60, height: 60)
            self.initRects.add(NSValue(cgRect:rect2))
            
            
            let rect3:CGRect = CGRect(x: (recSize*2)-65, y: 50, width: 60, height: 60)
            self.initRects.add(NSValue(cgRect:rect3))
            
        } else {
            
            let tileWidth:CGFloat = 40
            let tileHeight:CGFloat = 40
            
            for (i in 0 ..< list.count) {
                var yFloat:CGFloat!
                let xFloat:CGFloat = 0 + ((recSize/4 * CGFloat((i%3)+1))-20)
                
                if (i <= 2) {
                    yFloat = 50;
                } else {
                    yFloat = 50 + tileHeight + 10
                }
                
                let rect:CGRect = CGRect(x: xFloat, y: yFloat, width: tileWidth, height: tileHeight)
                self.initRects.add(NSValue(cgRect:rect))
                
            }

            
        }
        
        print("SET INIT sUCCESS")

        
    }
    
    override func prepareForReuse() {
        
        self.contentView.removeFromSuperview()
        self.frame = self.cellFrame;
        
        
    }
    
}

///_------------------






///-


