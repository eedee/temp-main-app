//
//  ViewController.swift
//  splitviewpoc
//
//  Created by Andrew Nadlman on 4/11/16.
//  Copyright © 2016 Eedee. All rights reserved.
//

import UIKit

class HubViewController: UIViewController, MenuProtocol, ToggleProtocol, NavigationProtocol, UIGestureRecognizerDelegate {
  var hubView: HubView! { return self.view as! HubView }

  var masterViewController : UIViewController?
  var masterBottomConstraint : NSLayoutConstraint?

  var detailViewController : UIViewController?
  var detailBottomConstraint : NSLayoutConstraint?
  var detailSplitConstraint : NSLayoutConstraint?
  var detailWholeConstraint : NSLayoutConstraint?

  var toolbarViewController : ToolbarViewController?
  var toolbarSplitConstraint : NSLayoutConstraint?
  var toolbarWholeConstraint : NSLayoutConstraint?

  var menuViewController : MenuViewController?

  //let userPreferences = UserPreferences()
  let toolbarHeight : CGFloat = 50
    var splitFraction : CGFloat = 0.666666
    var splitViewOn : Bool = true

  override func viewDidLoad() {
    super.viewDidLoad()

    /* SETUP HUB VIEW */
    self.view = HubView(frame: self.view.frame)
    //hubView.backgroundColor = .greenColor() //good for debugging
    //splitView.menuView.delegate = self

    /* SETUP TOOLBAR */
    toolbarViewController = ToolbarViewController()
    addToolbar()

    /* SETUP MENU */
    menuViewController = MenuViewController()
    addMenuView()

    /* SETUP MASTER VIEW */
    masterViewController = StackViewController()
    addMasterView()

    /* SETUP DETAIL VIEW */
    detailViewController = ActivityViewController() // NEED TO CALL LOGIC HERE THAT DETERMINES WHICH VIEW TO LOAD INITIALLY
    addDetailView()


    /* SETUP CONSTRAINTS */
    setupConstraints()
    detailSplitConstraint?.active = true
    toolbarSplitConstraint?.active = true
    //toolbarWholeConstraint?.active = true

    //NEED TO FIX/REPLACE
    self.view.bringSubviewToFront(toolbarViewController!.view)
    self.view.bringSubviewToFront(menuViewController!.view)

    //SELECT FIRST MENU ITEM, MOVE ELSEWHERE LATER AND REMOVE HARD CODING OF CHOICE
    menuViewController?.menuView.selectInitialButton("Activity")

    //SHADE CORNER
    shadeCorner()
  }

  func addMenuView() {
    let menuView = menuViewController!.view as! MenuView
    menuView.hidden = true
    //menuView.backgroundColor = .purpleColor()
    menuView.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(menuView)
    self.addChildViewController(toolbarViewController!)

    //fully constrained
    menuView.topAnchor.constraintEqualToAnchor(self.view.topAnchor).active = true
    menuView.bottomAnchor.constraintEqualToAnchor(toolbarViewController!.view.topAnchor).active = true
    menuView.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor).active = true
    menuView.widthAnchor.constraintEqualToConstant(100).active = true

