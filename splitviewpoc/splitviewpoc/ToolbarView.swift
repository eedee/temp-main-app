//
//  ToolbarView.swift
//  splitviewpoc
//
//  Created by Andrew Nadlman on 4/12/16.
//  Copyright © 2016 Eedee. All rights reserved.
//

import UIKit

class ToolbarView: UIView {
  let menuButton = UIButton()
  let toggleButton = UIButton()

  override init(frame: CGRect) {
    super.init(frame: frame)
    //add intialization code here
    backgroundColor = .blackColor()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure() {
    menuButton.setTitle("Menu", forState: .Normal)
    menuButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    menuButton.setTitleColor(UIColor.grayColor(), forState: .Disabled)
    menuButton.addTarget(self, action: #selector(menuButtonTarget(_:)), forControlEvents: .TouchUpInside)
    self.addSubview(menuButton)
    menuButton.translatesAutoresizingMaskIntoConstraints = false
    menuButton.leftAnchor.constraintEqualToAnchor(self.leftAnchor, constant: 5).active = true
    menuButton.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor).active = true

    toggleButton.setTitle("Toggle", forState: .Normal)
    toggleButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    toggleButton.addTarget(self, action: #selector(ToolbarView.toggleButtonTarget(_:)), forControlEvents: .TouchUpInside)
    self.addSubview(toggleButton)
    toggleButton.translatesAutoresizingMaskIntoConstraints = false
    toggleButton.rightAnchor.constraintEqualToAnchor(self.rightAnchor, constant: -5).active = true
    toggleButton.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor).active = true
  }

  func enableToolbarButtons() {
    menuButton.enabled = true
    toggleButton.enabled = true
  }

  weak var menuDelegate : MenuProtocol?
  func menuButtonTarget(sender: UIButton!) {
    menuButton.enabled = false
    toggleButton.enabled = false
    menuDelegate?.showMenu()
  }

  weak var toggleDelegate : ToggleProtocol?
  func toggleButtonTarget(sender: UIButton!) {
    print("toggle button pressed")
    toggleDelegate?.toggle()
  }
}
