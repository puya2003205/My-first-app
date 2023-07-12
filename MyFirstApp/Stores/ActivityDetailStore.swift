import SwiftUI

@MainActor
class ActivityDetailStore: ObservableObject {
    @Published var comments: [Comment] = []
    @Published var allComments: [Comment] = []
    
    //Creare URL pentru fisierul cu toate comentariile
    private func allCommentsFileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("allComments.data")
    }
    
    //Creare URL separat pentru fiecare fisier cu comentarii de la fiecare activitate
    func fileURL(nameForDetailsFile: String) throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(nameForDetailsFile + ".data")
    }
    
    //Functia pentru incarcarea comentariilor separate pe activitati
    func loadComments(for url: URL) async throws {
        let task = Task<[Comment], Error> {
            guard let data = try? Data(contentsOf: url) else {
                return []
            }
            let comments = try JSONDecoder().decode([Comment].self, from: data)
            return comments
        }
        let comments = try await task.value
        self.comments = comments
    }
    
    //Functia pentru salvarea unui comentariu in fisiere separate pe activitati
    func saveComment(_ comment: Comment, for url: URL) async throws {
        let task = Task {
            do {
                try await loadComments(for: url)
                comments.append(comment)
                let data = try JSONEncoder().encode(comments)
                try data.write(to: url)
            } catch {
                print(error)
            }
        }
        _ = await task.value
    }
    
    //Functia pentru incarcarea comentariilor din fisierul care le contine pe toate
    func loadAllComments() async throws {
        let task = Task<[Comment], Error> {
            let fileURL = try allCommentsFileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let comments = try JSONDecoder().decode([Comment].self, from: data)
            return comments
        }
        let comments = try await task.value
        self.allComments = comments
    }
    
    //Functia pentru salvarea comentariilor la comun
    func saveCommentInAllComments(_ comment: Comment) async throws {
        let task = Task {
            do {
                try await loadAllComments()
                allComments.append(comment)
                let data = try JSONEncoder().encode(allComments)
                let outfile = try allCommentsFileURL()
                try data.write(to: outfile)
            } catch {
                print(error)
            }
        }
        _ = await task.value
    }
}
