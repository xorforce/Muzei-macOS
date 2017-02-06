//
//  PreferenceWindowController.swift
//  MuzeiOSX
//
//  Created by Naman on 31/01/17.
//  Copyright © 2017 naman14. All rights reserved.
//

import Foundation
import Cocoa

class PreferenceWindowController : NSWindowController {
    
    @IBOutlet weak var sourceFeaturedArt: NSButton!
    @IBOutlet weak var sourceReddit: NSButton!
    @IBOutlet weak var textSubredditName: NSTextField!
    @IBOutlet weak var sourceDone: NSButton!
    
    @IBOutlet weak var blurButton: NSButton!
    @IBOutlet weak var dimButton: NSButton!
    @IBOutlet weak var blurSlider: NSSlider!
    @IBOutlet weak var dimSlider: NSSlider!
    @IBOutlet weak var wallpaperDone: NSButton!
    
    let SOURCE_FEATURED = "source_featured_art"
    let SOURCE_REDDIT = "source_reddit"
    
    let PREF_SOURCE = "pref_source"
    let PREF_SUBREDDIT = "pref_subreddit"
    
    let PREF_BLUR_ACTIVE = "pref_blur_active"
    let PREF_DIM_ACTIVE = "pref_dim_active"
    let PREF_BLUR_AMOUNT = "pref_blur_amount"
    let PREF_DIM_AMOUNT = "pref_dim_amount"

    let prefs = UserDefaults.standard
    
    override func windowDidLoad() {
        window?.title = "Preferences"
        updateWindow()
        
    }
    
    @IBAction func featuredArtSelected(_ sender: NSButton) {
        updateSource(source: SOURCE_FEATURED)
    }
    
    @IBAction func redditSelected(_ sender: NSButton) {
        updateSource(source: SOURCE_REDDIT)
    }
    
    
    @IBAction func sourceDoneClicked(_ sender: NSButton) {
        prefs.set(textSubredditName.stringValue, forKey: PREF_SUBREDDIT)
        prefs.synchronize()
        window?.close()
    }
    
    @IBAction func blurButtonClicked(_ sender: NSButton) {
        blurSlider.isEnabled = (sender.state ==  NSOnState)
        prefs.set(sender.state == NSOnState, forKey: PREF_BLUR_ACTIVE)
        prefs.synchronize()
    }
    
    @IBAction func dimButtonClicked(_ sender: NSButton) {
        dimSlider.isEnabled = (sender.state ==  NSOnState)
        prefs.set(sender.state == NSOnState, forKey: PREF_DIM_ACTIVE)
        prefs.synchronize()
    }
    
    @IBAction func wallpaperDoneClicked(_ sender: NSButton) {
        prefs.set(blurSlider.floatValue, forKey: PREF_BLUR_AMOUNT)
        prefs.set(dimSlider.floatValue, forKey: PREF_DIM_AMOUNT)
        prefs.synchronize()

    }
    
    func updateWindow() {
        NSApp.activate(ignoringOtherApps: true)
        

        if let source = prefs.string(forKey: PREF_SOURCE) {
            updateSource(source: source)
        } else {
            updateSource(source: SOURCE_FEATURED)
        }
        
        if let subreddit = prefs.string(forKey: PREF_SUBREDDIT) {
            textSubredditName.stringValue = subreddit
        } else {
            textSubredditName.stringValue = "EarthPorn"
        }
    }
    
    func updateSource(source: String) {
        prefs.set(source, forKey: PREF_SOURCE)

        switch(source) {
            
        case SOURCE_FEATURED:
            sourceReddit.state = NSOffState
            sourceFeaturedArt.state = NSOnState
            textSubredditName.isEnabled = false
            break
            
        case SOURCE_REDDIT:
            sourceReddit.state = NSOnState
            sourceFeaturedArt.state = NSOffState
            textSubredditName.isEnabled = true
            break
            
        default: break
            
        }
        prefs.synchronize()
    }
    
}
