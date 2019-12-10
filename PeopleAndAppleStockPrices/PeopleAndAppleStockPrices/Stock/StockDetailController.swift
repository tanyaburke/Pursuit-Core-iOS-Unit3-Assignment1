//
//  StockDetailController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Tanya Burke on 12/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StockDetailController: UIViewController {

  

      @IBOutlet weak var dateLabel: UILabel!
            @IBOutlet weak var imageView: UIImageView!
            @IBOutlet weak var openCloseLabel: UILabel!
            
            var passedApplDay: StockInfo?

            override func viewDidLoad() {
                super.viewDidLoad()
                updateUI()
            }
            
            func updateUI(){
                guard let validApplObj = passedApplDay else {
                    fatalError("failed to segue, check prepare(for: segue)")
                }
                
                dateLabel.text = validApplObj.date
                if validApplObj.isStockGreen(){
                    imageView.image = UIImage(named: "thumbsUp")
                    view.backgroundColor = .green
                } else {
                    imageView.image = UIImage(named: "thumbsDown")
                    view.backgroundColor = .red
                }
                openCloseLabel.text = "Open: \(validApplObj.open) Close: \(validApplObj.close)"
                
            }
            

          

        }
