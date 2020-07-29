import UIKit

class MainViewController: UIViewController, SampleLoaderDelegate {
    
    let loader = Loader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loader.sampleLoaderDelegate = self
        loader.loadSample()
    }
    
//MARK: SampleLoaderDelegate
    func sampleLoaded(sample: Sample) {
        showSampleList(sample: sample)
    }
    
    func sampleLoadingError(error: Error) {
        print(error)
    }
    
    private func showSampleList(sample: Sample) {
        let model = SampleListModel(sample: sample)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let id = Constants().viewControllersID.sampleListID
        let view = storyBoard.instantiateViewController(withIdentifier: id) as! SampleListViewController
        let presenter = SampleList(view: view, model: model)
        view.presenter = presenter
        
        present(view, animated: true)
    }
}

