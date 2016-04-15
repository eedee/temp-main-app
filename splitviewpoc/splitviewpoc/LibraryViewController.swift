//
//  LibraryViewController.swift
//  splitviewpoc
//
//  Created by Andrew Nadlman on 4/14/16.
//  Copyright © 2016 Eedee. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController {
  //var libraryView: LibraryView! { return self.view as! LibraryView }

  override func viewDidLoad() {
    super.viewDidLoad()
    //self.view = LibraryView()
    self.view.backgroundColor = .magentaColor()
    addTemporaryLabel("Library")
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