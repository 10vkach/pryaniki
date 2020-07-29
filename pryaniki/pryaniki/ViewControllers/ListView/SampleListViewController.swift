import Foundation
import UIKit

protocol SampleListView: class {
    func setSampleList(sampleList: SampleListModel)
}

protocol PickerViewSuperDelegate {
    func pickerView(pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inCell indexPath: IndexPath)
}

class SampleListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SampleListView, PickerViewSuperDelegate {
    
    var presenter: SampleListPresenter!
    
    private var sampleList: SampleListModel?
    private let const = LocalConstants()
    
    @IBOutlet weak var tableView: UITableView!

//MARK: LifeCycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter.showSampleList()
        tableView.reloadData()
    }
    
//MARK: SampleListView
    func setSampleList(sampleList: SampleListModel) {
        
        self.sampleList = sampleList
    }

//MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleList?.view.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let key = sampleList?.view[indexPath.row] else { return UITableViewCell() }
        
        switch sampleList?.data[key] {
        case .text(let data):
            let cell = tableView.dequeueReusableCell(withIdentifier: const.textCellID, for: indexPath) as? TextTableViewCell
            cell?.setUI(withData: data)
            return cell ?? UITableViewCell()
        case .picture(let picture):
            let cell = tableView.dequeueReusableCell(withIdentifier: const.pictureCellID, for: indexPath) as? PictureTableViewCell
            cell?.setUI(data: picture)
            return cell ?? UITableViewCell()
        case .selector(let selector):
            let cell = tableView.dequeueReusableCell(withIdentifier: const.selectorCellID, for: indexPath) as? PickerTableViewCell
            cell?.config(indexPath: indexPath, superDelegate: self)
            cell?.setUI(withData: selector)
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
//MARK: PickerViewSuperDelegate
    func pickerView(pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inCell indexPath: IndexPath) {
    }
    
//MARK: LocalConstants
    struct LocalConstants {
        let textCellID = "textCellID"
        let pictureCellID = "pictureCellID"
        let selectorCellID = "selecorCellID"
    }
    
}


