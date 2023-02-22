//
//  Color.swift
//  Mi-sha
//
//  Created by MM on 12.12.2022.
//

import SwiftUI

extension Color {
    static var theme: ThemeColors {
        ThemeColors()
    }
}

class ThemeColors {
    let black = Color(red: 24/255, green: 23/255, blue: 22/255)
    let white = Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1))
    let green = Color(#colorLiteral(red: 0, green: 0.9810667634, blue: 0.5736914277, alpha: 1))
    let yellow = Color(#colorLiteral(red: 0.8321695924, green: 0.985483706, blue: 0.4733308554, alpha: 1))
    let orange = Color(#colorLiteral(red: 0.9559542537, green: 0.5613597035, blue: 0.4460546374, alpha: 1))
    let blue = Color(#colorLiteral(red: 0.607198894, green: 0.6928299069, blue: 0.995575726, alpha: 1))
    let purple = Color (#colorLiteral(red: 0.6922668219, green: 0.5555503368, blue: 0.8966576457, alpha: 1))
    let main = Color(#colorLiteral(red: 0.9427313209, green: 0.8394339681, blue: 0.7850262523, alpha: 1))
    let main2 = Color(#colorLiteral(red: 0.9380407929, green: 0.8396212459, blue: 0.7851215005, alpha: 1))
    let smollDoggo = Color(#colorLiteral(red: 0.8424865603, green: 0.8280478716, blue: 0.7804499269, alpha: 1))
    let mediumDoggo = Color(#colorLiteral(red: 0.7664349675, green: 0.8263677955, blue: 0.7951148152, alpha: 1))
    let bigDoggo = Color(#colorLiteral(red: 0.9380407929, green: 0.8396212459, blue: 0.7851215005, alpha: 1))
}
