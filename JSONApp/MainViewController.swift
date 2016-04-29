//
//  MainViewController.swift
//  JSONApp
//
//  Created by Fernando Augusto de Marins on 28/04/16.
//  Copyright © 2016 FernandoMarins. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()

    }
    
    func getData() {
        
        guard let url = NSURL(string: Constants().gistsEndpoint) else {
            alertViewWithTitle("Error!", message: "Cannot create URL.")
            return
        }
        
        let urlRequest = NSURLRequest(URL: url)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) in
            
            guard let responseData = data else {
                self.alertViewWithTitle("Error!", message: "Did not receive data")
                return
            }
            
            guard error == nil else {
                self.alertViewWithTitle("Error!", message: "Error fetching data: \(error)")
                return
            }
            
            guard let dataAsString = String(data: responseData, encoding: NSUTF8StringEncoding) else {
                self.alertViewWithTitle("Error!", message: "Error: couldn't transform response data to String")
                return
            }
            
            print(dataAsString)
        }
        
        task.resume()
    }


}

