//
//  BaseViewController.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 9/9/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import UIKit
import LNPopupController

protocol PresentDelegate: class {
    func presentMiniPlayer(_ viewController: BaseViewController)
}

class BaseViewController: UIViewController {

    var musicPlayer = MediaPlayerManager.getInstance()
    var playBarButton: UIBarButtonItem!
    var pauseBarButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    deinit {
        removeObserver()
    }

    func createObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinish(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }

    func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)

    }

    func configMiniPlayer() {
        guard let audioPlayer = musicPlayer.audioPlayer else { return }
        let track = musicPlayer.trackList[musicPlayer.index]
        popupItem.title = track.title
        popupItem.subtitle = track.artist
        playBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "mini-play"), style: .plain, target: self, action: #selector(playSong))
        pauseBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "pause"), style: .plain, target: self, action: #selector(pauseSong))
        if audioPlayer.rate == 0 {
            popupItem.rightBarButtonItems = [playBarButton]
        } else {
            popupItem.rightBarButtonItems = [pauseBarButton]
        }
    }

    @objc func playerDidFinish(_ notification: Notification) {
        switch musicPlayer.playerMode {
        case .loopOnce:
            musicPlayer.loopOnce()
        case .shuffle:
            musicPlayer.shuffle()
        case .normal:
            musicPlayer.next()
        }
    }

    @objc func playSong() {
        musicPlayer.play()
        popupItem.rightBarButtonItems = [pauseBarButton]
    }

    @objc func pauseSong() {
        musicPlayer.pause()
        popupItem.rightBarButtonItems = [playBarButton]
    }

    func playSelectedSong(from tracks: [Track], at index: Int) {
        musicPlayer.trackList = tracks
        musicPlayer.index = index
        let streamUrl = musicPlayer.prepare(index: musicPlayer.index)
        musicPlayer.play(url: streamUrl)
        let miniPlayer = PlayerViewController.instantiate()
        presentMiniPlayer(miniPlayer)
    }
}

extension BaseViewController: PresentDelegate {
    func presentMiniPlayer(_ viewController: BaseViewController) {
        tabBarController?.popupBar.marqueeScrollEnabled = true
        tabBarController?.presentPopupBar(withContentViewController: viewController, animated: true, completion: nil)
        viewController.configMiniPlayer()
    }
}
