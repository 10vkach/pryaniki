import Foundation

struct SampleListModel {
    let view: [String]
    let data: [String: Sample.SampleData.DataType]
    
    init(sample: Sample) {
        view = sample.view
        var dataDummy: [String: Sample.SampleData.DataType] = [:]
        sample.data.forEach({ dataDummy[$0.name] = $0.data })
        data = dataDummy
    }    
}
