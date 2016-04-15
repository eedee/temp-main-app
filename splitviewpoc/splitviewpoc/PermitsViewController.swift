//
//  PermitsViewController.swift
//  splitviewpoc
//
//  Created by Andrew Nadlman on 4/14/16.
//  Copyright © 2016 Eedee. All rights reserved.
//

import UIKit

class PermitsViewController: UIViewController {
  //var permitsView: PermitsView! { return self.view as! PermitsView }

  override func viewDidLoad() {
    super.viewDidLoad()
    //self.view = PermitsView()
    self.view.backgroundColor = .brownColor()
    addTemporaryLabel("Permits")
  }

  func addTemporaryLabel(labelText: String) {
    let label = UILabel()
    label.text = labelText
    label.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(label)
    label.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
    label.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}