//
//  SnackBarViewModel.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 17/10/2022.
//

import Foundation
import UIKit
import SnapKit

typealias Handler = (() -> Void)
//Le type de snakBar que l'on souhaite générer
enum SnackbarViewType {
    case info
    case action(handler: Handler)
    case infoError
}

struct SnackbarViewModel {
    
    let type : SnackbarViewType
    let text : String
    let image : UIImage?
}

