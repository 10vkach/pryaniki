import Foundation

protocol SampleLoaderDelegate: AnyObject {
    func sampleLoaded(sample: Sample)
    func sampleLoadingError(error: Error)
}
