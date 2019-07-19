//
//  ImagesListViewController.swift
//  Note
//
//  Created by Pavel N on 7/19/19.
//  Copyright © 2019 Pavel N. All rights reserved.
//

import UIKit

class ImagesListViewController: UIViewController {

    @IBOutlet var imagesCollectionView: UICollectionView!
    var images:[UIImage] = [UIImage(named: "first")!,UIImage(named: "second")!,UIImage(named: "third")!]
    var imagePicker:ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagesCollectionView.register(UINib(nibName: "ImagesCollectionViewCells", bundle: nil), forCellWithReuseIdentifier: "Cell")
        imagePicker = ImagePicker(presentationController: self, delegate: self)
        // Do any additional setup after loading the view.
    }
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        imagePicker.present(from: self.view)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ImageScrollViewController, segue.identifier == "goToScrollImage" {
            controller.images = images
        }
    }

}

extension ImagesListViewController : UICollectionViewDelegate, UICollectionViewDataSource, ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        images.append(image!)
        imagesCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImagesCollectionViewCells
        cell.setImage(image: images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToScrollImage", sender: nil)
    }
    
}

