//
//  UserPreferences.swift
//  superstructure
//
//  Created by Andrew Nadlman on 4/10/16.
//  Copyright © 2016 Eedee. All rights reserved.
//

import Foundation

class UserPreferences : UserPreferencesProtocol {

  enum SplitView : String {
    case Auto = "Auto" //hide on iPhones and (possibly) portrait mode on iPads
    case Show = "Show"
    case Hide = "Hide"
  }
  let splitViewKey = "splitView"

  private(set) var splitView : SplitView = .Auto

  init() {
    let userDefaults = NSUserDefaults.standardUserDefaults()

    if let storedString = userDefaults.stringForKey(splitViewKey) {
      splitView = SplitView(rawValue: storedString)!
    } else {
      print("No saved preference for splitView found. This default value is: " + String(splitView))
    }
  }

  func saveSplitPreference(newValue: SplitView) {
    //save to persistent memory
    let prefs = NSUserDefaults.standardUserDefaults()
    prefs.setValue(newValue.rawValue, forKey: splitViewKey)
    //update volatile memory
    splitView = newValue
    print("preference saved for splitView: " + splitView.rawValue)
    // do stuff to handle the changed state
      //NOTHING HERE
  }

  weak var parentDelegate : SplitViewProtocol?

  func changeSetting(value : String) {
    let enumValue = SplitView(rawValue: value)!
    saveSplitPreference(enumValue)
    parentDelegate?.bananaSplit()
  }

  //UIInterfaceOrientationMask.Landscape
}


