import SwiftUI

@MainActor
class ActivityDetailStore: ObservableObject {
    @Published var comments: [CommentStruct] = []
    
    var nameForDetailsFile: String = ""
    var fileNameDetails: String {
        return nameForDetailsFile + ".data"
    }
    
    private func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(fileNameDetails)
    }
    
    func loadComments() async throws {
            let task = Task<[CommentStruct], Error> {
                let fileURL = try fileURL()
                guard let data = try? Data(contentsOf: fileURL) else {
                    return []
                }
                let comments = try JSONDecoder().decode([CommentStruct].self, from: data)
                return comments
            }
            let comments = try await task.value
            self.comments = comments
        }
        
        func saveComment(_ comment: CommentStruct) async throws {
            let task = Task {
                do {
                    try await loadComments()
                    comments.append(comment)
                    let data = try JSONEncoder().encode(comments)
                    let outfile = try fileURL()
                    try data.write(to: outfile)
                } catch {
                    print(error)
                }
            }
            try await loadComments()
            _ = await task.value
        }
    }
