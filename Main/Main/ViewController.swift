//
//  ViewController.swift
//  Main
//
//  Created by wangkan on 2017/5/24.
//  Copyright © 2017年 rockgarden. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player : AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 证明使用资产目录为杂项资源还显示资产目录“命名空间”demonstrate use of an asset catalog for miscellaneous resource also demonstrate asset catalog "namespace"
        let theme = NSDataAsset(name: "music/theme")!
        self.player = try! AVAudioPlayer(data: theme.data)
        self.player.play()
    }
    
}
