//
//  ConfigureSheetController.swift
//  ScreenMazer
//
//  Created by Alex Beals on 8/12/18.
//  Copyright © 2018 Beals, Alex. All rights reserved.
//

import Cocoa

final class ConfigureSheetController: NSObject {
    let defaultsManager = DefaultsManager()
    var callback: (() -> Void)?

    @IBOutlet var window: NSWindow?
    @IBOutlet var canvasColorWell: NSColorWell?
    @IBOutlet var solveColorWell: NSColorWell!
    @IBOutlet var duration: NSTextField!
    @IBOutlet var mazeSize: NSSlider!
    @IBOutlet var solveDuration: NSTextField!
    @IBOutlet var clockSize: NSSlider!
    @IBOutlet var hourClock: NSButton!
    @IBOutlet var solveCheck: NSButton!

    override init() {
        super.init()

        let bundle = Bundle(for: ConfigureSheetController.self)
        bundle.loadNibNamed("ConfigureSheet", owner: self, topLevelObjects: nil)

        loadSettings()
    }

    private func loadSettings() {
        window?.title = "ScreenMazer Options"
        canvasColorWell?.color = defaultsManager.color
        solveColorWell.color = defaultsManager.solveColor
        duration.stringValue = String(defaultsManager.duration)
        solveDuration.stringValue = String(defaultsManager.solveDuration)
        mazeSize.doubleValue = defaultsManager.mazeSize
        clockSize.doubleValue = Double(defaultsManager.clockSize)
        hourClock.state = defaultsManager.hourClock ? .on : .off
        solveCheck.state = defaultsManager.solve ? .on : .off
    }

    @IBAction func colorFinished(_ sender: NSColorWell) {
        defaultsManager.color = sender.color
        callback?()
    }

    @IBAction func solveColorFinished(_ sender: NSColorWell) {
        defaultsManager.solveColor = sender.color
        callback?()
    }

    @IBAction func durationFinished(_ sender: NSTextField) {
        defaultsManager.duration = Int(sender.stringValue) ?? 30
        sender.stringValue = String(defaultsManager.duration)
        callback?()
    }

    @IBAction func solveDurationFinished(_ sender: NSTextField) {
        defaultsManager.solveDuration = Int(sender.stringValue) ?? 10
        sender.stringValue = String(defaultsManager.solveDuration)
        callback?()
    }

    @IBAction func mazeSizeFinished(_ sender: NSSlider) {
        defaultsManager.mazeSize = sender.doubleValue
        callback?()
    }

    @IBAction func clockSizeFinished(_ sender: NSSlider) {
        defaultsManager.clockSize = Int(sender.doubleValue)
        callback?()
    }

    @IBAction func clockFinished(_ sender: NSButton) {
        defaultsManager.hourClock = sender.state == .on
        callback?()
    }

    @IBAction func solveFinished(_ sender: NSButton) {
        defaultsManager.solve = sender.state == .on
        callback?()
    }

    @IBAction func closeConfigureSheet(_ sender: AnyObject) {
        guard let window else {
            return
        }

        NSColorPanel.shared.close()
        window.sheetParent?.endSheet(window)
    }
}
