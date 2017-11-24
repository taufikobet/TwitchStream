//
//  StreamCell.swift
//  TwitchStream
//
//  Created by Donny Apriliano on 23/11/17.
//  Copyright © 2017 spacetimecorp. All rights reserved.
//

import Foundation
import AsyncDisplayKit

typealias Stream = TwitchStream

let aspectRatio:CGFloat = 9.0/16.0
let scaleFactor = UIScreen.main.scale

class StreamCell : ASCellNode {
    
    let titleNode = ASTextNode()
    let imageNode = ASNetworkImageNode()
    
    let customTextNode = CustomTextNode()
    let viewersLabelNode = ASTextNode()
    
    let headerNode:HeaderCellNode
    
    let stream:Stream
    init(stream:Stream) {
        self.stream = stream
        self.headerNode = HeaderCellNode(stream: stream)
        
        super.init()
        
        addSubnode(titleNode)
        titleNode.attributedText = NSAttributedString(string:stream.channel.status, attributes:[NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)])
        
        addSubnode(imageNode)
        
        imageNode.url = stream.preview.largeURL
        
        addSubnode(customTextNode)
        
        addSubnode(viewersLabelNode)
        viewersLabelNode.attributedText = NSAttributedString(string:"\(stream.viewers) viewers on \(stream.channel.displayName)", attributes:[NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        
        addSubnode(headerNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let imageRatioLayout = ASRatioLayoutSpec(ratio: aspectRatio, child: imageNode)
        let overlayLayout = ASOverlayLayoutSpec(child: imageRatioLayout, overlay: customTextNode)
        let titleNodeInset = ASInsetLayoutSpec(insets: UIEdgeInsetsMake(8, 8, 8, 8), child: titleNode)
        let viewersLabelNodeInset = ASInsetLayoutSpec(insets: UIEdgeInsetsMake(0, 8, 8, 8), child: viewersLabelNode)
        return ASStackLayoutSpec(direction: .vertical,
                                 spacing: 0,
                                 justifyContent: .start,
                                 alignItems: .start,
                                 children: [headerNode, overlayLayout, titleNodeInset, viewersLabelNodeInset])
    }
}
