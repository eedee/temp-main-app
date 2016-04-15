//
//  Protocols.swift
//  superstructure
//
//  Created by Andrew Nadlman on 4/10/16.
//  Copyright © 2016 Eedee. All rights reserved.
//

import Foundation

protocol SplitViewProtocol : class {
  func switchDetailView(viewToLoadName : String)
  func bananaSplit()
}

protocol UserPreferencesProtocol : class {
  func changeSetting(value : String)
}

protocol MenuProtocol : class {
  func showMenu()
  func hideMenu()
}

protocol ToggleProtocol : class {
  func toggle()
}

protocol NavigationProtocol : class {
  func navigate(to toViewName: String)
}