//
//  HTMLContent.swift
//  KMarketPlaceKit
//
//  Created by Marcus Hopp on 14.05.21.
//
import UIKit

public struct HTMLContent {
    static private let htmlTemplate = "<html> <head> <style type='text/css'> body { font-family: '%@'; padding: 0; margin: %f; color: %@;} .pixel { font-size: %ipx; padding: 0; margin: 0; } dt { font-family: '%@'; font-size: %ipx;} </style> </head> <body class=\"pixel\" bgcolor=\"%@\" link=\"%@\" vlink=\"%@\" alink=\"%@\">%@</body> </html>"

    public var text: String = ""
    public var font: UIFont = UIFont.systemFont(ofSize: 12)
    public var textColor: UIColor = .black
    public var backgroundColor: UIColor = .white
    public var linkTextColor: UIColor = .systemBlue
    public var margin: Double = 0.0
    public var dtFont: UIFont = UIFont.systemFont(ofSize: 12, weight: .bold)

    public var htmlString: String {
        return String(format: HTMLContent.htmlTemplate,
                      font.familyName,
                      margin,
                      textColor.hexString,
                      Int(font.pointSize),
                      dtFont.familyName,
                      Int(dtFont.pointSize),
                      backgroundColor.hexString,
                      linkTextColor.hexString,
                      linkTextColor.hexString,
                      linkTextColor.hexString,
                      text)
    }
}
