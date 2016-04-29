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
        
        let gistsEndpoint = "https://api.github.com/users/cmoulton/gists"
        
        guard let url = NSURL(string: gistsEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        
        let urlRequest = NSURLRequest(URL: url)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) in
            
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            guard error == nil else {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let dataAsString = String(data: responseData, encoding: NSUTF8StringEncoding) else {
                print("Error: couldn't transform response data to String")
                return
            }
            
            print(dataAsString)
        }
        
        task.resume()
    }


}

