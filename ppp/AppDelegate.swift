//
//  AppDelegate.swift
//  ppp
//
//  Created by Marat S. on 25.05.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import Cocoa
import MASShortcut

func powww() {
  let window = NSWindow(
    contentRect: NSScreen.main()!.frame,
    styleMask: NSBorderlessWindowMask,
    backing: .buffered,
    defer: false)
  window.backgroundColor = .clear
  window.isOpaque = false
  window.alphaValue = 1
  window.makeKeyAndOrderFront(NSApplication.shared())
  window.level = Int(CGWindowLevelForKey(.assistiveTechHighWindow))

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
  opacityAnimation.fromValue = 0.9
  opacityAnimation.toValue = 0

  let group = CAAnimationGroup()
  group.duration = 0.5
  group.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
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

  func massPow() {
    for i in 0..<1 {
      let ti: DispatchTime = .now() + .milliseconds(i * 100)
      DispatchQueue.main.asyncAfter(deadline: ti, qos: DispatchQoS.userInteractive, flags: [], execute: powww)
    }
  }

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    sv.associatedUserDefaultsKey = "test"
    MASShortcutBinder.shared().bindShortcut(withDefaultsKey: "test", toAction: massPow)
  }

  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }

}
