import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" ""
                        }
        , focusedBorderColor = "#4A7023"
        , normalBorderColor = "#333333"
        , borderWidth = 2
        , terminal = "terminator"
        , modMask = mod4Mask
        } `additionalKeys`
        [ ((controlMask, xK_Print), spawn "sleep 0.2; cd ~/screenshots && scrot -s")
        , ((0, xK_Print), spawn "cd ~/screenshots && scrot")
        ]
