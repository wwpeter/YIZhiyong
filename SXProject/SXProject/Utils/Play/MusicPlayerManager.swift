//
//  MusicPlayerManager.swift
//  DigitalSleep
//
//  Created by ww on 2021/12/7.
//
//  音乐播放管理类
//  功能
/*
 上下首音频切换
 播放暂停
 拖动快进
 缓冲进度
 锁屏播放
 后台播放
 循环播放
 锁屏状态下的操作
 自动播放
 */

import Foundation
import AVFoundation

class MusicPlayerManager {
    /// 单例对象
    static let shared = MusicPlayerManager()
    
    /// 播放对象
    private var player: AVPlayer!
    
    private var playerItem: AVPlayerItem?
    
    /// 监听状态改变
    private var statusObservation: NSKeyValueObservation!
    ///  监听加载进度
    private var timeObserverToken: Any?

    weak var delegate: MusicPlayerDelegate?
    
    private init() {
        // 初始化播放对象
        player = AVPlayer()
    }
}

// MARK: 播放控制： 暂停、开始、下一曲、上一曲
extension MusicPlayerManager {
    func play(_ uri: String) {
        // 如果暂停的就继续播放
        if player.timeControlStatus == .paused,
            playerItem != nil {
            player.play()
            return
        }
        
        // 移除所有监听
        removerObserser()
        
        // 创建新的item
        var url: URL!
        if uri.hasPrefix("http") || uri.hasPrefix("https") {
            url = URL(string: uri)
        } else {
            url = URL(fileURLWithPath: uri)
        }
        let item = AVPlayerItem(url: url)
        playerItem = item
        player.replaceCurrentItem(with: item)
        
        // 添加所有监听
        addObserver()
        
        // 播放音乐
        player.play()
    }
    
    // 暂停
    func pause() {
        // 如果是暂停状态直接返回
        guard player.timeControlStatus != .paused else {
            return
        }
        // 如果当前的item存在就暂停
        if playerItem != nil {
            player.pause()
        }
    }
    
    // 设置进度
    func seek(_ ss: Float, completionHandler: @escaping (Bool) -> Void) {
        let duration = player.currentItem?.duration
        let totalTime = Float(CMTimeGetSeconds(duration!))
        player.seek(to: CMTime(seconds: Double(totalTime * ss), preferredTimescale: 1), completionHandler: completionHandler)
    }
}

// MARK: 监听
extension MusicPlayerManager {
    
    func addObserver() {
        statusObservation = player.observe(\.status) { player, _ in
            switch player.status {
            case .readyToPlay:
                printLog("准备播放")
            case .failed:
                printLog("加载失败")
            case .unknown:
                printLog("未知错误")
            @unknown default:
                printLog("未知错误")
            }
        }
        
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: DispatchQueue.main) { [weak self] time in
            let duration = self?.player.currentItem?.duration
            let totalTime = Float(CMTimeGetSeconds(duration!))
            let second = Float(CMTimeGetSeconds(time))
            if (self?.delegate) != nil {
                self?.delegate?.musicProgress(second, totalTime)
            }
            printLog(second)
        }
    }
    
    func removerObserser() {
        statusObservation = nil
        if let observerToken = timeObserverToken {
            player.removeTimeObserver(observerToken)
            timeObserverToken = nil
        }
    }
}

// MARK: 代理
protocol MusicPlayerDelegate: AnyObject {
    /// 进度回调
    func musicProgress(_ progerss: Float, _ totalTime: Float)
}
