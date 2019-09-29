//
//  SearchCell.swift
//  righthererightnow
//
//  Created by Nnamdi Okeke on 7/7/15.
//  Copyright (c) 2015 Oluwatobi Adeleye. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.prepareForReuse()
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
    
    override func prepareForReuse() {
        
        self.contentView.removeFromSuperview()
        
        
    }

}
