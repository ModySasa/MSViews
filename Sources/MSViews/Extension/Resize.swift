//
//  File.swift
//  
//
//  Created by Moha on 22/05/2024.
//

import Foundation

extension CGFloat{
    public func resize()->CGFloat {
        return self * 1.125
    }
}

extension Int{
    public func resize()->CGFloat {
        return CGFloat(self) * 1.125
    }
}

extension Double{
    public func resize()->CGFloat {
        return self * 1.125
    }
}

public func fixSize(_ number: Int) ->CGFloat {
    return number.resize()
}

public func fixSize(_ number: CGFloat) ->CGFloat {
    return number.resize()
}

public func fixSize(_ number: Double) ->CGFloat {
    return number.resize()
}
