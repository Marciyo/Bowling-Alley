//
//  ScoreboardViewController.swift
//  Bowling Alley
//
//  Created by Marcel Mierzejewski on 14/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

final class ScoreboardViewController: UIViewController {
    private var collectionView: UICollectionView!
    private lazy var dataSource = makeDataSource()
    private var gameState = GameState.shared
    
    private var cancellable: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        let layout = UICollectionViewLayout()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: String(describing: UICollectionViewCell.self))
        collectionView.dataSource = dataSource

        collectionView.collectionViewLayout = layout
        
        cancellable = gameState.$players.sink(receiveValue: { (player) in
            player
        })
    }
}

/// MARK: - TableViewDataSource
private extension ScoreboardViewController {
    enum Section: Int, CaseIterable {
        case total, frames
    }
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, RegularFrame> {
        UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, frame in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UITableViewCell.self),
                                                              for: indexPath)
                
                return cell
        }
        )
    }
    
    func updateCollectionView(with frames: [RegularFrame], animate: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, RegularFrame>()
        snapshot.appendSections([.total, .frames])
        snapshot.appendItems(frames)
        dataSource.apply(snapshot, animatingDifferences: animate)
    }
}


extension ScoreboardViewController: UIViewControllerRepresentable {

    func updateUIViewController(_ uiViewController: ScoreboardViewController, context: Context) {
        print("Updaing VC", context)
    }
    
    func makeUIViewController(context: Context) -> ScoreboardViewController {
        return ScoreboardViewController()
    }
}
