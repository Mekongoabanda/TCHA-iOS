//
//  LoggerProject.swift
//  WeMoney
//
//  Created by Yannick Edouard MEKONGO ABANDA on 11/10/2022.
//

import Foundation

import UIKit
import SwiftyBeaver

class LoggerProject{
    
    static let logger = SwiftyBeaver.self
    
    
    
    func launch() {
        
        let console = ConsoleDestination()
        console.levelColor.error = "❌ "
        console.levelColor.warning = "🔶 "
        console.levelColor.info = "💬 "
        console.levelColor.debug = "♻️ "
        console.levelColor.verbose = "⏱ "
        
        console.minLevel = .info
        
        LoggerProject.logger.addDestination(console)
    }
}
