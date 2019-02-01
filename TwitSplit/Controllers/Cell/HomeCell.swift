//
//  HomeCell.swift
//  TwitSplit
//
//  Created by Lu Kien Quoc on 2/1/19.
//  Copyright © 2019 Lu Kien Quoc. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var vWrapper: UIView!
    @IBOutlet weak var lblMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    override func layoutSubviews() {
        super.layoutSubviews()
        drawShadow()
    }

    private func drawShadow() {
        vWrapper.layer.cornerRadius = 8
        vWrapper.layer.shadowOffset = CGSize(width: 0, height: 2)
        vWrapper.layer.shadowRadius = 2
        vWrapper.layer.shadowOpacity = 0.5
        
    }

    func updateCell(data: MessageData) {
        lblMessage.text = data.message
    }

}
