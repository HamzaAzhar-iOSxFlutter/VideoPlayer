//
//  QueryTagView.swift
//  VideoPlayer
//
//  Created by Hamza Azhar on 18/06/2022.
//

import SwiftUI

struct QueryTagView: View {
    var queryType: QueryTypes
    var isSelected: Bool
    
    var body: some View {
        Text(queryType.rawValue)
            .font(.caption)
            .bold()
            .foregroundColor(isSelected ? .black : .gray)
            .padding(10)
            .background(
                Color.gray.opacity(0.2)
            )
            .cornerRadius(10)
    }
}

struct QueryTagView_Previews: PreviewProvider {
    static var previews: some View {
        QueryTagView(queryType: QueryTypes.animals, isSelected: true)
            .previewLayout(.sizeThatFits)
            
    }
}
