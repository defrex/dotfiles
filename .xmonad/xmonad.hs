import XMonad
import XMonad.Hooks.DynamicLog

main = xmonad  =<< xmobar defaultConfig
    { focusedBorderColor = "#4A7023"
    , normalBorderColor = "#333333"
    , borderWidth = 2
    , modMask = mod4Mask }
