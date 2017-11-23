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
    
    let titleNode = ASTextCellNode()
    let imageNode = ASNetworkImageNode()
    
    let stream:Stream
    init(stream:Stream) {
        self.stream = stream

        super.init()
        
        addSubnode(titleNode)
        titleNode.text = stream.channel.status
        
        addSubnode(imageNode)
        
        imageNode.url = stream.preview.largeURL
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let imageRatioLayout = ASRatioLayoutSpec(ratio: aspectRatio, child: imageNode)
        return ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .start, children: [titleNode, imageRatioLayout])
    }
}
