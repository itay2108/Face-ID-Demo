//
//  Loadable.swift
//  Car Data
//
//  Created by Itay Gervash on 27/12/2022.
//

import Foundation

/// Implemntation of Loadable provides the ability to load, store and dispatch generic data
///
/// Inherits from ObservableObject, and is used by ``LoadableView`` to fetch data and capture it to display in a provided view
///
/// - Values & Methods:
///   - result: Optionally holds the return value of the loader, to fetch it later without calling a webservice
///   - state: Represents the loading state of the object. Different states notify relevant listeners on data changes
///   - ``loader()``:  Provide the method that fetches the data in ``fetchData()``.
///   - ``onLoaded(newValue:)``: Optionally gives the ability to use the loaded value on every data fetch
///
public protocol Loadable: ObservableObject {
    associatedtype LoadableDataType
    
    ///Represents the loading state of the object. Different states notify relevant listeners on data changes
    var state: LoadingState<LoadableDataType> { get set }
    
    /// Provide the method that fetches the data in ``fetchData()``. Optionally provide multiple values in if else / switch statements
    /// - Returns: a Result structure the contains the LoadableDataType on success, and an Error otherwise.
    func loader() async -> Result<LoadableDataType, Error>
    
    ///Optionally gives the ability to use the loaded value on every data fetch
    func onLoaded(newValue result: LoadableDataType)
}

public extension Loadable {
    
    func onLoaded(newValue result: LoadableDataType) { }
    
    /// Tries to fetch the LoadableDataType from the async request defined in ``loader()``. Dispatches different ``LoadingState``s accordint to the fetch result.
    ///
    /// - Is used by ``LoadableView`` to fetch data for the ``LoadableView/content``
    /// - ``LoadingState`` manipulation:
    ///     - Dispatches a .loading ``LoadingState`` before performing the request
    ///     - Dispatches a .loaded(LoadedValue) ``LoadingState`` on load
    ///     - Dispatches an .error ``LoadingState`` on failure of ``loader()``
    func fetchData() async {
        
        runOnMainThread { [weak self] in
            self?.state = .loading
        }
        
        let response = await loader()
        
        switch response {
        case .success(let loadedData):
            
            runOnMainThread { [weak self] in
                self?.state = .loaded(loadedData)
                self?.onLoaded(newValue: loadedData)
            }
            
        case .failure( let error):
            debugPrint("\(error.localizedDescription)")
            
            runOnMainThread { [weak self] in
                self?.state = .failed(error)
            }
        }
    }
    
}
