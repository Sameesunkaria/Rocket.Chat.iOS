//
//  ChatMessageImageView.swift
//  Rocket.Chat
//
//  Created by Rafael K. Streit on 03/10/16.
//  Copyright © 2016 Rocket.Chat. All rights reserved.
//

import UIKit
import SDWebImage
import FLAnimatedImage

protocol ChatMessageImageViewProtocol: class {
    func openImageFromCell(attachment: Attachment, thumbnail: FLAnimatedImageView)
}

final class ChatMessageImageView: UIView {
    static let defaultHeight = CGFloat(250)
    var isLoadable = true
    var placeholderImage: UIImage?

    weak var delegate: ChatMessageImageViewProtocol?
    var attachment: Attachment! {
        didSet {
            if oldValue != nil && oldValue.identifier == attachment.identifier {
                Log.debug("attachment is cached")
                return
            }

            updateMessageInformation()
        }
    }

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var activityIndicatorImageView: UIActivityIndicatorView!
    @IBOutlet weak var imageView: FLAnimatedImageView! {
        didSet {
            imageView.layer.cornerRadius = 3
            imageView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.1).cgColor
            imageView.layer.borderWidth = 1
        }
    }

    private lazy var tapGesture: UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(didTapView))
    }()

    fileprivate func checkHttpImage(imageURL: URL) {
        if imageURL.absoluteString.starts(with: "http://") {
            isLoadable = false
            labelTitle.text = attachment.title + " (" + localized("alert.insecure_image.title") + ")"
            placeholderImage = UIImage(named: "Insecure Image")
        }
    }

    fileprivate func updateMessageInformation() {
        let containsGesture = gestureRecognizers?.contains(tapGesture) ?? false
        if !containsGesture {
            addGestureRecognizer(tapGesture)
        }

        guard let imageURL = attachment.fullImageURL() else {
            return
        }

        labelTitle.text = attachment.title
        checkHttpImage(imageURL: imageURL)

        activityIndicatorImageView.startAnimating()
        imageView.sd_setImage(with: imageURL, placeholderImage: placeholderImage, completed: { [weak self] _, _, _, _ in
            self?.activityIndicatorImageView.stopAnimating()
        })
    }

    @objc func didTapView() {
        if isLoadable {
            delegate?.openImageFromCell(attachment: attachment, thumbnail: imageView)
        } else {
            Alert(key: "alert.insecure_image").present()
        }
    }
}
