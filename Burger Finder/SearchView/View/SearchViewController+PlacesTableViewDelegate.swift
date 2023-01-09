//
//  SearchViewController+TableViewDelegate.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/26/22.
//

import Foundation
import UIKit

extension SearchViewController: UITableViewDelegate {
    
    //Navigate to DetailsViewController when placesTableView cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController()
        detailsVC.detailsViewModel.place = searchViewModel.searchedPlaces[indexPath.row]
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}


