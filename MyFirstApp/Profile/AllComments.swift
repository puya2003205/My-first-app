//
//  AllComments.swift
//  MyFirstApp
//
//  Created by Andrei Stanciu on 07.07.2023.
//

import SwiftUI

struct AllComments: View {
    @ObservedObject var commentsStore: ActivityDetailStore
    
    
    var body: some View {
        VStack(alignment: .trailing) {
            ForEach(commentsStore.comments, id: \.id) { comment in
                HStack {
                    Text(comment.date)
                    Spacer()
                    Text(comment.activity?.title ?? "")
                    Spacer()
                    Text(comment.activity?.role?.rawValue ?? "")
                    Spacer()
                    Text(comment.comment)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.gray)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
            }
        }
    }
}
