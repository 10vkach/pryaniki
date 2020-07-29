import Foundation
import UIKit

class PictureTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageData: UIImageView!
    @IBOutlet weak var labelData: UILabel!
    
    func setUI(data: Sample.SampleData.PictureData) {
        labelData.text = data.text
        imageData.load(url: data.url)
    }
}
