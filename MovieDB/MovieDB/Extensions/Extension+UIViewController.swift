//
//  PopularMoviesDataSource.swift
//  MovieDB
//
//  Created by Invision on 20/04/2019.
//  Copyright © 2019 Shiraz Ahmed. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    /**
     Show alert on the calling view controller
     
     -parameter title
     -parameter messsage
     */
    func showAlert(title:String? = "Error",message:String){
        let alertController=UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction=UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
