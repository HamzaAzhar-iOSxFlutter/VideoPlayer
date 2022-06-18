//
//  VideoView.swift
//  VideoPlayer
//
//  Created by Hamza Azhar on 18/06/2022.
//

import SwiftUI
import AVKit

struct VideoView: View {
    var video: Video
    @State private var player = AVPlayer()
    
    var body: some View {
        VideoPlayer(player: self.player)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                if let link = self.video.videoFiles?.first?.link {
                    self.player = AVPlayer(url: URL(string: link)!)
                    self.player.play()
                }
            }
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView(video: Video(id: nil, url: nil, image: nil, duration: nil, user: nil, videoFiles: nil))
    }
}
