# BestSwiftRepositories
[![codecov](https://codecov.io/gh/lucascesarnf/BestSwiftRepositories/branch/main/graph/badge.svg)](https://codecov.io/gh/lucascesarnf/BestSwiftRepositories)
[![Actions Status](https://github.com/lucascesarnf/BestSwiftRepositories/workflows/Build%20and%20test/badge.svg)](https://github.com/lucascesarnf/BestSwiftRepositories/actions)


 This project consumes the [GitHub](https://developer.github.com/v3/) API and was created to apply `Combine` with `MVVM`.    
### About the app
<p float="left">
  <img src="https://user-images.githubusercontent.com/23507127/130483388-1cf84c68-5901-46d8-bb5b-0092fcbe3f8e.png" width="200" />
  <img src="https://user-images.githubusercontent.com/23507127/130483384-d375d284-7237-47c7-bd9f-5326e7d9b2ec.png" width="200" /> 
  <img src="https://user-images.githubusercontent.com/23507127/130483391-ef93505c-9841-4a90-a264-3d4b1ea1c747.png" width="200" />
</p>

This is a very simple app that contains an infinite scroll of the best Swift repositories. There is no action in iteration with cells and contains only one screen.
The purpose is to apply good coding practices in a simple UI with few business rules.

### Code Concepts
* MVVM architecture
* ViewCode for Views
* Combine for data binding
* Unit tests
* Integrated tests using [Snapshots](https://github.com/pointfreeco/swift-snapshot-testing)

### Requirements
* Xcode 11.5
* Swift 5.2.4
* iOS 13.7

### Tests
To run the tests you will need to set the `iPhone 8` device, because of the snapshot tests.
