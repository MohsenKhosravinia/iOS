//
//  ImageCell.swift
//  FlickerFetcher
//
//  Created by Mohsen Khosravinia on 5/20/22.
//

import UIKit
import Kingfisher

class ImageCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    private var flipped: Bool = false {
        didSet {
            imageView.isHidden = flipped
            infoView.isHidden = !flipped
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        titleLabel.text = nil
        flipped = false
    }
    
    public func fill(photo: PhotoModel) {
        guard let url = URL(string: photo.imageUrlString) else { return }
        KF.url(url)
          .placeholder(UIImage(named: "placeholder"))
          .fade(duration: 0.25)
          .set(to: imageView)
        
        titleLabel.text = photo.title
    }
    
    private func setupViews() {
        layer.cornerRadius = 10
        clipsToBounds = true
        
        infoView.layer.cornerRadius = 10
        infoView.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
    }
    
    func flip() {
        let fromView = flipped ? infoView : imageView
        let toView = flipped ? imageView : infoView
        let flipDirection: UIView.AnimationOptions = flipped ? .transitionFlipFromRight : .transitionFlipFromLeft
        let options: UIView.AnimationOptions = [flipDirection, .showHideTransitionViews]
        UIView.transition(from: fromView!, to: toView!, duration: 0.5, options: options) { _ in
            self.flipped.toggle()
        }
    }
}
