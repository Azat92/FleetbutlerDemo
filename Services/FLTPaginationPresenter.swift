//
//  FLTPaginationPresenter.swift
//  FleetbutlerDemo
//
//  Created by Azat Almeev on 06.12.2017.
//  Copyright © 2017 Azat Almeev. All rights reserved.
//

import UIKit

/// Convenient protocol to represent objects list from
public protocol FLTPaginationModel {
    
    associatedtype T
    var objects: [T] { get }
}

/// Base class for use in presenters which displays list data lazily
open class FLTPaginationPresenter<W, T: FLTPaginationModel> where T.T == W {

    /// Default page size
    private let pageSize = 10
    
    /// Current page
    private var pageToLoad = 1
    
    /// Represents is there any other data to be fetched
    public private (set) var hasMore = true
    
    /// Currently fetched models
    public private (set) var objects: [W] = []
    
    /// Token to cancel previous request
    private var cancellation: Cancellable?
    
    /// Convenient getter to check is there is some active request being performed
    private var isLoading: Bool {
        return cancellation != nil
    }
    
    public init() {
        
    }
    
    /// Function which loads data. Should be overridden in subclass
    ///
    /// - Parameters:
    ///   - page: page to load
    ///   - completion: callback for result
    /// - Returns: cancellation token
    open func load(page: Int, completion: @escaping (FLTResult<T>) -> Void) -> Cancellable {
        fatalError("Should override")
    }
    
    /// Called when it is required to show reloaded data
    ///
    /// - Parameter objects: objects to display now
    open func on(reload objects: [W]) {
        
    }
    
    /// Called when it is required to append new objects
    ///
    /// - Parameter objects: objects to append
    open func on(append objects: [W]) {
        
    }
    
    /// Called when error occured during network request
    ///
    /// - Parameter error: error to handle
    open func on(error: Error) {
        
    }
    
    /// Call to reload data
    public func reload() {
        if let token = cancellation {
            token()
        }
        objects = []
        hasMore = true
        on(reload: objects)
        pageToLoad = 1
        cancellation = load(page: pageToLoad) { [weak self] result in
            self?.loadHandler(result: result) { objects in
                self?.objects = objects
                self?.on(reload: objects)
            }
        }
    }
    
    /// Call to load more data lazily
    public func loadMore() {
        guard !isLoading, hasMore else { return }
        cancellation = load(page: pageToLoad) { [weak self] result in
            self?.loadHandler(result: result) { objects in
                self?.objects.append(contentsOf: objects)
                self?.on(append: objects)
            }
        }
    }
    
    private func loadHandler(result: FLTResult<T>, successAction: ([W]) -> Void) {
        switch result {
        case .success(let container):
            hasMore = container.objects.count == pageSize
            cancellation = nil
            pageToLoad += 1
            successAction(container.objects)
        case .failure(let error):
            cancellation = nil
            on(error: error)
        }
    }
}
