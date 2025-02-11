//
//  UserDetailController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Tanya Burke on 12/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class UserDetailController: UIViewController {

   
            
        @IBOutlet weak var imageView:UIImageView!
        
            @IBOutlet weak var nameLabel:UILabel!
            @IBOutlet weak var contactLabel:UILabel!
            @IBOutlet weak var addressLabel:UILabel!
    
    var passedUserObj: User!
    
            override func viewDidLoad() {
                super.viewDidLoad()
                updateUI()
               
            }
            
            func alertController(title: String, errorMessage: NetworkError, buttonTitle: String){
                let alertController = UIAlertController(title: title, message: "\(errorMessage)", preferredStyle: .alert)
                let alertDismissButton = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
                alertController.addAction(alertDismissButton)
            }
            
            func updateUI(){
                guard let validCell = passedUserObj?.cell, let validEmail = passedUserObj?.email, let validCity = passedUserObj?.location.city, let validState = passedUserObj?.location.state, let validImage = passedUserObj?.picture.large else {
                    fatalError("could not validate User")
                }
                
                
                imageView.image = UIImage(for: validImage, completion: { (result) in
                    switch result{
                    case .failure(let error):
                        self.alertController(title: "Network Error", errorMessage: error, buttonTitle: "OK")
                        self.imageView.image = UIImage(named: "profileImage")
                    case .success(let image):
                        DispatchQueue.main.async {
                            self.imageView.image = image
                        }
                    }
                    
                })
                nameLabel.text = passedUserObj?.name.returnFullName().capitalizingFirstLetter()
                contactLabel.text = "Cell: \(validCell)\nEmail: \(validEmail)"
                addressLabel.text = "\(validCity.capitalizingFirstLetter()), \(validState.capitalizingFirstLetter())"
            }

        }

