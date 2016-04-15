//
//  ToolbarViewController.swift
//  splitviewpoc
//
//  Created by Andrew Nadlman on 4/12/16.
//  Copyright © 2016 Eedee. All rights reserved.
//

import UIKit

class ToolbarViewController: UIViewController {
  var toolbarView: ToolbarView! { return self.view as! ToolbarView }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view = ToolbarView(frame: self.view.frame)
    toolbarView.configure()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
