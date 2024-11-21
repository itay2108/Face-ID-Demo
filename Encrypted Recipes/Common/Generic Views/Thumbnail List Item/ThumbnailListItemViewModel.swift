//
//  ThumbnailListItemViewModel.swift
//  Encrypted Recipes
//
//  Created by Itay Gervash on 21/11/2024.
//

import Foundation
import Combine

final class ThumbnailListItemViewModel<T: ThumbnailListItemPresentable> {

    private let model: T

    // MARK: - View Data

    var title: String {
        model.title
    }

    var subtitle: String? {
        model.subtitle
    }

    var thumbnailUrl: URL? {
        guard let stringUrl = model.thumbnailStringUrl else { return nil }
        return URL(string: stringUrl)
    }

    // MARK: - Combine

    private let itemPressedSubject = PassthroughSubject<T, Never>()
    var itemPressedPublisher: AnyPublisher<T, Never> { itemPressedSubject.eraseToAnyPublisher() }

    // MARK: - Init

    init(model: T) {
        self.model = model
    }

    func itemTapped() {
        itemPressedSubject.send(model)
    }
}
