import Foundation

protocol SampleLoaderDelegate: class {
    func sampleLoaded(sample: Sample)
    func sampleLoadingError(error: Error)
}
