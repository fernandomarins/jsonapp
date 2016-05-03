//
//  GCD.swift
//  JSONApp
//
//  Created by Fernando Augusto de Marins on 29/04/16.
//  Copyright © 2016 FernandoMarins. All rights reserved.
//

import Foundation

// Method created to make sure all updates are made in the main thread
func performUIUpdatesOnMain(updates: () -> Void) {
    dispatch_async(dispatch_get_main_queue()) {
        updates()
    }
}