import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
 
main = do 
	xmproc <- spawnPipe "/usr/bin/xmobar /home/james/.xmobarrc"
	xmonad $ defaultConfig
        	{ modMask = mod4Mask,
          	  terminal = "konsole",
		  normalBorderColor = "#1A1A1A", 
		  focusedBorderColor = "#008000", 
         	  manageHook = manageDocks <+> manageHook defaultConfig,
         	  layoutHook = avoidStruts  $  layoutHook defaultConfig,
		  startupHook = setWMName "LG3D",
       		  logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        	} `additionalKeys`
        	[ ((mod4Mask .|. shiftMask, xK_s), spawn "xscreensaver-command -lock")
        	, ((mod4Mask .|. shiftMask, xK_g), spawn "google-chrome")
        	, ((mod4Mask .|. shiftMask, xK_f), spawn "dolphin")
        	]
