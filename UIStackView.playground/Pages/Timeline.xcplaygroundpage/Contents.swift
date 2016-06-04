//: [Previous](@previous)

import UIKit
import XCPlayground

//: First we need a `hostView` to put the different elements on.
let hostView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 130))
hostView.backgroundColor = .whiteColor()
XCPlaygroundPage.currentPage.liveView = hostView

let avatarImageView = UIImageView(image: UIImage(named: "IMG_0345.jpg"))
avatarImageView.clipsToBounds = true
avatarImageView.backgroundColor = .yellowColor()
avatarImageView.contentMode = .ScaleAspectFill
avatarImageView.layer.cornerRadius = 5

let handleLabel = UILabel(frame: .zero)
handleLabel.text = "dasdom"
handleLabel.font = UIFont(name: "Avenir-Heavy", size: 13)
//handleLabel.backgroundColor = UIColor.redColor()

let dateLabel = UILabel(frame: .zero)
dateLabel.text = "06/26/2015"
dateLabel.font = UIFont(name: "Avenir-Book", size: 13)
//dateLabel.backgroundColor = UIColor.grayColor()

let textLabel = UILabel(frame: .zero)
let textWithoutLink = "I played a bit with UIStackView. Good stuff!\nExamples: "
let linkString = "https://github.com/dasdom/UIStackViewPlayground"
let tweetString = textWithoutLink + linkString
let attributedString = NSMutableAttributedString(string: tweetString, attributes: [NSFontAttributeName: UIFont(name: "Avenir-Book", size: 14)!])
attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 0.1, green: 0.1, blue: 1.0, alpha: 1.0), range: NSMakeRange(textWithoutLink.characters.count, linkString.characters.count))

textLabel.attributedText = attributedString
textLabel.numberOfLines = 0
//textLabel.backgroundColor = UIColor.yellowColor()

let metaStackView = UIStackView(arrangedSubviews: [handleLabel, dateLabel])
metaStackView.spacing = 10

let textStackView = UIStackView(arrangedSubviews: [metaStackView, textLabel])
textStackView.axis = .Vertical
textStackView.spacing = 5

let mainStackView = UIStackView(arrangedSubviews: [avatarImageView, textStackView])
mainStackView.translatesAutoresizingMaskIntoConstraints = false
mainStackView.alignment = .Top
mainStackView.spacing = 10

hostView.addSubview(mainStackView)

var constraints = [NSLayoutConstraint]()
constraints.append(avatarImageView.widthAnchor.constraintEqualToConstant(60))
constraints.append(avatarImageView.heightAnchor.constraintEqualToConstant(60))

constraints.append(mainStackView.topAnchor.constraintEqualToAnchor(hostView.topAnchor, constant: 10))
constraints.append(mainStackView.bottomAnchor.constraintEqualToAnchor(hostView.bottomAnchor, constant: -10))
constraints.append(mainStackView.leadingAnchor.constraintEqualToAnchor(hostView.leadingAnchor, constant: 10))
constraints.append(mainStackView.trailingAnchor.constraintEqualToAnchor(hostView.trailingAnchor, constant: -10))

NSLayoutConstraint.activateConstraints(constraints)


//: [Next](@next)
