#!/bin/bash

if [ "$1" == "alien" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/AlienBlood.conf
elif [ "$1" == "batman" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/Batman.conf
elif [ "$1" == "dumbledore" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/Dumbledore.conf
elif [ "$1" == "duo" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/Duotone_Dark.conf
elif [ "$1" == "lavandula" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/Lavandula.conf
elif [ "$1" == "seashells" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/SeaShells.conf
elif [ "$1" == "seafoam" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/Seafoam_Pastel.conf
elif [ "$1" == "shaman" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/Shaman.conf
elif [ "$1" == "slate" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/Slate.conf
elif [ "$1" == "solar-dark" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/Solarized_Dark.conf
elif [ "$1" == "solar-light" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/Solarized_Light.conf
elif [ "$1" == "codex" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/Source_Code_X.conf
elif [ "$1" == "spacedust" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/Spacedust.conf
elif [ "$1" == "twilight" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/Twilight.conf
elif [ "$1" == "ubuntu" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/Ubuntu.conf
elif [ "$1" == "urple" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/Urple.conf
elif [ "$1" == "neon" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/WarmNeon.conf
elif [ "$1" == "tropical" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/Tropical_Neon.conf
elif [ "$1" == "tokyo" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/Tokyo_Night.conf
elif [ "$1" == "snow" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/Snow_Light.conf
elif [ "$1" == "shadow" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/shadotheme.conf
elif [ "$1" == "sakura" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/Sakura_Night.conf
elif [ "$1" == "rose" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/Rose_Pine_Dawn.conf
elif [ "$1" == "nova" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/Nova.conf
elif [ "$1" == "monokai" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/Monokai_Pro_Filter_Ristretto.conf
elif [ "$1" == "kaolin" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/Kaolin_Temple.conf
elif [ "$1" == "breeze" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/Kaolin_Breeze.conf
elif [ "$1" == "gruvbox-dark" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/Gruvbox_Material_Dark_Soft.conf
elif [ "$1" == "gruvbox-light" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/Gruvbox_Material_Light_Soft.conf
elif [ "$1" == "forest" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/Forest_Night.conf
elif [ "$1" == "everforest-light" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/Everforest_Light_Soft.conf
elif [ "$1" == "everforest-dark" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/Everforest_Dark_Hard.conf
elif [ "$1" == "city" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/citylights.conf
elif [ "$1" == "metal" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/Black_Metal.conf
elif [ "$1" == "cat" ]; then
    kitty @ set-colors --configured ~/.config/kitty/kitty-themes/themes/Catppuccin_Frappe.conf
else
    printf "\n"
    echo "Usage: kc <theme-name>"
    printf "\n"
    echo "Available themes: alien, batman, breeze, cat, city, codex, duo, dumbledore, everforest-dark,
         everforest-light, forest, gruvbox-light, gruvbox-dark, kaolin, lavandula, metal, monokai, neon,
         nova, rose, seashells, seafoam, shaman, slate, spacedust, solar-light, solar-dark, snow, shadow,
         sakura, tropical, tokyo, twilight, ubuntu, urple"
    printf "\n"

fi
