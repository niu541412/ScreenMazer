//
//  DefaultsManager.swift
//  ScreenMazer
//
//  Created by Alex Beals on 8/12/18.
//  Copyright © 2018 Beals, Alex. All rights reserved.
//

import ScreenSaver

final class DefaultsManager {
    private enum Keys {
        static let color = "color"
        static let solveColor = "solveColor"
        static let duration = "duration"
        static let solveDuration = "solveDuration"
        static let mazeSize = "mazeSize"
        static let clockSize = "clockSize"
        static let hourClock = "hourClock"
        static let solve = "solve"
    }

    let defaults: UserDefaults

    init() {
        let identifier = Bundle(for: DefaultsManager.self).bundleIdentifier
        defaults = ScreenSaverDefaults.init(forModuleWithName: identifier!)!
    }

    var color: NSColor {
        set(newColor) {
            setColor(newColor, key: Keys.color)
        }
        get {
            return getColor(forKey: Keys.color) ?? .gray
        }
    }

    var solveColor: NSColor {
        set(newColor) {
            setColor(newColor, key: Keys.solveColor)
        }
        get {
            return getColor(forKey: Keys.solveColor) ?? .white
        }
    }

    var duration: Int {
        set(newDuration) {
            defaults.set(newDuration, forKey: Keys.duration)
            defaults.synchronize()
        }
        get {
            let value = defaults.object(forKey: Keys.duration) as? Int
            return value ?? 30
        }
    }

    var solveDuration: Int {
        set(newDuration) {
            defaults.set(newDuration, forKey: Keys.solveDuration)
            defaults.synchronize()
        }
        get {
            let value = defaults.object(forKey: Keys.solveDuration) as? Int
            return value ?? 10
        }
    }

    var mazeSize: Double {
        set(newSize) {
            defaults.set(newSize, forKey: Keys.mazeSize)
            defaults.synchronize()
        }
        get {
            let value = defaults.object(forKey: Keys.mazeSize) as? Double
            return value ?? 7.0
        }
    }

    var clockSize: Int {
        set(newSize) {
            defaults.set(newSize, forKey: Keys.clockSize)
            defaults.synchronize()
        }
        get {
            let value = defaults.object(forKey: Keys.clockSize) as? Int
            return value ?? 1
        }
    }

    var hourClock: Bool {
        set(newClock) {
            defaults.set(newClock, forKey: Keys.hourClock)
            defaults.synchronize()
        }
        get {
            let value = defaults.object(forKey: Keys.hourClock) as? Bool
            return value ?? false
        }
    }

    var solve: Bool {
        set(newSolve) {
            defaults.set(newSolve, forKey: Keys.solve)
            defaults.synchronize()
        }
        get {
            let value = defaults.object(forKey: Keys.solve) as? Bool
            return value ?? true
        }
    }

    private func setColor(_ color: NSColor, key: String) {
        let archivedColor = try? NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false)
        defaults.set(archivedColor, forKey: key)
        defaults.synchronize()
    }

    private func getColor(forKey key: String) -> NSColor? {
        guard let info = defaults.data(forKey: key) else {
            return nil
        }

        return try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSColor.self, from: info)
    }
}
