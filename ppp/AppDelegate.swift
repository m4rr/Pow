//
//  AppDelegate.swift
//  ppp
//
//  Created by Marat S. on 25.05.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import Cocoa
import MASShortcut

func pow() {
  let rect = NSScreen.main()!.frame
  let window = NSWindow(contentRect: rect, styleMask: NSBorderlessWindowMask, backing: .buffered, defer: false)
  window.backgroundColor = NSColor.clear
  window.isOpaque = false
  window.alphaValue = 1
  window.makeKeyAndOrderFront(NSApplication.shared())
  window.level = Int(CGWindowLevelForKey(CGWindowLevelKey.statusWindow))

  let iv = NSImageView(frame: window.contentView!.bounds)
  iv.wantsLayer = true
  let named = "pow\(arc4random() % 7)"
  iv.image = NSImage(named: named)
  window.contentView!.addSubview(iv)

  iv.layer?.anchorPoint = CGPoint(x: 0.5, y: 0.5)

  let animation = CABasicAnimation(keyPath: "transform.scale")
  animation.fromValue = 0.8
  animation.toValue = 12

  let opacityAnimation = CABasicAnimation(keyPath: "opacity")
  opacityAnimation.fromValue = 1
  opacityAnimation.toValue = 0

  let group = CAAnimationGroup()
  group.duration = 0.5
  group.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
  group.fillMode = kCAFillModeForwards
  group.isRemovedOnCompletion = false
  group.animations = [animation, opacityAnimation]

  CATransaction.begin()
  CATransaction.setCompletionBlock {
    // keep reference to window object
    _ = window.isZoomed
  }
  iv.layer?.add(group, forKey: "")
  CATransaction.commit()
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  @IBOutlet weak var window: NSWindow!
  @IBOutlet weak var sv: MASShortcutView!

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    sv.associatedUserDefaultsKey = "test"
    MASShortcutBinder.shared().bindShortcut(withDefaultsKey: "test", toAction: pow)
  }

  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }

}
