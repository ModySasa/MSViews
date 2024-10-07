//
//  File.swift
//  
//
//  Created by Corptia 02 on 06/04/2023.
//

import Foundation

public struct TextSizes{
    public let title : CGFloat
    public let titleLineSpacing : CGFloat
    public let titleMonoSpacing : CGFloat
    
    public let large_title : CGFloat
    public let large_titleLineSpacing : CGFloat
    public let large_titleMonoSpacing : CGFloat
    
    public let main : CGFloat
    public let mainLineSpacing : CGFloat
    public let mainMonoSpacing : CGFloat
    
    public let header : CGFloat
    public let headerLineSpacing : CGFloat
    public let headerMonoSpacing : CGFloat
    
    public let placeHolder : CGFloat
    public let placeHolderLineSpacing : CGFloat
    public let placeHolderMonoSpacing : CGFloat
    
    public let button : CGFloat
    public let buttonLineSpacing : CGFloat
    public let buttonMonoSpacing : CGFloat
    
    public let tabBar : CGFloat
    public let tabBarLineSpacing : CGFloat
    public let tabBarMonoSpacing : CGFloat
    
    public let price : CGFloat
    public let priceLineSpacing : CGFloat
    public let priceMonoSpacing : CGFloat
    
    public let badge : CGFloat
    public let badgeLineSpacing : CGFloat
    public let badgeMonoSpacing : CGFloat
    
    public let badge_small : CGFloat
    public let badge_smallLineSpacing : CGFloat
    public let badge_smallMonoSpacing : CGFloat
    
    public init(
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
