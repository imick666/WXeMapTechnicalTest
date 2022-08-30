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
        
        super.init(frame: .zero)
        
        nameLabel.text = annotation.title
        descriptionTextView.text = annotation.poiDescription
        adressLabel.text = annotation.address

        imageView.sd_setImage(with: annotation.mediaUrl, placeholderImage: UIImage(named: "placeholder"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subviews
    
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
    
    private var nameLabel: UILabel = {
       let view = UILabel()
        view.textColor = .black
        view.textAlignment = .left
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        view.numberOfLines = 2
        view.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var nameLabelView: UIView = {
       let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.5)
        view.layer.cornerRadius = 10
        
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var adressLabel: UILabel = {
       let view = UILabel()
        view.textAlignment = .right
        view.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        view.textColor = .black
        view.numberOfLines = 0
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var addressLabelView: UIView = {
       let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.5)
        view.layer.cornerRadius = 10
        
        view.clipsToBounds = true
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
        let mainStackView = setupMainStackView(withWidthOf: width)
        
        let height = mainStackView.systemLayoutSizeFitting(.zero).height
        let xPoint = rect.midX - (width / 2)
        let yPoint = rect.minY - height
        self.frame = CGRect(x: xPoint, y: yPoint, width: width, height: height)
        
        self.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        view.addSubview(self)
        
    }
    
    func dismissCallout(animated: Bool) {
        removeFromSuperview()
    }
    
    // MARK: - Subviews Setup
    
    private func setupMainStackView(withWidthOf width: CGFloat) -> UIView {
        
        let mainStackView = mainStackView
        let headerView = setupHeader()
        let descriptionView = setupDescriptionView()
        
        mainStackView.addArrangedSubview(headerView)
        mainStackView.addArrangedSubview(descriptionView)
        
        NSLayoutConstraint.activate([
            mainStackView.widthAnchor.constraint(equalToConstant: width)
        ])
        
        return mainStackView
    }
    
    private func setupHeader() -> UIView {
        
        let headerView = headerView
        let imageView = imageView
        let nameView = setupNameView()
        let addressView = setupAddressView()
        
        headerView.addSubview(imageView)
        headerView.addSubview(nameView)
        headerView.addSubview(addressView)
        
        NSLayoutConstraint.activate([
            // ImageView
            imageView.topAnchor.constraint(equalTo: headerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            // NameLabel
            nameView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            nameView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 8),
            nameView.trailingAnchor.constraint(lessThanOrEqualTo: headerView.trailingAnchor, constant: -8),
            nameView.bottomAnchor.constraint(equalTo: adressLabel.topAnchor, constant: -16),
            
            // AdressLabel
            addressView.leadingAnchor.constraint(greaterThanOrEqualTo: headerView.leadingAnchor, constant: 8),
            addressView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8),
            addressView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -8)
        ])
        
        return headerView
    }
    
    private func setupNameView() -> UIView {
        
        let nameView = nameLabelView
        let nameLabel = nameLabel
        
        nameView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: nameView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: nameView.leadingAnchor, constant: 8),
            nameLabel.bottomAnchor.constraint(equalTo: nameView.bottomAnchor, constant: -8),
            nameLabel.trailingAnchor.constraint(equalTo: nameView.trailingAnchor, constant: -8),
        ])
        
        return nameView
    }
    
    private func setupAddressView() -> UIView {
        
        let addressView = addressLabelView
        let addressLabel = adressLabel
        
        addressView.addSubview(addressLabel)
        
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: addressView.topAnchor, constant: 8),
            addressLabel.leadingAnchor.constraint(equalTo: addressView.leadingAnchor, constant: 8),
            addressLabel.bottomAnchor.constraint(equalTo: addressView.bottomAnchor, constant: -8),
            addressLabel.trailingAnchor.constraint(equalTo: addressView.trailingAnchor, constant: -8),
        ])
        
        return addressView
    }
    
    
    
    private func setupDescriptionView() -> UIView {
        let descriptionView = descriptionTextView
        
        return descriptionView
    }
}
