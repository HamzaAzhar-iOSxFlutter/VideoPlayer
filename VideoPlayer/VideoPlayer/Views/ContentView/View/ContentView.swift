//
//  ContentView.swift
//  VideoPlayer
//
//  Created by Hamza Azhar on 18/06/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    @State private var query: QueryTypes = .nature
    
    let layout = [GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                VStack {
                    HStack {
                        ForEach(QueryTypes.allCases, id: \.self) { queryType in
                            QueryTagView(queryType: queryType, isSelected: self.viewModel.selectedQuery == queryType)
                                .onTapGesture {
                                    if self.viewModel.selectedQuery != queryType {
                                        self.viewModel.videosData = nil
                                        self.viewModel.selectedQuery = queryType
                                    }
                                }
                        }
                    }.padding(.top, 70)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        if self.viewModel.videosData == nil {
                            LoaderView()
                        } else {
                            self.buildVideoList()
                        }
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .background(Color("AccentColor"))
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
        }
    }
    
    fileprivate func buildVideoList() -> some View {
        let data = self.viewModel.videosData?.videos ?? []
        return LazyVGrid(columns: self.layout, spacing: 20) {
            ForEach(data, id: \.id) { video in
                NavigationLink {
                    VideoView(video: video)
                } label: {
                    VideoCardView(video: video)
                }
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
