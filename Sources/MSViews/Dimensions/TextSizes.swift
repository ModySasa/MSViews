//
//  File.swift
//  
//
//  Created by Corptia 02 on 06/04/2023.
//

import Foundation

public class TextSizes{
    public static let shared = TextSizes.init()
    
    public var title : CGFloat = 20
    public var titleLineSpacing : CGFloat = 29
    public var titleMonoSpacing : CGFloat = 0 / 100
    
    public var large_title : CGFloat = 24
    public var large_titleLineSpacing : CGFloat = 29
    public var large_titleMonoSpacing : CGFloat = 0 / 100
    
    public var main : CGFloat = 14
    public var mainLineSpacing : CGFloat = 20
    public var mainMonoSpacing : CGFloat = 0 / 100
    
    public var header : CGFloat = 18
    public var headerLineSpacing : CGFloat = 26
    public var headerMonoSpacing : CGFloat = 0 / 100
    
    public var placeHolder : CGFloat = 14
    public var placeHolderLineSpacing : CGFloat = 20
    public var placeHolderMonoSpacing : CGFloat = 0 / 100
    
    public var button : CGFloat = 16
    public var buttonLineSpacing : CGFloat = 16
    public var buttonMonoSpacing : CGFloat = 50 / 100
    
    public var tabBar : CGFloat = 14
    public var tabBarLineSpacing : CGFloat = 10
    public var tabBarMonoSpacing : CGFloat = 0 / 100
    
    public var price : CGFloat = 16
    public var priceLineSpacing : CGFloat = 23
    public var priceMonoSpacing : CGFloat = 0 / 100
    
    public var badge : CGFloat = 14
    public var badgeLineSpacing : CGFloat = 14
    public var badgeMonoSpacing : CGFloat = 0 / 100
    
    public var badge_small : CGFloat = 10
    public var badge_smallLineSpacing : CGFloat = 14
    public var badge_smallMonoSpacing : CGFloat = 0 / 100
    
    public func setTextSizes(
        title : CGFloat = 20,
        titleLineSpacing : CGFloat = 29,
        titleMonoSpacing : CGFloat = 0,
        
        large_title : CGFloat = 24,
        large_titleLineSpacing : CGFloat = 29,
        large_titleMonoSpacing : CGFloat = 0,
        
        main : CGFloat = 14,
        mainLineSpacing : CGFloat = 20,
        mainMonoSpacing : CGFloat = 0,
        
        header : CGFloat = 18,
        headerLineSpacing : CGFloat = 26,
        headerMonoSpacing : CGFloat = 0,
        
        placeHolder : CGFloat = 14,
        placeHolderLineSpacing : CGFloat = 20,
        placeHolderMonoSpacing : CGFloat = 0,
        
        button : CGFloat = 16,
        buttonLineSpacing : CGFloat = 16,
        buttonMonoSpacing : CGFloat = 50,
        
        tabBar : CGFloat = 14,
        tabBarLineSpacing : CGFloat = 10,
        tabBarMonoSpacing : CGFloat = 0,
        
        price : CGFloat = 16,
        priceLineSpacing : CGFloat = 23,
        priceMonoSpacing : CGFloat = 0,
        
        badge : CGFloat = 14,
        badgeLineSpacing : CGFloat = 14,
        badgeMonoSpacing : CGFloat = 0,
        
        badge_small : CGFloat = 10,
        badge_smallLineSpacing : CGFloat = 14,
        badge_smallMonoSpacing : CGFloat = 0
    ){
        self.title = title
        self.titleLineSpacing = titleLineSpacing
        self.titleMonoSpacing = titleMonoSpacing / 100

        self.large_title = large_title
        self.large_titleLineSpacing = large_titleLineSpacing
        self.large_titleMonoSpacing = large_titleMonoSpacing / 100
        
        self.main = main
        self.mainLineSpacing = mainLineSpacing
        self.mainMonoSpacing = mainMonoSpacing / 100
        
        self.header = header
        self.headerLineSpacing = headerLineSpacing
        self.headerMonoSpacing = headerMonoSpacing / 100
        
        self.placeHolder = placeHolder
        self.placeHolderLineSpacing = placeHolderLineSpacing
        self.placeHolderMonoSpacing = placeHolderMonoSpacing / 100
        
        self.button = button
        self.buttonLineSpacing = buttonLineSpacing
        self.buttonMonoSpacing = buttonMonoSpacing / 100
        
        self.price = price
        self.priceLineSpacing = priceLineSpacing
        self.priceMonoSpacing = priceMonoSpacing / 100
        
        self.badge = badge
        self.badgeLineSpacing = badgeLineSpacing
        self.badgeMonoSpacing = badgeMonoSpacing / 100
        
        self.badge_small = badge_small
        self.badge_smallLineSpacing = badge_smallLineSpacing
        self.badge_smallMonoSpacing = badge_smallMonoSpacing / 100
        
        self.tabBar = tabBar
        self.tabBarLineSpacing = tabBarLineSpacing
        self.tabBarMonoSpacing = tabBarMonoSpacing / 100

    }
    
}
