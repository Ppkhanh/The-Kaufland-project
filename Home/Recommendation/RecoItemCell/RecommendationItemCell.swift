//
//  RecommendationItemCell.swift
//  KMarketPlaceKit
//
//  Created by Marcus Hopp on 05.11.21.
//

import Nuke
import UIKit
import Combine

class RecommendationItemCell: UICollectionViewCell, Reusable {
    typealias UIConst = Constants.PDP
    
    private var subscribers = Set<AnyCancellable>()
    var comingFromEmptyWishlistCart: Bool = false
    var wishlistErrorNotification: (() -> Void)?
    
    @IBOutlet private weak var energyRangeButton: UIButton! {
        didSet {
            energyRangeButton.titleLabel?.font = UIConst.recommendationEnergyRangeLabelFont
            energyRangeButton.setTitleColor(KauflandColors.secondary700, for: .normal)
        }
    }
    @IBOutlet private weak var dataSheetButton: UIButton! {
        didSet {
            let dataSheetText = NSAttributedString(string: Strings.mpProductDataSheet.localized,
                                                   attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue,
                                                                .underlineColor: KauflandColors.secondary700,
                                                                .foregroundColor: KauflandColors.empress,
                                                                .font: UIConst.dataSheetButtonFont])
            dataSheetButton.setAttributedTitle(dataSheetText, for: .normal)
        }
    }
    @IBOutlet private weak var multipleEnergyBadgesView: RecommenderEnergyBadgesView! {
        didSet {
            multipleEnergyBadgesView.isVertical = true
        }
    }
    
    @IBOutlet private weak var recommendationImageView: UIImageView! {
        didSet {
            recommendationImageView.image = UIImage(named: UIConst.recommendationPlaceHolderImageName, in: Bundle.main, compatibleWith: nil)
        }
    }
    @IBOutlet private weak var recommendationNameLabel: UILabel! {
        didSet {
            recommendationNameLabel.font = UIConst.recommendationNameLabelFont
            recommendationNameLabel.textColor = KauflandColors.secondary900
        }
    }
    
    @IBOutlet private weak var ageVerificationTitleLabel: UILabel! {
        didSet {
            ageVerificationTitleLabel.font = UIConst.ageRestrictionTitleFont
            ageVerificationTitleLabel.textColor = KauflandColors.secondary900
            ageVerificationTitleLabel.text = Strings.mpLockTitle.localized
        }
    }
    
    @IBOutlet private weak var ageVerificationDescriptionLabel: UILabel! {
        didSet {
            ageVerificationDescriptionLabel.font = UIConst.ageRestrictionSubtitleFont
            ageVerificationDescriptionLabel.textColor = KauflandColors.secondary900
            ageVerificationDescriptionLabel.text = Strings.mpLockDescription.localized
        }
    }
    
    @IBOutlet private weak var ratingsView: RatingsView!
    @IBOutlet private weak var ageVerificationView: UIView!
    @IBOutlet private weak var referencePriceLabel: UILabel! {
        didSet {
            referencePriceLabel.font = UIConst.recommendationBasePriceLabelFont
            referencePriceLabel.textColor = KauflandColors.secondary700
        }
    }
    @IBOutlet private weak var priceLabel: UILabel! {
        didSet {
            priceLabel.font = UIConst.recommendationPriceLabelFont
            priceLabel.textColor = KauflandColors.secondary900
        }
    }
    @IBOutlet private weak var discountLabel: TagLabel! {
        didSet {
            discountLabel.font = UIConst.recommendationDiscountLabelFont
            discountLabel.textColor = KauflandColors.primary900
            discountLabel.backgroundColor = KauflandColors.lightRed
            discountLabel.leftInset = UIConst.recommendationDiscountLabelInset
            discountLabel.rightInset = UIConst.recommendationDiscountLabelInset
        }
    }
    @IBOutlet private weak var shippingLabel: UILabel! {
        didSet {
            shippingLabel.font = UIConst.recommendationShippingLabelFont
            shippingLabel.textColor = KauflandColors.secondary900
        }
    }
    @IBOutlet private weak var fbkLabel: UILabel! {
        didSet {
            fbkLabel.font = Fonts.kauflandFont12
            fbkLabel.textColor = KauflandColors.fbkBlue
        }
    }
    @IBOutlet private weak var badgeLabel: TagLabel! {
        didSet {
            badgeLabel.leftInset = UIConst.recommendationBadgeLabelInset
            badgeLabel.rightInset = UIConst.recommendationBadgeLabelInset
            badgeLabel.font = UIConst.recommendationBadgeLabelFont
            badgeLabel.textColor = KauflandColors.primary900
            badgeLabel.backgroundColor = KauflandColors.lightRed
            badgeLabel.layer.cornerRadius = UIConst.recommendationBadgeLabelCornerRadius
            badgeLabel.layer.masksToBounds = true
            badgeLabel.layer.maskedCorners = [.layerMaxXMaxYCorner]
        }
    }
    @IBOutlet private weak var wishlishButton: UIButton!
    @IBOutlet private weak var rangeDataSheetView: UIStackView!
    
    private let packagingLabel: UILabel = {
        let label = UILabel()
        label.font = UIConst.recommendationDepositLabelFont
        label.textColor = KauflandColors.secondary700
        return label
    }()
    private let basePriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIConst.recommendationPackagingLabelFont
        label.textColor = KauflandColors.secondary700
        return label
    }()
    
    @IBOutlet private weak var additionalInformationStackView: UIStackView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        recommendationImageView.image = UIImage(named: UIConst.recommendationPlaceHolderImageName,
                                                in: Bundle.main,
                                                compatibleWith: nil)
    }
    
    var viewModel: RecommendationItemViewModel? {
        didSet {
            multipleEnergyBadgesView.viewModel = viewModel?.energyBadgesViewModel()
            ratingsView.viewModel = viewModel?.ratingsViewModel
            
            recommendationNameLabel.text = viewModel?.name
            recommendationNameLabel.numberOfLines = viewModel?.numberOfLinesForNameLabel ?? 0
            
            priceLabel.text = viewModel?.price
            referencePriceLabel.text = viewModel?.referencePrice
            discountLabel.text = viewModel?.discount
            shippingLabel.text = viewModel?.shipping
            fbkLabel.text = viewModel?.fbkInfoText
            badgeLabel.text = viewModel?.badgeText
            
            energyRangeButton.setTitle(viewModel?.energyRange, for: .normal)
            basePriceLabel.text = viewModel?.basePrice
            packagingLabel.text = viewModel?.packagingText
            
            badgeLabel.isHidden = viewModel?.badgeText == nil
            energyRangeButton.isHidden = viewModel?.shouldHideEnergyRange ?? true
            dataSheetButton.isHidden = viewModel?.shouldHideDataSheet ?? true
            rangeDataSheetView.isHidden = viewModel?.shouldHideRangeDataSheet ?? true
            ageVerificationView.isHidden = viewModel?.shouldHideAgeVerification ?? true
            
            setupImageView()
            setupAdditionalInformationView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
        addShadow()
    }
    
    private func setupView() {
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        
        layer.masksToBounds = false
    }
    
    private func setupImageView() {
        guard let imageUrl = viewModel?.imageUrl else { return }
        Nuke.loadImage(with: imageUrl, options: ImageLoadingOptions(failureImage: UIImage(named: "failure", in: Bundle.main, compatibleWith: nil)), into: recommendationImageView)
    }
    
    private func setupAdditionalInformationView() {
//        additionalInformationStackView.arrangedSubviews.forEach { [weak self] view in
//            self?.additionalInformationStackView.removeArrangedSubview(view, shouldRemoveFromSuperview: true)
//        }
        
        if viewModel?.packagingText != nil {
            additionalInformationStackView.addArrangedSubview(packagingLabel)
        }
        if viewModel?.basePrice != nil {
            additionalInformationStackView.addArrangedSubview(basePriceLabel)
        }
    }
    
    private func addShadow() {
        let shadow = UIConst.recommendationItemCellShadow
        layer.applySketchShadow(sketchShadow: shadow)
    }
    
    static func nib() -> UINib? {
        return UINib(nibName: reuseIdentifier, bundle: Bundle.main)
    }
    
}
    