    menuViewController!.didMoveToParentViewController(self)
    menuView.addMenuButtons()
    menuView.navigationDelegate = self
  }

  func addToolbar() {
    let toolbarView = toolbarViewController!.toolbarView
    //toolbarView.backgroundColor = .brownColor()
    toolbarView.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(toolbarView)
    self.addChildViewController(toolbarViewController!)

    //partially constrained
    toolbarView.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor).active = true
    toolbarView.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor).active = true
    toolbarView.heightAnchor.constraintEqualToConstant(toolbarHeight).active = true

    toolbarViewController!.didMoveToParentViewController(self)

    toolbarView.menuDelegate = self
    toolbarView.toggleDelegate = self
    //toolbarView.backgroundColor = .clearColor() //good for debugging
  }

  func addMasterView() {
    let mView = masterViewController!.view
    mView.backgroundColor = .whiteColor()
    mView.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(mView)
    self.addChildViewController(masterViewController!)

    //fully constrained
    mView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
    mView.bottomAnchor.constraintEqualToAnchor(toolbarViewController!.view.topAnchor).active = true
    mView.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
    mView.widthAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: splitFraction).active = true

    masterViewController!.didMoveToParentViewController(self)
  }


  func addDetailView() {
    let dView = detailViewController!.view
    //dView.backgroundColor = .cyanColor()
    dView.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(dView)
    self.addChildViewController(detailViewController!)
    //partially constrained
    dView.topAnchor.constraintEqualToAnchor(self.view.topAnchor).active = true
    dView.rightAnchor.constraintEqualToAnchor(self.view.rightAnchor).active = true
    detailBottomConstraint = dView.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor)
    detailBottomConstraint?.active = true

    detailViewController!.didMoveToParentViewController(self)
  }


  func setupConstraints() {
    let tView = toolbarViewController!.view
    let dView = detailViewController!.view

    toolbarWholeConstraint = tView.rightAnchor.constraintEqualToAnchor(self.view.rightAnchor)
    let testingConstant: CGFloat = 0
    detailWholeConstraint = dView.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor, constant: testingConstant)

    if splitViewOn {
      let mView = masterViewController!.view
      toolbarSplitConstraint = tView.rightAnchor.constraintEqualToAnchor(mView.rightAnchor)
      detailSplitConstraint = dView.leftAnchor.constraintEqualToAnchor(mView.rightAnchor)
      detailBottomConstraint?.constant = 0
    } else {
      detailBottomConstraint?.constant = -toolbarHeight
    }
  }


  func removeMasterView() {
    masterViewController!.willMoveToParentViewController(nil)
    masterViewController!.view.removeFromSuperview()
    masterViewController!.removeFromParentViewController()
  }

  func removeDetailView() {
    detailViewController!.willMoveToParentViewController(nil)
    detailViewController!.view.removeFromSuperview()
    detailViewController!.removeFromParentViewController()
  }

  func replaceDetailView() {
    removeDetailView()

    //now add it back...
    detailViewController = UIViewController()
    addDetailView()
    view.sendSubviewToBack(detailViewController!.view)

    setupConstraints()
    detailSplitConstraint?.active = splitViewOn
    detailWholeConstraint?.active = !splitViewOn
  }

  func toggle() {
    splitViewOn = !splitViewOn
    //print("splitViewOn = "+String(splitViewOn))

    detailSplitConstraint?.active = false
    detailWholeConstraint?.active = false

    toolbarSplitConstraint?.active = false
    toolbarWholeConstraint?.active = false

    if splitViewOn {
      //masterViewController = UIViewController() //may be unnecessary, depending on whatever
      addMasterView()
      view.sendSubviewToBack(masterViewController!.view)
      setupConstraints()
    } else {
      removeMasterView()
      detailBottomConstraint?.constant = -toolbarHeight
    }

    detailSplitConstraint?.active = splitViewOn
    detailWholeConstraint?.active = !splitViewOn

    toolbarSplitConstraint?.active = splitViewOn
    toolbarWholeConstraint?.active = !splitViewOn

    shadeCorner()
  }


  func showMenu() {
    menuViewController!.view.hidden = false
    hubView.addGestureRecognizer(hubView.closeMenuGesture)
    hubView.closeMenuGesture.delegate = self
  }


  func hideMenu() {
    hubView.removeGestureRecognizer(hubView.closeMenuGesture)
    menuViewController!.view.hidden = true
    //this really shouldn't be here...
    toolbarViewController!.toolbarView.enableToolbarButtons()
  }

  func navigate(to toViewName: String) {
    print("navigate to new view")
    removeDetailView()

    //figure out which view to load based on the title of the button that was tapped
    switch toViewName {
    case "Activity": detailViewController =  ActivityViewController()
    case "Metrics":  detailViewController =  MetricsViewController()
    case "Library":  detailViewController =  LibraryViewController()
    case "Permits":  detailViewController =  PermitsViewController()
    case "Settings": detailViewController =  SettingsViewController() //(detailViewController as! SettingsViewController).delegate = userPreferences
    default:
      deadEndAlert(toViewName)
    }

    //add the detail view back to the screen and
    addDetailView()
    view.sendSubviewToBack(detailViewController!.view)

    setupConstraints()
    detailSplitConstraint?.active = splitViewOn
    detailWholeConstraint?.active = !splitViewOn
  }

  func deadEndAlert(name : String) {
    let message = name + " has not been built."
    let alertController = UIAlertController(title: "Dead End", message:
      message, preferredStyle: .Alert)
    let alertAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil)
    alertController.addAction(alertAction)
    self.presentViewController(alertController, animated: true, completion: nil)
  }

  func shadeCorner() {
    //remove existing shading (from detail view only)
    detailViewController!.view.layer.mask = nil

    let maskView = splitViewOn ? masterViewController?.view : detailViewController?.view

//    if maskView == nil {
//      print("what the hell???")
//      return
//    }
    //EVENTUALLY NEED TO RESTRUCTURE THE CODE SO THAT THIS IS COMBINED WITH THE MENU RE-LAYOUT (IF POSSIBLE AND ADVISABLE)
    maskView!.setNeedsLayout()
    maskView!.layoutIfNeeded()

    let maskPath = UIBezierPath(roundedRect: maskView!.frame, byRoundingCorners: .BottomLeft,
                                cornerRadii: CGSize(width: 50.0, height: 50.0))
    let maskForYourPath = CAShapeLayer()
    maskForYourPath.path = maskPath.CGPath
    maskView!.layer.mask = maskForYourPath
  }

  func removeMasterShadedCorner() {
    //detailViewController!.view.layer.mask = nil
  }


  func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
    // if the touch isn't on the menu base view: hide the menu & stop gesture bubbling
    if touch.view != menuViewController?.view {
      hideMenu()
      return false
    // if it is: let the gesture keep bubbling
    } else {
      return false
    }
  }
}