//
//  TestCalloutView.swift
//  WeMapTechnicalTest
//
//  Created by Mickael Ruzel on 26/08/2022.
//

import Mapbox
import UIKit
import SDWebImage

final class PoiCalloutView: UIView, MGLCalloutView {
    
    // MARK: - Properties
    
    override var center: CGPoint {
        set {
            var value = newValue
            value.y -= bounds.midY
            super.center = value
        }
        get {
            return super.center
        }
    }
    
    var representedObject: MGLAnnotation
    var leftAccessoryView: UIView = UIView()
    var rightAccessoryView: UIView = UIView()
    var delegate: MGLCalloutViewDelegate?
    
    var isAnchoredToAnnotation: Bool = true
    var dismissesAutomatically: Bool = false
    
    // MARK: - Init
    
    init(annotation: Poi) {
        self.representedObject = annotation
        nameLabel.text = annotation.title
        descriptionTextView.text = annotation.poiDescription
        adressLabel.text = annotation.address
        
        imageView.sd_setImage(with: annotation.mediaUrl, placeholderImage: UIImage(named: "placeholder"))
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subviews
    
    private var nameLabel: UILabel = {
       let view = UILabel()
        view.backgroundColor = .white.withAlphaComponent(0.5)
        view.textColor = .black
        view.layer.cornerRadius = 10
        view.textAlignment = .left
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        view.numberOfLines = 2
        view.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var headerView: UIView = {
       let view = UIView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .white
        
        return view
    }()
    
    private var imageView: UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        return view
    }()
    
    private var adressLabel: UILabel = {
       let view = UILabel()
        view.textAlignment = .right
        view.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        view.backgroundColor = .white.withAlphaComponent(0.5)
        view.textColor = .black
        view.numberOfLines = 0
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var descriptionTextView: UITextView = {
       let view = UITextView()
        view.textColor = .black
        view.backgroundColor = .white
        view.isEditable = false
        
        view.isScrollEnabled = false
        view.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        return view
    }()
    
    private var mainStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Methodes
    
    func presentCallout(from rect: CGRect, in view: UIView, constrainedTo constrainedRect: CGRect, animated: Bool) {
        
        let width = constrainedRect.width * 0.8
        createView(from: rect, withWidthOf: width)
        
        view.addSubview(self)
        
    }
    
    func dismissCallout(animated: Bool) {
        removeFromSuperview()
    }
    
    private func createView(from pointViewRect: CGRect, withWidthOf width: CGFloat) {
        
        mainStackView.addArrangedSubview(setupHeader())
        mainStackView.addArrangedSubview(setupDescriptionView())
        
        self.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            self.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            self.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor),
            self.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            mainStackView.widthAnchor.constraint(equalToConstant: width)
        ])
        
        let height = mainStackView.systemLayoutSizeFitting(.zero).height
        let yPoint = pointViewRect.minY - height
        let xPoint = pointViewRect.midX - (width / 2)
        
        self.frame = CGRect(x: xPoint, y: yPoint, width: width, height: height)
    }
    
    
    
    // MARK: - Subviews Setup
    
    private func setupHeader() -> UIView {
        
        headerView.addSubview(imageView)
        headerView.addSubview(nameLabel)
        headerView.addSubview(adressLabel)
        
        NSLayoutConstraint.activate([
            // ImageView
            imageView.topAnchor.constraint(equalTo: headerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            // NameLabel
            nameLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: headerView.trailingAnchor, constant: -8),
            nameLabel.bottomAnchor.constraint(equalTo: adressLabel.topAnchor, constant: -16),
            
            // AdressLabel
            adressLabel.leadingAnchor.constraint(greaterThanOrEqualTo: headerView.leadingAnchor, constant: 8),
            adressLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8),
            adressLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -8)
        ])
        
        return headerView
    }
    
    private func setupDescriptionView() -> UIView {
        
        return descriptionTextView
    }
}
