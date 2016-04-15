//
//  ActivityViewController.swift
//  splitviewpoc
//
//  Created by Andrew Nadlman on 4/14/16.
//  Copyright © 2016 Eedee. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {
  //var activityView: ActivityView! { return self.view as! ActivityView }

  override func viewDidLoad() {
    super.viewDidLoad()
    //self.view = ActivityView()
    self.view.backgroundColor = .darkGrayColor()
    addTemporaryLabel("Activity")
  }

  func addTemporaryLabel(labelText: String) {
    let label = UILabel()
    label.text = labelText
    self.view.addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
    label.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
    //label.topAnchor.constraintEqualToAnchor(self.view.topAnchor, constant: 50).active = true
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}