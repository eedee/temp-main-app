//
//  StackViewController.swift
//  splitviewpoc
//
//  Created by Andrew Nadlman on 4/14/16.
//  Copyright © 2016 Eedee. All rights reserved.
//

import UIKit

class StackViewController: UIViewController {
  //var stackView: StackView! { return self.view as! StackView }

  override func viewDidLoad() {
    super.viewDidLoad()
    //self.view = StackView()
    self.view.backgroundColor = .whiteColor()
    addTemporaryLabel("Stack")
  }

  func addTemporaryLabel(labelText: String) {
    let label = UILabel()
    label.text = labelText
    label.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(label)
    label.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
    label.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
    //label.topAnchor.constraintEqualToAnchor(self.view.topAnchor, constant: 50).active = true
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}