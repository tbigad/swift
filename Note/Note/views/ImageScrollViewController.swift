//
//  ImageScrollViewController.swift
//  Note
//
//  Created by Pavel N on 7/19/19.
//  Copyright © 2019 Pavel N. All rights reserved.
//

import UIKit

class ImageScrollViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    var images:[UIImage] = [UIImage]()
    
    private var imageViews:[UIImageView] = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageViews.removeAll()
        for image in images {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            scrollView.addSubview(imageView)
            imageViews.append(imageView)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for(index, imageVeiw) in imageViews.enumerated() {
            imageVeiw.frame.size = scrollView.frame.size
            imageVeiw.frame.origin.x = scrollView.frame.width * CGFloat(index)
            imageVeiw.frame.origin.y = 0
        }
        let contentWidth = scrollView.frame.width * CGFloat(imageViews.count)
        scrollView.contentSize = CGSize(width: contentWidth, height: scrollView.frame.height)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ImageScrollViewController : UIScrollViewDelegate {
    
}
