//
//  MediaPlayerManager.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 9/9/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import AVFoundation
import AVKit
import MediaPlayer

enum PlayerMode {
    case loopOnce
    case shuffle
    case normal
}

class MediaPlayerManager {
    private static let sharedInstance = MediaPlayerManager()
    var audioPlayer: AVPlayer?
    var index = 0
    var trackList = [Track]()
    var playerMode = PlayerMode.normal

    static func getInstance() -> MediaPlayerManager {
        return sharedInstance
    }

    private init() {

    }

    func prepare(index: Int) -> URL {
        let track = trackList[index]
        let url = "\(track.streamUrl)?client_id=\(ApiKey.apiKey)"
        return URL(string: url) ?? URL(string: "")!
    }

    func play(url: URL) {
        let playerItem = AVPlayerItem(url: url)
        audioPlayer = AVPlayer(playerItem: playerItem)
        audioPlayer?.play()
    }

    func play() {
        audioPlayer?.play()
    }

    func pause() {
        audioPlayer?.pause()
    }

    func stop() {
        audioPlayer = AVPlayer()
    }

    func shuffle() {
        let range = CountableRange<Int>(uncheckedBounds: (lower: 0, upper: trackList.count))
        index = Int.random(in: range)
        let url = prepare(index: index)
        play(url: url)
    }

    func loopOnce() {
        changeTrack(increase: 0)
    }

    func next() {
        changeTrack(increase: 1)
    }

    func previous() {
        changeTrack(increase: -1)
    }

    private func changeTrack(increase: Int) {
        index += increase
        if index >= trackList.count {
            index = 0
        } else if index < 0 {
            index = trackList.count - 1
        }
        let url = prepare(index: index)
        play(url: url)
    }
}
