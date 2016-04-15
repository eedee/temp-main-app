//
//  MenuView.swift
//  superstructure
//
//  Created by Andrew Nadlman on 4/7/16.
//  Copyright © 2016 Eedee. All rights reserved.
//

import UIKit

class MenuView: UIView {
  var selectedButton: UIButton?
  let selectedColor = UIColor.grayColor()

  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }

  convenience init (parentHeight : CGFloat) {
    self.init(frame:CGRect.zero)
  }

  override init (frame : CGRect) {
    super.init(frame : frame)
    self.backgroundColor = .blackColor()
  }

  func addMenuButtons() {
    if superview == nil { fatalError("The menu has to be added to the view heirarchy before you can add buttons") }
    //these should be loaded from the model, rather than being hard coded into the view
    let views = ["Activity", "Metrics", "Library", "Permits", "Settings", "Sign Out"]

    var anchoredToParent = false
    var previousButton: UIButton?

    for view in views {
      setNeedsLayout()
      layoutIfNeeded()

      //FUTURE DEVELOPMENT
      //IF AVAILABLE HEIGHT IS GREATER THAN A CERTAIN VALUE, ADD MENU ICONS TOO
      //let availableHeight = self.frame.height

      let menuButton = UIButton()
      menuButton.setTitle(view, forState: .Normal)
      menuButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
      //menuButton.backgroundColor = .orangeColor()
      menuButton.addTarget(self, action: #selector(menuButtonPressed(_:)), forControlEvents: .TouchUpInside)
      self.addSubview(menuButton)

      menuButton.translatesAutoresizingMaskIntoConstraints = false
      menuButton.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
      menuButton.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true

      if !anchoredToParent {
        menuButton.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true
        anchoredToParent = true
      } else {
        menuButton.bottomAnchor.constraintEqualToAnchor(previousButton!.topAnchor).active = true
        menuButton.heightAnchor.constraintEqualToAnchor(previousButton!.heightAnchor).active=true
      }

      previousButton = menuButton
    }

    previousButton!.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
  }


  func selectInitialButton(targetTitle: String) {
    //THERE IS ALMOST CERTAINLY A BETTER WAY TO DO THIS
    for subview in subviews {
      if (subview as! UIButton).currentTitle == targetTitle {
        selectedButton = (subview as! UIButton)
        selectedButton!.backgroundColor = selectedColor
        return
      }
    }
  }

  weak var navigationDelegate : NavigationProtocol?

  func menuButtonPressed(sender:UIButton) {
    let destinationView = sender.titleLabel!.text!
    navigationDelegate?.navigate(to: destinationView)

    //THIS LINE IS TEMPORARY TO KEEP THE SIGN OUT FROM GETTING SELECTED
    if destinationView == "Sign Out" { return }

    sender.backgroundColor = selectedColor
    selectedButton?.backgroundColor = .clearColor()
    selectedButton = sender
  }
}

