//
//  swiftSS.swift
//  ScreenMazer
//
//  Created by Alex Beals on 8/12/18.
//  Copyright © 2018 Beals, Alex. All rights reserved.
//

import ScreenSaver
import SpriteKit
import Dispatch

final class swiftSS: ScreenSaverView {
    private var spriteView: SKView?
    private var lastSceneSize: CGSize = .zero
    private var animationTimer: DispatchSourceTimer?
    private lazy var animationQueue = DispatchQueue(label: "com.alexbeals.ScreenMazer.animation.\(ObjectIdentifier(self).hashValue)")

    private lazy var sheetController: ConfigureSheetController = {
        let controller = ConfigureSheetController()
        controller.callback = { [weak self] in
            self?.mazeScene?.generateMaze()
        }
        return controller
    }()

    var mazeScene: MazeScene?

    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        animationTimeInterval = 1.0 / 60.0
        
        //probably not needed, but cant hurt to check in case we re-use this code later
        for subview in self.subviews {
            subview.removeFromSuperview()
        }

        //Create the SpriteKit View
        let view: SKView = SKView(frame: self.bounds)
        configure(view)
        spriteView = view

        //Create the scene and add it to the view
        mazeScene = MazeScene(size: self.bounds.size)
        mazeScene!.scaleMode = .aspectFill
        mazeScene!.isPreview = isPreview
        view.presentScene(mazeScene)

        //add it in as a subview
        self.addSubview(view)
    }

    override func layout() {
        super.layout()
        resizeSceneIfNeeded()
    }

    override func startAnimation() {
        super.startAnimation()
        resizeSceneIfNeeded()
        spriteView?.isPaused = false
        mazeScene?.isPaused = false
        startAnimationTimer()
    }

    override func animateOneFrame() {
        resizeSceneIfNeeded()
    }

    override func stopAnimation() {
        stopAnimationTimer()
        spriteView?.isPaused = true
        mazeScene?.isPaused = true
        super.stopAnimation()
    }
    
    override var hasConfigureSheet: Bool {
        true
    }

    override var configureSheet: NSWindow? {
        sheetController.window
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configure(_ view: SKView) {
        view.autoresizingMask = [.width, .height]
        view.ignoresSiblingOrder = true
        view.isAsynchronous = true
        view.preferredFramesPerSecond = 60
    }

    private func resizeSceneIfNeeded() {
        guard let mazeScene, bounds.size.width > 0, bounds.size.height > 0 else {
            return
        }

        spriteView?.frame = bounds

        guard bounds.size != lastSceneSize else {
            return
        }

        lastSceneSize = bounds.size
        mazeScene.size = bounds.size
        mazeScene.generateMaze()
    }

    private func startAnimationTimer() {
        guard animationTimer == nil else {
            return
        }

        let timer = DispatchSource.makeTimerSource(queue: animationQueue)
        timer.schedule(deadline: .now(), repeating: .milliseconds(16), leeway: .milliseconds(2))
        timer.setEventHandler { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {
                    return
                }
                guard self.animationTimer != nil else {
                    return
                }

                self.resizeSceneIfNeeded()
                self.mazeScene?.advance()
            }
        }
        animationTimer = timer
        timer.resume()
    }

    private func stopAnimationTimer() {
        animationTimer?.cancel()
        animationTimer = nil
    }
}
