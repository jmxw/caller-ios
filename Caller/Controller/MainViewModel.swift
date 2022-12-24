//
//  MainViewModel.swift
//  Caller
//
//  Created by Meng Li on 2022/12/24.
//

import AVFoundation
import RxCocoa
import RxSwift

final class MainViewModel: BaseViewModel {
    private let speechSynthesizer = AVSpeechSynthesizer()
    
    var message: Observable<String> {
        RecordManager.shared
            .observeRecord()
            .map {
                $0?.message ?? "暂无消息"
            }
            .distinctUntilChanged()
            .do(onNext: { [unowned self] in
                let nextUtterance = AVSpeechUtterance(string:"现在播放下一条消息：")
                nextUtterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")
                self.speechSynthesizer.speak(nextUtterance)
                for _ in 0...2 {
                    let utterance = AVSpeechUtterance(string: $0)
                    utterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")
                    self.speechSynthesizer.speak(utterance)
                }
            })
    }
    
    var comsumeTitle: Observable<String?> {
        RecordManager.shared.observeIsConsuming().map {
            $0 ? "结束" : "开始"
        }
    }
    
    var consumeColor: Observable<UIColor> {
        RecordManager.shared.observeIsConsuming().map {
            $0 ? .red : .blue
        }
    }
    
    func consume() {
        RecordManager.shared.toggleIsConsuming()
    }
}
