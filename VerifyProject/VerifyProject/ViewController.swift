//
//  ViewController.swift
//  VerifyProject
//
//  Created by wangcong on 24/05/2017.
//  Copyright © 2017 ApterKing. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {

    let content: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.layer.borderWidth = 2.0
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(content)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        content.frame = self.contentView.bounds
    }

}

class ViewController: UIViewController {

    let dataSource: [String] = {
        var configPath = Bundle.main.path(forResource: "Config", ofType: nil)
        var config = try? String(contentsOfFile: configPath!, encoding: .utf8)
        guard let module = config else {
            return []
        }
        return module.components(separatedBy: ",")
    }()

    lazy var collectionView: UICollectionView = { [unowned self] in
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        let collectionView = UICollectionView(frame: CGRect(origin:CGPoint(x: 0, y: 30), size: UIScreen.main.bounds.size), collectionViewLayout: flowLayout)
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: NSStringFromClass(CustomCell.self))
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.view.addSubview(collectionView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(CustomCell.self), for: indexPath) as! CustomCell
        cell.content.text = dataSource[indexPath.row]
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.size.width - 40) / 3, height: (UIScreen.main.bounds.size.width - 40) / 3)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let module = dataSource[indexPath.row]
        let className = module + "ViewController"
        let classType = NSClassFromString(className) as? UIViewController.Type
        if let type = classType {
            let controller = type.init()
            self.present(controller, animated: true, completion: {

            })
        }
    }
}
