//
//  TchaAppCheckProvider.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 28/10/2023.
//

import Foundation
import FirebaseCore
import FirebaseAppCheck

class TchaAppCheckProviderFactory: NSObject, AppCheckProviderFactory {
  func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
    if #available(iOS 14.0, *) {
      return AppAttestProvider(app: app)
    } else {
      return DeviceCheckProvider(app: app)
    }
  }
}
