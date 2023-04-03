
import UIKit

class UserDefaultsPlaygroundController: UIViewController {
    
    private let userDefaultsManager = UserDefaultsManager.instance
    
    @IBOutlet weak private var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readAppTheme()
        readCurrentCount()
    }
    
    private func readCurrentCount() {
        let count = userDefaultsManager.getInt(key: .count)
        let countAsString = String(count)
        countLabel.text = countAsString
    }
    
    private func readAppTheme() {
        let appTheme = userDefaultsManager.getDecodableObject(key: .appTheme, type: AppTheme.self) ?? .yelllow
        
        switch appTheme {
        case .red:
            view.backgroundColor = .red
        case .yelllow:
            view.backgroundColor = .yellow
        }
    }
    
    @IBAction private func onRedPressed(_ sender: Any) {
        userDefaultsManager.setEncodableObject(
            object: AppTheme.red,
            key: .appTheme
        )
        view.backgroundColor = .red
    }

    @IBAction private func onYellowPressed(_ sender: Any) {
        userDefaultsManager.setEncodableObject(
            object: AppTheme.yelllow,
            key: .appTheme
        )
        view.backgroundColor = .yellow
    }
    
    @IBAction private func onIncrementPressed(_ sender: Any) {
        let currentCount = userDefaultsManager.getInt(key: .count)
        let nextCount = currentCount + 1
        userDefaultsManager.save(value: nextCount, key: .count)
        countLabel.text = String(nextCount)
    }
    
    
}
