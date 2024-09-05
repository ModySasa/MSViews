//
//  File.swift
//  
//
//  Created by Corptia 02 on 04/05/2023.
//

import Foundation
import SwiftUI

func getAnyView<myView:View>(_ v:@escaping()-> myView) -> AnyView{
    return AnyView(v())
}
