//
//  MainViewController.swift
//  JSONApp
//
//  Created by Fernando Augusto de Marins on 28/04/16.
//  Copyright © 2016 FernandoMarins. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var descriptions = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
    }
    
    func getData() {
        
        // Creating the URL
        guard let url = NSURL(string: Constants().gistsEndpoint) else {
            performUIUpdatesOnMain() {
                self.alertViewWithTitle("Error!", message: "Cannot create URL.")
            }
            
            return
        }
        
        // Creating the request
        let urlRequest = NSURLRequest(URL: url)
        
        // Creating the session
        let session = NSURLSession.sharedSession()
        
        // Creating the task using the request
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) in
            
            // Checking if the data was received
            guard let responseData = data else {
                performUIUpdatesOnMain() {
                    self.alertViewWithTitle("Error!", message: "Did not receive data")
                }
                
                return
            }
            
            // Show an error if it's no nil
            guard error == nil else {
                performUIUpdatesOnMain() {
                    self.alertViewWithTitle("Error!", message: "Error fetching data: \(error)")
                }
                
                return
            }
            
            // Decoding the JSON into string
            guard let dataAsString = String(data: responseData, encoding: NSUTF8StringEncoding) else {
                performUIUpdatesOnMain() {
                    self.alertViewWithTitle("Error!", message: "Error: couldn't transform response data to String")
                }
                
                return
            }
            
            do {
                
                // Check if data is not nil
                if let dataUnwrapped = data {
                    if let gists = try NSJSONSerialization.JSONObjectWithData(dataUnwrapped, options: []) as? [[String: AnyObject]] {
                        
                        // Iterating the array to get the key "description"
                        for gist in gists {
                            if let description = gist["description"] as? String {
                                self.descriptions.append(description)
                            }
                        }
                    }
                }
                
            } catch {
                
                // In case it's not possible to make the serialization
                performUIUpdatesOnMain() {
                    self.alertViewWithTitle("Error!", message: "Error deserializing JSON: \(error)")
                }
            }
            
            print(self.descriptions)
            print(dataAsString)
        }
        
        // Performing the request
        task.resume()
    }
    
}

