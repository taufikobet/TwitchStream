//
//  CustomTextNode.swift
//  TwitchStream
//
//  Created by Taufik Obet on 24/11/17.
//  Copyright © 2017 spacetimecorp. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class CustomTextNode: ASControlNode {
    
    let liveLabelNode = ASTextNode()
    let backgroundNode = ASDisplayNode()

    override init() {
        super.init()

        backgroundNode.backgroundColor = UIColor.red
        backgroundNode.cornerRadius = 4.0
        addSubnode(backgroundNode)

        addSubnode(liveLabelNode)
        liveLabelNode.attributedText = NSAttributedString(string: "LIVE", attributes: [NSAttributedStringKey.foregroundColor:UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)])
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let liveLabelInsets = ASInsetLayoutSpec(insets: UIEdgeInsetsMake(0, 4, 2, 4), child: liveLabelNode)
        let backgroundSpec = ASBackgroundLayoutSpec(child: liveLabelInsets, background: backgroundNode)
        let liveLabelStack = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .end, alignItems: .start, children: [backgroundSpec])
        let liveLabelStackInset = ASInsetLayoutSpec(insets: UIEdgeInsetsMake(8, 8, 8, 8), child: liveLabelStack)
        return liveLabelStackInset
    }
}
