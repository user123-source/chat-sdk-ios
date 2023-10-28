//
//  Message.swift

//
//  Created by ben3 on 18/07/2020.
//

import Foundation
import AVFoundation

public protocol Message {
    
    func messageId() -> String
    func messageType() -> String
    func messageDate() -> Date
    func messageText() -> String?
    func messageSender() -> User
    func messageMeta() -> [AnyHashable: Any]?
    func messageDirection() -> MessageDirection
    func messageReadStatus() -> MessageReadStatus
    func messageReply() -> Reply?
    func messageContent() -> MessageContent?
    func messageSendStatus() -> MessageSendStatus?

}

public protocol DownloadableMessage: Message {
    
    var isDownloading: Bool {
        get set
    }
    
    func setDownloadProgress(_ progress: Float, total: Float)

    func startDownload()
    func isDownloaded() -> Bool
    
    func downloadStarted()
    func downloadPaused()

    func downloadFinished(_ url: URL?, error: Error?)
}

public protocol HasImage {
    func imageURL() -> URL?
}

public protocol HasPlaceholder {
    func placeholder() -> UIImage?
}

public extension DownloadableMessage {
    
    func pauseDownload() {
        ChatKit.downloadManager().pauseTask(messageId())
    }
    
    func downloadStarted() {
        if let content = messageContent() as? DownloadableContent {
            content.downloadStarted?()
        }
    }

    func downloadPaused() {
        if let content = messageContent() as? DownloadableContent {
            content.downloadPaused?()
        }
    }
    
    func setDownloadProgress(_ progress: Float, total: Float) {
        if let content = messageContent() as? DownloadableContent {
            content.setDownloadProgress?(progress, total: total)
        }
    }

}

public protocol UploadableMessage: Message {
    func uploadFinished(_ data: Data?, error: Error?)
}

public protocol AudioMessage: DownloadableMessage, UploadableMessage { //}, HasPlaceholder {
    
    var localAudioURL: URL? {
        get set
    }
    
    func duration() -> Double?
    func audioPlayer() -> AVAudioPlayer?

    func audioURL() -> URL?
}

public protocol ImageMessage: UploadableMessage, HasImage, HasPlaceholder {
}

public protocol StickerMessage: HasImage, HasPlaceholder {
}

public protocol GifMessage: HasImage {
}

public protocol VideoMessage: DownloadableMessage, ImageMessage {
    
    var localVideoURL: URL? {
        get set
    }
    
    func videoURL() -> URL?
}


