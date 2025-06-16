//
//  TapVC.swift
//  GGTime
//
//  Created by 송정범 on 2025/06/17.
//

import Foundation
import UIKit

class TappedVC : UIViewController{
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let nextVC = storyboard.instantiateViewController(withIdentifier: "secondVC") as? secondVC {
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
    }
    
    @IBOutlet weak var imageView: UIImageView!
}
