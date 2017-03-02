

import UIKit
import MBProgressHUD

class RepoResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SettingsPresentingViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var desLabel: UILabel!
    
    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()
    var repos: [GithubRepo]!
  

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self

        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        doSearch()
    }
    

    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (repos != nil) { return repos.count} else { return 0}
    }
    
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! cellContent
        let data = repos[indexPath.row]
        let name = data.name
        let description = data.descriptions
        let star = data.stars!
        let fork = data.forks!
        let icon = URL(string: data.ownerAvatarURL!)
        let user = data.ownerHandle
       
    cell.descriptionLabel.text = name
    cell.title.text = description
    cell.star.text = "\(star)" // If star is greater than minimum, edit this <<<<<< =========
    cell.fork.text = "\(fork)"
    cell.icon.setImageWith(icon!)
    cell.userName.text = user
        
        return cell
    }
    
    
    func didSaveSettings(settings: GithubRepoSearchSettings) {
        
        searchSettings.minStars = settings.minStars //problem is here 
        dismiss(animated: true, completion: nil)
        doSearch()
    }
    
    func didCancelSettings() {
        print("cancel")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        let vc = navController.topViewController as! SettingsViewController
        vc.settings = searchSettings
        vc.delegate = self
    }

    // Perform the search.
    fileprivate func doSearch() {

        MBProgressHUD.showAdded(to: self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in
        
            // Print the returned repositories to the output window
            self.repos = newRepos
            
            for repo in newRepos {
                print(repo)
                }
            
            
            self.tableView.reloadData()
            
            
            MBProgressHUD.hide(for: self.view, animated: true)
            }, error: { (error) -> Void in
                print(error!)
        })
    }
}






// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}
