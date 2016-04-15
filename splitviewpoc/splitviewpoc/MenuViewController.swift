//
//  MenuViewController.swift
//  splitviewpoc
//
//  Created by Andrew Nadlman on 4/12/16.
//  Copyright © 2016 Eedee. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
  var menuView: MenuView! { return self.view as! MenuView }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view = MenuView()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
