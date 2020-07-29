import Foundation

protocol SampleListPresenter {
    init(view: SampleListView, model: SampleListModel)
    func showSampleList()
}

class SampleList: SampleListPresenter {
    
    unowned let sampleListView: SampleListView
    
    let sampleListModel: SampleListModel
    
    required init(view: SampleListView, model: SampleListModel) {
        sampleListView = view
        sampleListModel = model
    }
    
    func showSampleList() {
        sampleListView.setSampleList(sampleList: sampleListModel)
    }
    
    deinit {
        print("SampleList deinit")
    }
}
