//
//  AccountViewModel.swift
//  KMarketPlaceKit
//
//  Created by Bulgantamir Jugder on 22.03.21.
//

import Foundation
import Combine

enum AccountSectionType: CaseIterable {
    case user
    case info
    case logout
    case streakLP // section for displaying the streak and loyalty points inside the account tab
}

enum AccountItemType {
    case profile
    case order
    case refund
    case data
    case kCard
    case request
    case privacySettings
    case legal
    case version
    case logout
    case swiftUIView // item type for the swiftUIView
}

struct AccountSection {
    let section: AccountSectionType
    let items: [AccountItemType]
}

class AccountViewModel {

    private var account: Account?
    private var subscribers = Set<AnyCancellable>()
    private var sections: [AccountSection] = []
    @Published private (set) var isUserLoggedInToBFF = false

    var onAccountsError: (() -> Void)?
    var onBFFLoginError: (() -> Void)?

    var logoutViewModel: LogoutViewModel?

    init(logoutViewModel: LogoutViewModel) {
        self.logoutViewModel = logoutViewModel

        isUserLoggedInToBFF ? generateSectionsAndfetchCart() : loginToBFF()
    }

    // When user is not logged in ...
    // generate sections and fetch cart
    func generateSectionsAndfetchCart() {
        account = nil
        isUserLoggedInToBFF = false
        generateSections()
    }

    var numberOfSections: Int {
        return sections.count
    }

    func numberOfItemsInSection(_ index: Int) -> Int {
        guard let section = sections.safeRef(index) else { return 0 }
        return section.items.count
    }

    func sectionType(_ sectionIndex: Int) -> AccountSectionType? {
        return sections.safeRef(sectionIndex)?.section
    }

    func itemType(_ indexPath: IndexPath) -> AccountItemType? {
        guard let item = sections.safeRef(indexPath.section)?.items.safeRef(indexPath.item) else { return nil }
        return item
    }

    func itemViewModel(_ type: AccountItemType) -> AccountItemViewModel? {
        switch type {
        case .order: return AccountItemViewModel(title: Strings.mpAccountOrder.localized,
                                                 imageName: "account_order")
        case .profile, .data: return AccountItemViewModel(title: Strings.mpAccountData.localized,
                                                          imageName: "account_data")
        case .refund: return AccountItemViewModel(title: Strings.mpAccountRefund.localized,
                                                  imageName: "account_refund")
        case .request: return AccountItemViewModel(title: Strings.mpAccountRequest.localized,
                                                   imageName: "account_request")
        case .kCard: return AccountItemViewModel(title: Strings.mpAccountKcard.localized,
                                                imageName: "account_kcard")
        case .privacySettings: return AccountItemViewModel(title: Strings.mpAccountPrivacySettings.localized,
                                                                   imageName: "account_privacy",
                                                                   isSeparatorViewBottomHidden: !isUserLoggedInToBFF)
        case .legal: return AccountItemViewModel(title: Strings.mpAccountLegal.localized,
                                                 imageName: nil,
                                                 backgroundColor: KauflandColors.almostWhite,
                                                 isSeparatorViewBottomHidden: false)
        default: return nil
        }
    }

    func getAccountDetails() {
        AccountService().accounts()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] resultCompletion in
                switch resultCompletion {
                case .failure(let error):
                    self?.onAccountsError?()
                    print("Error in fetching accounts: \(error.localizedDescription)")
                case .finished:
                    print("Fetching accounts finished")
                }
            } receiveValue: {[weak self] account in
                self?.account = account
            }.store(in: &subscribers)
    }

    func loginToBFF() {
        generateSections()
        isUserLoggedInToBFF = true
    }

    func logout() {
        isUserLoggedInToBFF = false
        account = nil
        LastSeenRecoHandler.shared.removeAllEntries()
    }

    func generateSections() {
        sections = []

        switch (isUserLoggedInToBFF, account?.refund.amount ?? 0 > 0, false) {
            // not relevant for us, so removed
//        case (true, true, true):
//            sections.append(AccountSection(section: .user, items: [.profile, .order, .data, .refund, .request, .kCard, .privacySettings]))
//            sections.append(AccountSection(section: .logout, items: [.logout]))
//        case (true, false, true):
//            sections.append(AccountSection(section: .user, items: [.profile, .order, .data, .request, .kCard, .privacySettings]))
//            sections.append(AccountSection(section: .logout, items: [.logout]))
//        case (false, _, true):
//            sections.append(AccountSection(section: .user, items: [.profile, .order, .data, .request, .kCard, .privacySettings]))
        default:
            // place view at the correct position
            sections.append(AccountSection(section: .user, items: [.profile]))
            sections.append(AccountSection(section: .streakLP, items: [.swiftUIView]))
            sections.append(AccountSection(section: .info, items: [.order, .data, .request, .kCard ]))
        }
        sections.append(AccountSection(section: .info, items: [.legal, .version]))
    }
}

// MARK: ViewModel
extension AccountViewModel {
    var profileViewModel: UserProfileViewModel {
        UserProfileViewModel(givenName: isUserLoggedInToBFF ? "Hallo" : nil,
                             familyName: isUserLoggedInToBFF ? "Welt" : nil,
                             isUserLoggedIn: isUserLoggedInToBFF)
    }
}
