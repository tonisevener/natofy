//
//  AlphabetView.swift
//  Natofy
//
//  Created by Toni Sevener on 1/24/21.
//

import SwiftUI

struct AlphabetView: View {
    
    let data = NatoConverter.alphabetArray
    @Environment(\.horizontalSizeClass) var sizeClass

    let compactColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let regularColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        let columns = sizeClass == .compact ? compactColumns : regularColumns
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(data) { item in
                    VStack {
                        Text(item.short)
                            .font(.system(.largeTitle))
                            .fontWeight(.black)
                        Text(item.long)
                            .font(.title)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                    
                }
            }
            .padding()
        }
        .navigationTitle("Alphabet")
    }
}

struct AlphabetView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AlphabetView()
        }
        
    }
}
