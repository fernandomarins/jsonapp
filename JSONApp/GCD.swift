//
//  GCD.swift
//  JSONApp
//
//  Created by Fernando Augusto de Marins on 29/04/16.
//  Copyright © 2016 FernandoMarins. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(updates: () -> Void) {
    dispatch_async(dispatch_get_main_queue()) {
        updates()
    }
}