//
//  ViewController.swift
//  IpadOSDragAndDrop
//
//  Created by J_Min on 2022/05/04.
//

import UIKit

class ViewController: UIViewController, UIDragInteractionDelegate, UIDropInteractionDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let dragInteraction = UIDragInteraction(delegate: self)
        let dropInteraction = UIDropInteraction(delegate: self)
        imageView.addInteraction(dragInteraction)
        imageView.addInteraction(dropInteraction)
        imageView.isUserInteractionEnabled = true
        
    }

    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }

    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        for item in session.items {
            let itemProvider = item.itemProvider
            guard itemProvider.canLoadObject(ofClass: UIImage.self) else { continue }

            itemProvider.loadObject(ofClass: UIImage.self) { image, _ in
                guard let image = image as? UIImage else {
                    return
                }
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }

    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        guard let image = imageView.image else { return [] }
        let provider = NSItemProvider(object: image)
        let item = UIDragItem(itemProvider: provider)
        return [item]
    }
}

