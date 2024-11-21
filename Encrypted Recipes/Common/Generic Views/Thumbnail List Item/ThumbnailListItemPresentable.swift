//
//  ThumbnailListItemPresentable.swift
//  Encrypted Recipes
//
//  Created by Itay Gervash on 21/11/2024.
//

protocol ThumbnailListItemPresentable: Identifiable {
    var title: String { get }
    var subtitle: String? { get }
    var thumbnailStringUrl: String? { get }
}
