//
//  TestVC.swift
//  YourApp
//
//  Created by J C on 2021-01-05.
//

import UIKit
import AVFoundation
import AVKit

class TestVC: UIViewController {
    var obs = Set<NSKeyValueObservation>()
    var synchLayer : AVSynchronizedLayer!

    override func loadView() {
        let v = UIView()
        v.backgroundColor = .systemBackground
        view = v
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(process))
        navigationItem.rightBarButtonItem = barButtonItem
        
        
        let url = Bundle.main.url(forResource: "IMG_2227", withExtension: "mp4")!
        let asset = AVURLAsset(url:url)
        let item = AVPlayerItem(asset:asset)
        let p = AVPlayer(playerItem:item)
        let vc = AVPlayerViewController()
        vc.player = p
        vc.view.frame = CGRect(x: 10,y: 110,width: 300,height: 200)
        vc.view.isHidden = true // looks nicer if we don't show until ready
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
        var ob : NSKeyValueObservation!
        ob = p.observe(\.status) { vc, ch in
            if p.status == .readyToPlay {
                self.obs.remove(ob)
                DispatchQueue.main.async {
                    print("status is ready to play")
                    self.finishConstructingInterface()
                }
            }
        }
        self.obs.insert(ob)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let vc = self.children[0] as! AVPlayerViewController
        let p = vc.player! //
        p.pause()
    }
    
    @objc func process(_ sender: UIBarButtonItem) {
        let vc = self.children[0] as! AVPlayerViewController
        let p = vc.player! //
        p.pause()
        
        let asset1 = p.currentItem!.asset //
        
        let type = AVMediaType.audio
        let arr = asset1.tracks(withMediaType: type)
        print("arr", arr)
        print("asset1", asset1)
        guard let track = arr.last else { return }
        
        let duration : CMTime = track.timeRange.duration
        
        let comp = AVMutableComposition()
        let comptrack = comp.addMutableTrack(withMediaType: type,
                                             preferredTrackID: Int32(kCMPersistentTrackID_Invalid))!
        
        try! comptrack.insertTimeRange(CMTimeRange(start: CMTime(seconds:0, preferredTimescale:600), duration: CMTime(seconds:5, preferredTimescale:600)), of:track, at:CMTime(seconds:0, preferredTimescale:600))
        try! comptrack.insertTimeRange(CMTimeRange(start: duration - CMTime(seconds:5, preferredTimescale:600), duration: CMTime(seconds:5, preferredTimescale:600)), of:track, at:CMTime(seconds:5, preferredTimescale:600))
        
        let type2 = AVMediaType.audio
        let arr2 = asset1.tracks(withMediaType: type2)
        let track2 = arr2.last! //
        let comptrack2 = comp.addMutableTrack(withMediaType: type2, preferredTrackID:Int32(kCMPersistentTrackID_Invalid))!
        
        try! comptrack2.insertTimeRange(CMTimeRange(start: CMTime(seconds:0, preferredTimescale:600), duration: CMTime(seconds:5, preferredTimescale:600)), of:track2, at:CMTime(seconds:0, preferredTimescale:600))
        try! comptrack2.insertTimeRange(CMTimeRange(start: duration - CMTime(seconds:5, preferredTimescale:600), duration: CMTime(seconds:5, preferredTimescale:600)), of:track2, at:CMTime(seconds:5, preferredTimescale:600))
        
        
        let type3 = AVMediaType.audio
        let s = Bundle.main.url(forResource:"rod", withExtension:"mp3")!
        let asset2 = AVURLAsset(url:s)
        let arr3 = asset2.tracks(withMediaType: type3)
        let track3 = arr3.last! //
        
        let comptrack3 = comp.addMutableTrack(withMediaType: type3, preferredTrackID:Int32(kCMPersistentTrackID_Invalid))!
        try! comptrack3.insertTimeRange(CMTimeRange(start: CMTime(seconds:0, preferredTimescale:600), duration: CMTime(seconds:10, preferredTimescale:600)), of:track3, at:CMTime(seconds:0, preferredTimescale:600))
        
        let params = AVMutableAudioMixInputParameters(track:comptrack3)
        params.setVolume(1, at:CMTime(seconds:0, preferredTimescale:600))
        params.setVolumeRamp(fromStartVolume: 1, toEndVolume:0, timeRange:CMTimeRange(start: CMTime(seconds:5, preferredTimescale:600), duration: CMTime(seconds:5, preferredTimescale:600)))
        let mix = AVMutableAudioMix()
        mix.inputParameters = [params]
        
//        let vidcomp = AVVideoComposition(asset: comp) { req in
//            // req is an AVAsynchronousCIImageFilteringRequest
//            let f = "CISepiaTone"
//            let im = req.sourceImage.applyingFilter(f, parameters: ["inputIntensity":0.95])
//            req.finish(with: im, context: nil)
//        }
        
        let item = AVPlayerItem(asset:comp)
        item.audioMix = mix
//        item.videoComposition = vidcomp
        
        p.replaceCurrentItem(with: item)
        
        (sender as UIBarButtonItem).isEnabled = false
        
        var ob : NSKeyValueObservation!
        ob = p.observe(\.status, options:.initial) { vc, ch in
            if p.status == .readyToPlay {
                if let ob = ob {
                    self.obs.remove(ob)
                }
                DispatchQueue.main.async {
                    print("status is ready to play")
                    self.finishConstructingInterface()
                }
            }
        }
        self.obs.insert(ob)

    }
    
    func finishConstructingInterface () {
        let vc = self.children[0] as! AVPlayerViewController
        
        vc.view.isHidden = false
        
        self.addSynchLayer()
    }
    
    func addSynchLayer() {
        // absolutely no reason why we shouldn't have a synch layer if we want one
        // (of course the one in this example is kind of pointless...
        // ...because the AVPlayerViewController's view gives us a position interface!)
        
        let vc = self.children[0] as! AVPlayerViewController
        let p = vc.player!
        
        // absolutely no reason why we shouldn't have a synch layer if we want one
        // (of course the one in this example is kind of pointless...
        // ...because the AVPlayerViewController's view gives us a position interface!)
        
        if self.synchLayer?.superlayer != nil {
            self.synchLayer.removeFromSuperlayer()
        }
        
        // create synch layer, put it in the interface
        let item = p.currentItem! //
        let syncLayer = AVSynchronizedLayer(playerItem:item)
        syncLayer.frame = CGRect(x: 10,y: 320,width: 300,height: 10)
        syncLayer.backgroundColor = UIColor.lightGray.cgColor
        self.view.layer.addSublayer(syncLayer)
        // give synch layer a sublayer
        let subLayer = CALayer()
        subLayer.backgroundColor = UIColor.black.cgColor
        subLayer.frame = CGRect(x: 0,y: 0,width: 10,height: 10)
        syncLayer.addSublayer(subLayer)
        // animate the sublayer
        let anim = CABasicAnimation(keyPath:#keyPath(CALayer.position))
        anim.fromValue = subLayer.position
        anim.toValue = CGPoint(x: 295,y: 5)
        anim.isRemovedOnCompletion = false
        anim.beginTime = AVCoreAnimationBeginTimeAtZero // important trick
        anim.duration = item.asset.duration.seconds
        subLayer.add(anim, forKey:nil)
        
        self.synchLayer = syncLayer
    }
}


//let url = URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_adv_example_hevc/master.m3u8")!
