//
//  HeaderCellNode.swift
//  TwitchStream
//
//  Created by Taufik Obet on 24/11/17.
//  Copyright © 2017 spacetimecorp. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class HeaderCellNode: ASDisplayNode {
    
    let avatarNode = ASNetworkImageNode()
    let displayNameNode = ASTextNode()
    let gameLabelNode = ASTextNode()

    let stream: TwitchStream
    init(stream: TwitchStream) {
        self.stream = stream
        super.init()
        
        addSubnode(avatarNode)
        avatarNode.url = stream.channel.avatar
        let imageSize = CGSize(width: 50, height: 50)
        avatarNode.style.preferredSize = imageSize
        avatarNode.imageModificationBlock = {
            image in
            return image.makeCircularImage(size: imageSize)
        }
        
        addSubnode(displayNameNode)
        displayNameNode.attributedText = NSAttributedString(string:stream.channel.displayName, attributes:[NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18, weight: .medium)])
        
        addSubnode(gameLabelNode)
        gameLabelNode.attributedText = NSAttributedString(string:stream.game, attributes:[NSAttributedStringKey.font:UIFont.systemFont(ofSize: 16, weight: .medium), NSAttributedStringKey.foregroundColor: UIColor(red:0.29, green:0.21, blue:0.48, alpha:1.0)])
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let displayNameStack = ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .start, children: [displayNameNode, gameLabelNode])
        let headerStack = ASStackLayoutSpec(direction: .horizontal, spacing: 8, justifyContent: .start, alignItems: .start, children: [avatarNode, displayNameStack])
        let headerStackInset = ASInsetLayoutSpec(insets: UIEdgeInsetsMake(8, 8, 8, 8), child: headerStack)
        
        return headerStackInset
    }
}

private extension UIImage {
    
    func makeCircularImage(size: CGSize) -> UIImage {
        // make a CGRect with the image's size
        let circleRect = CGRect(origin: .zero, size: size)
        
        // begin the image context since we're not in a drawRect:
        UIGraphicsBeginImageContextWithOptions(circleRect.size, false, 0)
        
        // create a UIBezierPath circle
        let circle = UIBezierPath(roundedRect: circleRect, cornerRadius: circleRect.size.width * 0.5)
        
        // clip to the circle
        circle.addClip()
        
        UIColor.white.set()
        circle.fill()
        
        // draw the image in the circleRect *AFTER* the context is clipped
        self.draw(in: circleRect)
        
        // get an image from the image context
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // end the image context since we're not in a drawRect:
        UIGraphicsEndImageContext()
        
        return roundedImage ?? self
    }
}
