
import UIKit

protocol SettingsPresentingViewControllerDelegate: class {
    func didSaveSettings(settings: GithubRepoSearchSettings)
    func didCancelSettings()
}

class SettingsViewController: UIViewController {
    
weak var delegate: SettingsPresentingViewControllerDelegate?
    
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderValue: UILabel!
    
    var settings : GithubRepoSearchSettings?
    var value : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         sliderValue.text = "\(settings!.minStars)"
         slider.value = Float(settings!.minStars)
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        self.delegate?.didCancelSettings()
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func save(_ sender: Any) {
        settings?.minStars = Int(sliderValue.text!)!
        self.delegate?.didSaveSettings(settings: settings!)
    }
    
    @IBAction func sliderAction(_ sender: Any) {
        self.sliderValue.text = "\(Int(slider.value))"
        value = Int(slider.value)
    }

}
