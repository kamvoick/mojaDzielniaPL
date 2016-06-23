//
//  PostsCell.swift
//  MojaOśka
//
//  Created by Kamil Wójcik on 06.06.2016.
//  Copyright © 2016 Kamil Wójcik. All rights reserved.
//

import UIKit

class PostsCell: UITableViewCell {

    @IBOutlet weak var wsadzImg: UIImageView!
    @IBOutlet weak var wsadzTytuł: UILabel!
    @IBOutlet weak var wsadzOpis: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    
        wsadzImg.layer.cornerRadius = 15.0
        wsadzImg.clipsToBounds = true
        
    }

    func skonfigurujKomórkę(post: Post){
        wsadzTytuł.text = post.tytuł
        wsadzOpis.text = post.opis
        wsadzImg.image = Singleton.dzielony.obrazekDlaŚcieżki(post.ścieżkaObrazka)
    }
    
    
    
    
    
//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
