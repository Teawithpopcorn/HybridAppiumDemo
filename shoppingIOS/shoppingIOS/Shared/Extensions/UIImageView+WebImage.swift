import Kingfisher

extension UIImageView {
    func setImageWithUrlString(_ urlStr: String, placeholder: UIImage? = nil, progress: ((CGFloat) -> ())? = nil, complete: ((UIImage) -> Void)? = nil) {
        
        if let placeholder = placeholder {
            image = placeholder
        }
        
        if let url = URL(string: urlStr) {
            let resource = ImageResource(downloadURL: url, cacheKey: url.absoluteString)
            
            let modifier = AnyModifier { request in
                return request
            }
            
            self.kf.setImage(with: resource,
                             placeholder: image,
                             options: [.requestModifier(modifier)],
                             progressBlock: { (recivedSize, totalSize) in
                                let pro = CGFloat(recivedSize) / CGFloat(totalSize)
                                progress?(pro)
            },
                             completionHandler: { (image, error, type, url) in
                                if let image = image, let completeBlock = complete {
                                    completeBlock(image)
                                }
            })
        }
    }
}

