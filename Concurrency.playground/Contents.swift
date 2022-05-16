import UIKit

let service = Service()

// MARK: Async but not in parallel
func retrieveNames() async {
    do {
        let name1 = try await service.retrieveSample(from: "")
        let name2 = try await service.retrieveSample(from: "")
        print("NAMES: \(name1), \(name2)")
    } catch {
        print("Unexpected error: \(error)")
    }
}

// MARK: Async and parallel
func retrieveNamesInParallel() async {
    do {
        async let name1 = try service.retrieveSample(from: "")
        async let name2 = try service.retrieveSample(from: "")
        
        let (nameOne, nameTwo) = await (try name1, try name2)
        
        print("NAMES: \(nameOne), \(nameTwo)")
    } catch {
        print("Unexpected error: \(error)")
    }
}

// TODO: Async sequences
