import Foundation
import UIKit

class PickerTableViewCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate {
        
    private var data: Sample.SampleData.SelectorData?
    private weak var superDelegate: PickerViewSuperDelegate?
    private var selfIndexPath: IndexPath?
    
    @IBOutlet weak var picker: UIPickerView!
    
    func config(indexPath: IndexPath, superDelegate: PickerViewSuperDelegate) {
        self.selfIndexPath = indexPath
        self.superDelegate = superDelegate
    }
    
    func setUI(withData data: Sample.SampleData.SelectorData) {
        self.data = data
        picker.dataSource = self
        picker.delegate = self
        picker.selectRow(data.selectedId, inComponent: 0, animated: false)
        picker.reloadAllComponents()
    }
    
//MARK: PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return data?.variants.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return data?.variants[row].text
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        
        guard let safeIndexPath = selfIndexPath else {
            print("Ошибка: selfIndexPath == nil")
            return }
        
        superDelegate?.pickerView(pickerView: picker,
                                  didSelectRow: row,
                                  inCell: safeIndexPath)
    }
}
