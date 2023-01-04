//
//  SearchViewController+TableViewDelegate.swift
//  Burger Finder
//
//  Created by fyz on 12/26/22.
//

import Foundation
import UIKit

extension SearchViewController: UITableViewDelegate {
    
    //Navigate to DetailsViewController when placesTableView cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController()
        detailsVC.place = places[indexPath.row]
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
