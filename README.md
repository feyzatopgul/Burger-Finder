# Burger Finder
<p align="center">
<img src= "https://i.imgur.com/aEHVFQd.png" width="150">

Burger Finder is a mobile iOS app developed with Swift. It is an app that users can find burger places in any location.

## Functionalities
A user can
- See popular burger places around if the location service is enabled. 
- Search burger places in any location
- Perform search using a list or a map
- Get place details (photos, ratings, price, address, hours, website and phone number)
- Call a place 
- Visit website of a place
- Get directions for a place
- Save a place into favorites
- Search a place in favorites

## Requirements

- iOS 16.2
- Xcode 14.2 

## Technologies

- Swift
- UIKIT
- MapKit
- CoreLocation
- CoreData

## Architecture

**MVVM** is used as design pattern because it reduces the complexity in view contollers, seperates the business logic from views and it is more testable. In Burger Finder each view controller has its own view model. View controllers have only view models that provide data for them.

There are five service classes that view models use. All these classes are designed using Singleton pattern. They have a shared instance and this instance is available from anywhere in the program. 

Dependency injection is performed to create loosely coupled objects. 

- **NetworkManager:** Handles network requests and decodes the returned ```JSON``` data into a model. It is a generic class that you can handle any network requests.

- **LocationManager:** By utilizing ```CoreLocation``` framework, this class is responsible for handling location authorization, tracking authorization status changes, and providing coordinates of the current location and a searched location.

- **ImageLoader:** Downloads an image using an image url and returns the image data. In memory image caching is implemented using ```NSCache``` to prevent downloading the same image multiple times and improve the app performance.

- **CoreDataManager:** ```CoreData``` is used for persistency. This class is responsible for fetching, filtering, saving and deleting data.

- **NetworkReachability:** Provides network connection status.

### Models&APIs

Models are created as immutable structs. They conform to ```Codable``` protocol that provides methods for encoding custom types into ```JSON``` data, or convert ```JSON``` data into a custom type. Models also conform to ```Hashable``` protocol which is a requirement for diffable data source used in ```tableView``` and ```collectionViews```. The diffable data source uses the hash values for all identifiers to determine what's changed.

Two different API endpoints are used. 
- Place Search API endpoint: to fetch places with the following parameters: ```query```, ```ll(latitude/longitude)```, ```categories```, ```fields```, ```sort``` and ```limit```. 
- Get Place Photos API endpoint: to retrieve photos of a place by using ```fsq_id``` and ```limit``` parameters.
<p align="center">
<img src= "https://i.imgur.com/4agFDdW.png" width="600">

### HomeView
<p align="center">
<img src= "https://media.giphy.com/media/QI9cAyHSC7NBQxswRY/giphy.gif" width="250"> &nbsp&nbsp&nbsp&nbsp&nbsp
<img src= "https://i.imgur.com/MKfQ3Nm.png" width="250"> &nbsp&nbsp&nbsp&nbsp&nbsp
<img src= "https://i.imgur.com/P2NeH0F.png" width="250"> &nbsp&nbsp&nbsp&nbsp&nbsp <br />

```HomeViewController``` displays maximum 10 popular burger places around if the location service is enabled. ```HomeViewModel``` gets the current location coordinates from ```LocationManager``` and performs a network call to FourSquare ```Place Search``` API endpoint via ```NetworkManager```. ```HomeViewModel``` downloads the first image of the place (if any) via ```ImageLoader```. Popular burger places are shown in a ```collectionView```. In ```HomeViewController``` there is a button that performs navigation to the ```SearchViewController```. If the location is not enabled, a warning view is displayed to ask users to enable the location. It shows an alert when the device is not connected to the internet, displays a message and a button to refresh the view. 
<p align="center">
<img src= "https://i.imgur.com/ykiC5F8.png" width="800">

### SearchView
<p align="center">
<img src= "https://media.giphy.com/media/1Rkfq6m9ZjDaJrAheI/giphy.gif" width="250"> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
<img src= "https://i.imgur.com/1amvVPS.png" width="250"> <br /> 

```SearchViewController``` have two```search bars``` to perform location and place searches. If the location is enabled, ```SearchViewController``` displays nearby burger places by default. ```SearchViewModel``` gets the current or searched location coordinates from the ```LocationManager``` and performs a network call to FourSquare ```Place Search``` API endpoint via ```NetworkManager```. ```SearchViewModel``` downloads the first image of the place (if any) via ```ImageLoader```. The results are displayed in a ```tableView``` or a ```mapView```. Users can switch the display mode between the ```tableView``` and the ```mapView```. In ```mapView``` custom annotations are created. Users can navigate to ```DetailsViewController``` from a ```tableView``` cell or an info button on the callout of an annotation on the ```mapView```. Maximum 50 results are displayed for each search. If the device is not connected to the internet, ```SearchViewController``` displays a message and a button to refresh the view.
<p align="center">
<img src= "https://i.imgur.com/qDAjPCp.png" width="800">

### DetailsView
<p align="center">
<img src= "https://media.giphy.com/media/bsIECnXDrokxyhPbjE/giphy.gif" width="250">  <br /> 

```DetailsViewController``` displays photos of the selected place in a ```collectionView```. Maximum 20 photos are shown. ```DetailsViewModel``` performs a network call to FourSquare ```Get Place Photos``` API endpoint via ```NetworkManager``` by using the place id and downloads the images via ```ImageLoader```. Users can navigate to ```PhotoViewController``` from a ```collectionView``` cell. Rating, price, address, hours, website and phone number information are displayed in a ```scrollView```. Deep linking is implemented to the website URL, phone number and directions. Users can save places to ```Favorites``` which provides offline access. ```DetailsViewModel``` handles saving and deleting places via ```CoreDataManager```. 
<p align="center">
<img src= "https://i.imgur.com/xfgR7sp.png" width="800">

### PhotoView
<p align="center">
<img src= "https://media.giphy.com/media/u8QtY4CpskwoM6u1kN/giphy.gif" width="250">  <br /> 

```PhotoViewController``` expands the selected photo and displays it. ```PhotoViewModel``` downloads the image via ```ImageLoader```. Custom animation is performed for presenting ```PhotoViewController```.
<p align="center">
<img src= "https://i.imgur.com/yUXYIiK.png" width="300">

### FavoritesView
<p align="center">
<img src= "https://media.giphy.com/media/hMfq6vbWZMx1pEdsRK/giphy.gif" width="250"> <br /> 

```FavoritesController``` displays the favorite places in a ```collectionView```. ```FavoritesViewModel``` performs fetching and filtering places via ```CoreDataManager```. ```Search bar``` is used to filter favorite places by the name or the location. Users can navigate to ```DetailsViewController``` from a ```collectionView``` cell.
<p align="center">
<img src= "https://i.imgur.com/4V2IpZl.png" width="300">

## Installation

1. Download and open ```Burger Finder.xcodeproj```.  
2. Navigate to ```ServiceManager/NetworkManager/NetworkConstants``` file and replace ```YOUR_KEY!``` with your FourSquare ```API_KEY```
3. Select an iOS simulator/iOS device(preferably iPhone)
4. If you are using a simulator, please provide a location from ```Features > Location```
5. Build and run. 

## Future Development Goals

- Pagination can be performed to fetch more data
- Autocomplete for location search can be added in SearchView
- Login/Logout and cloud integration can be added for multi device usage 

## Author
This project was built by Feyza Topgul as the final project of OnRamp - Realtor.com iOS Apprenticeship.

