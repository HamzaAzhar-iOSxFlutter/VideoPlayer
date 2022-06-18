//
//  VideoCardView.swift
//  VideoPlayer
//
//  Created by Hamza Azhar on 18/06/2022.
//

import SwiftUI

struct VideoCardView: View {
    
    var video: Video
    
    var body: some View {
        ZStack(alignment: .center) {
            ZStack(alignment: .bottomLeading) {
                if #available(iOS 15.0, *) {
                    AsyncImage(url: URL(string: self.video.image ?? "")) { image in
                        image.resizable()
                            .scaledToFill()
                            .frame(width: 160, height: 250, alignment: .center)
                            .cornerRadius(30)
                    } placeholder: {
                        Rectangle()
                            .foregroundColor(.gray.opacity(0.3))
                            .frame(width: 160, height: 250, alignment: .center)
                            .cornerRadius(30)
                    }
                } else {
                    Rectangle()
                        .foregroundColor(.gray.opacity(0.3))
                        .frame(width: 160, height: 250, alignment: .center)
                        .cornerRadius(30)
                }
                
                self.buildVideoDetails()
            }
            
            self.buildPlayImage()
        }
    }
    
    fileprivate func buildPlayImage() -> some View {
        return(  Image(systemName: "play.fill")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Circle().foregroundColor(.gray.opacity(0.2))))
    }
    
    fileprivate func buildVideoDetails() -> some View {
        return(    VStack(alignment: .leading) {
            Text("\(self.video.duration ?? 0) sec")
                .font(.caption).bold()
            
            Text("By \(self.video.user?.name ?? "")")
                .font(.caption).bold()
                .multilineTextAlignment(.leading)
            
        }
        .padding()
        .foregroundColor(.white))
    }
}

struct VideoCardView_Previews: PreviewProvider {
    static var previews: some View {
       VideoCardView(video: Video(id: nil, url: nil, image: nil, duration: nil, user: nil, videoFiles: nil))
    }
}
