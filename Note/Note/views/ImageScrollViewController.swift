//
//  ImageScrollViewController.swift
//  Note
//
//  Created by Pavel N on 7/19/19.
//  Copyright © 2019 Pavel N. All rights reserved.
//

import UIKit

class ImageScrollViewController: UIViewController {

    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var scrollView: UIScrollView!
    var images:[UIImage] = [UIImage]()
    var startPos:Int = 0
    
    private var imageViews:[UIImageView] = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        pageControl.numberOfPages = images.count
        pageControl.currentPage = startPos
        
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
        
        let offset = scrollView.frame.width * CGFloat(startPos)
        scrollView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        imageViews.removeAll()
        startPos = 0
    }
    
    @IBAction func pageControlValueChanged(_ sender: UIPageControl) {
        let offset = scrollView.frame.width * CGFloat(pageControl.currentPage)
        scrollView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = pageIndex
    }
}
