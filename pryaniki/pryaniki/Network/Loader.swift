import Foundation

class Loader {
    
    weak var sampleLoaderDelegate: SampleLoaderDelegate?
    
    func loadSample() {
        let task = URLSession.shared.dataTask(with: URLMaker().sample(),
                                              completionHandler: {
                                                    self.parseSample(data: $0,
                                                                     response: $1,
                                                                     error: $2)
                                                    })
        task.resume()
    }
    
    private func parseSample(data: Data?,
                             response: URLResponse?,
                             error: Error?) {
        
        //Если получили ошибку, то обработать её и прерваться
        if let errorSafe = error {
            DispatchQueue.main.async {
                self.sampleLoaderDelegate?.sampleLoadingError(error: errorSafe)
            }
            return
        }
        
        if let dataSafe = data {
            //распарсить данные и запихать их в массив
            do {
                let response: Sample = try JSONDecoder().decode(Sample.self, from: dataSafe)
                DispatchQueue.main.async {
                    self.sampleLoaderDelegate?.sampleLoaded(sample: response)
                }
            } catch let error {
                DispatchQueue.main.async {
                    self.sampleLoaderDelegate?.sampleLoadingError(error: error)
                }
            }
        }
    }
}
