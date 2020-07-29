import Foundation
import UIKit

class TextTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelText: UILabel!
    
    func setUI(withData data: Sample.SampleData.HZData) {
        labelText.text = data.text
    }
}
