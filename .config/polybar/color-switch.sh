#!/usr/bin/env bash

SDIR="$HOME/.config"

# Launch Rofi
MENU="$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p '' \
-theme $SDIR/rofi/styles.rasi \
<<< "♥ amber|♥ blue|♥ blue-gray|♥ brown|♥ cyan|♥ deep-orange|\
♥ deep-purple|♥ green|♥ gray|♥ indigo|♥ blue-light|♥ green-light|\
♥ lime|♥ orange|♥ pink|♥ purple|♥ red|♥ teal|♥ yellow|♥ amber-dark|\
♥ blue-dark|♥ blue-gray-dark|♥ brown-dark|♥ cyan-dark|♥ deep-orange-dark|\
♥ deep-purple-dark|♥ green-dark|♥ gray-dark|♥ indigo-dark|♥ blue-light-dark|\
♥ green-light-dark|♥ lime-dark|♥ orange-dark|♥ pink-dark|♥ purple-dark|♥ red-dark|♥ teal-dark|♥ yellow-dark|")"
            case "$MENU" in
				## Light Colors
				*amber) "$SDIR"/polybar/colors-light.sh --amber ;;
				*blue) "$SDIR"/polybar/colors-light.sh --blue ;;
				*blue-gray) "$SDIR"/polybar/colors-light.sh --blue-gray ;;
				*brown) "$SDIR"/polybar/colors-light.sh --brown ;;
				*cyan) "$SDIR"/polybar/colors-light.sh --cyan ;;
				*deep-orange) "$SDIR"/polybar/colors-light.sh --deep-orange ;;
				*deep-purple) "$SDIR"/polybar/colors-light.sh --deep-purple ;;
				*green) "$SDIR"/polybar/colors-light.sh --green ;;
				*gray) "$SDIR"/polybar/colors-light.sh --gray ;;
				*indigo) "$SDIR"/polybar/colors-light.sh --indigo ;;
				*blue-light) "$SDIR"/polybar/colors-light.sh --light-blue ;;
				*green-light) "$SDIR"/polybar/colors-light.sh --light-green ;;
				*lime) "$SDIR"/polybar/colors-light.sh --lime ;;
				*orange) "$SDIR"/polybar/colors-light.sh --orange ;;
				*pink) "$SDIR"/polybar/colors-light.sh --pink ;;
				*purple) "$SDIR"/polybar/colors-light.sh --purple ;;
				*red) "$SDIR"/polybar/colors-light.sh --red ;;
				*teal) "$SDIR"/polybar/colors-light.sh --teal ;;
				*yellow) "$SDIR"/polybar/colors-light.sh --yellow ;;
				## Dark Colors
				*amber-dark) "$SDIR"/polybar/colors-dark.sh --amber ;;
				*blue-dark) "$SDIR"/polybar/colors-dark.sh --blue ;;
				*blue-gray-dark) "$SDIR"/polybar/colors-dark.sh --blue-gray ;;
				*brown-dark) "$SDIR"/polybar/colors-dark.sh --brown ;;
				*cyan-dark) "$SDIR"/polybar/colors-dark.sh --cyan ;;
				*deep-orange-dark) "$SDIR"/polybar/colors-dark.sh --deep-orange ;;
				*deep-purple-dark) "$SDIR"/polybar/colors-dark.sh --deep-purple ;;
				*green-dark) "$SDIR"/polybar/colors-dark.sh --green ;;
				*gray-dark) "$SDIR"/polybar/colors-dark.sh --gray ;;
				*indigo-dark) "$SDIR"/polybar/colors-dark.sh --indigo ;;
				*blue-light-dark) "$SDIR"/polybar/colors-dark.sh --light-blue ;;
				*green-light-dark) "$SDIR"/polybar/colors-dark.sh --light-green ;;
				*lime-dark) "$SDIR"/polybar/colors-dark.sh --lime ;;
				*orange-dark) "$SDIR"/polybar/colors-dark.sh --orange ;;
				*pink-dark) "$SDIR"/polybar/colors-dark.sh --pink ;;
				*purple-dark) "$SDIR"/polybar/colors-dark.sh --purple ;;
				*red-dark) "$SDIR"/polybar/colors-dark.sh --red ;;
				*teal-dark) "$SDIR"/polybar/colors-dark.sh --teal ;;
				*yellow-dark) "$SDIR"/polybar/colors-dark.sh --yellow				
            esac
