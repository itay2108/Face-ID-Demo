//
//  LoadableView.swift
//  Car Data
//
//  Created by Itay Gervash on 28/12/2022.
//

import SwiftUI

/// Provided a Loadable object, fetches and displays data according to it's ``LoadingState``.
///
///  - LoadingContent is displayed when ``Loadable/state`` is .loading. Provide ``LoadingView()`` for a default progressView loader.
///  - Content is displayed when ``Loadable/state`` is .loaded(). ``Loadable/LoadableDataType`` gets captured to display the fetched data
public struct LoadableView<VM: Loadable, LoadingContent: View, Content: View>: View {
    @ObservedObject var viewModel: VM
    @State private var presentAlert = true
    
    private let errorStyle: LoadableViewErrorConfiguration
    
    let loadingContent: () -> LoadingContent
    let content: (VM.LoadableDataType) -> Content
    
    @State private var dataTask: Task<Void, Never>?
    
    /// Initializes a ``LoadableView`` that uses a ``Loadable`` object to fetch and present data.
    /// - Parameters:
    ///   - viewModel: a ``Loadable`` that will call ``Loadable.fetchData()`` on appear
    ///   - errorStyle: a configuration for the error view
    ///   - loadingContent: The view that will be displayed during the data fetch
    ///   - content: The view that will be displayed when data is fetched. captures  the ``Loadable.LoadableDataType`` that was fetched on appear.
    public init(
        viewModel: VM,
        errorStyle: LoadableViewErrorConfiguration = .fullHeight,
        @ViewBuilder loadingContent: @escaping () -> LoadingContent,
        @ViewBuilder content: @escaping (VM.LoadableDataType) -> Content
    ) {

        self.viewModel = viewModel
        self.content = content
        self.loadingContent = loadingContent
        self.errorStyle = errorStyle
    }
    
    public var body: some View {
        
        ZStack {
            switch viewModel.state {
            case .failed(let err):
                ErrorView(error: err)
            case .loading:
                loadingContent()
            case .loaded(let response):
                content(response)
            default:
                EmptyView()
            }
        }
        .onAppear {
            if viewModel.state == .idle {
                dataTask = Task {
                    await viewModel.fetchData()
                }
            }
        }
        
    }
    
    @ViewBuilder
    func ErrorView(error: Error) -> some View {
        
        switch errorStyle {
        case .hidden:
            Color.clear
        case .empty:
            VStack {
                Spacer()
                Color.clear
                Spacer()
            }
        case .fullHeight:
            fullHeightErrorView(forError: error)
        default:
            defaultErrorView(forError: error)
        }
    }
    
    @ViewBuilder
    private func fullHeightErrorView(forError error: Error) -> some View {
        VStack {
            Spacer()
            Text(error.localizedDescription)
                .alert(isPresented: $presentAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text("\(error.localizedDescription)"),
                        dismissButton: .default(Text("OK"))
                    )
                }
            Spacer()
        }
    }
    
    @ViewBuilder
    private func defaultErrorView(forError error: Error) -> some View {
        Text("Error")
            .alert(isPresented: $presentAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text("\(error.localizedDescription)"),
                    dismissButton: .default(Text("OK"))
                )
            }
    }
}
