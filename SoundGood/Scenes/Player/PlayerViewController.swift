//
//  PlayerViewController.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 9/9/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import UIKit
import Reusable

class PlayerViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var artistLabel: UILabel!
    @IBOutlet private weak var trackImageView: UIImageView!
    @IBOutlet private weak var currentTimeLabel: UILabel!
    @IBOutlet private weak var remainTimeLabel: UILabel!
    @IBOutlet private weak var slider: UISlider!
    @IBOutlet private weak var loopButton: UIButton!
    @IBOutlet private weak var prevButton: UIButton!
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var menuButton: UIButton!
    
    // MARK: - Variables

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - StoryboardSceneBased
extension PlayerViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.player
}
