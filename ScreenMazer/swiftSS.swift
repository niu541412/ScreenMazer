//
//  swiftSS.swift
//  ScreenMazer
//
//  Created by Alex Beals on 8/12/18.
//  Copyright © 2018 Beals, Alex. All rights reserved.
//

import ScreenSaver
import SpriteKit

final class swiftSS: ScreenSaverView {
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
        
        //probably not needed, but cant hurt to check in case we re-use this code later
        for subview in self.subviews {
            subview.removeFromSuperview()
        }

        //Create the SpriteKit View
        let view: SKView = SKView(frame: self.bounds)

        //Create the scene and add it to the view
        mazeScene = MazeScene(size: self.bounds.size)
        mazeScene!.scaleMode = .aspectFill
        mazeScene!.isPreview = isPreview
        view.presentScene(mazeScene)

        //add it in as a subview
        self.addSubview(view)
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
}
