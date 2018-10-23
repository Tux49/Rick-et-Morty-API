//
//  DetailView.swift
//  Rick et Morty API
//
//  Created by Thierry Huu on 23/10/2018.
//  Copyright © 2018 Thierry Huu. All rights reserved.
//

import UIKit

class DetailView: UIView {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var characterIV: UIImageView!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var speciesLbl: UILabel!
    @IBOutlet weak var originLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadXib()
    }

    func loadXib() {
        let bundle = Bundle(for: type(of: self))
        if let nibName = type(of: self).description().components(separatedBy: ".").last {
            let nib = UINib(nibName: nibName, bundle: bundle)
            if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
                view.frame = bounds
                addSubview(view)
                view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                view.backgroundColor = .white
                view.layer.cornerRadius = 25
            }
        }
    }
    
    @IBAction func closeAction(_ sender: Any) {
            NotificationCenter.default.post(name: Notification.Name("close"), object: nil)
    }
}
