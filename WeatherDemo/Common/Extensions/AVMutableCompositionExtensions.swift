//
//  AVMutableCompositionExtensions.swift
//  BabyPhoto
//
//  Created by Le Toan on 9/14/20.
//  Copyright © 2020 Solar. All rights reserved.
//

import AVFoundation

extension AVMutableComposition {
    func copyAllTrack(from asset: AVAsset) {
        copyTrack(withType: .audio, from: asset)
        copyTrack(withType: .video, from: asset)
    }
    
    func copyTrack(withType type: AVMediaType, from asset: AVAsset) {
        let tracks = asset.tracks(withMediaType: type)
        for track in tracks {
            let compositionTrack = addMutableTrack(withMediaType: type, preferredTrackID: kCMPersistentTrackID_Invalid)
            compositionTrack?.preferredTransform = tracks.first!.preferredTransform
            compositionTrack?.preferredVolume = tracks.first!.preferredVolume
            try? compositionTrack?.insertTimeRange(track.timeRange, of: track, at: track.timeRange.start)
        }
    }
}
