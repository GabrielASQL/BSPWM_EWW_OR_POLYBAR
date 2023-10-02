#!/usr/bin/env bash

# Set bspwm configuration for poly


set_bspwm_config() {
		bspc config border_width 0
		bspc config top_padding 5
		bspc config bottom_padding 4
		bspc config normal_border_color "#032c36"
		bspc config active_border_color "#56C79D"
		bspc config focused_border_color "#56c79d"
		bspc config presel_feedback_color "#63f29a"
		bspc config left_padding 10
		bspc config right_padding 10
		bspc config window_gap 8
}

if pidof -q bspc; then
	pkill -9 bspc > /dev/null
fi


set_term_config() {
		sed -i "$HOME"/.config/alacritty/fonts.yml \
		-e "s/family: .*/family: JetBrainsMono Nerd Font/g" \
		-e "s/size: .*/size: 8/g"
		
		sed -i "$HOME"/.config/alacritty/rice-colors.yml \
		-e "s/colors: .*/colors: *poly/"
}
# Set dunst notification daemon config
set_dunst_config() {
		sed -i "$HOME"/.config/bspwm/dunstrc \
		-e "s/transparency = .*/transparency = 0/g" \
		-e "s/frame_color = .*/frame_color = \"#032c36\"/g" \
		-e "s/separator_color = .*/separator_color = \"#e8dfd6\"/g" \
		-e "s/font = .*/font = JetBrainsMono Nerd Font Medium 9/g" \
		-e "s/foreground='.*'/foreground='#e8dfd6'/g"
		
		sed -i '/urgency_low/Q' "$HOME"/.config/bspwm/dunstrc
		cat >> "$HOME"/.config/bspwm/dunstrc <<- _EOF_
				[urgency_low]
				timeout = 3
				background = "#032c36"
				foreground = "#e8dfd6"

				[urgency_normal]
				timeout = 6
				background = "#032c36"
				foreground = "#e8dfd6"

				[urgency_critical]
				timeout = 0
				background = "#032c36"
				foreground = "#e8dfd6"
_EOF_
}

set_picom_config() {
		sed -i /home/gabriel/.config/bspwm/picom.conf \
			-e "s/normal = .*/normal =  { fade = false; shadow = true; }/g" \
			-e "s/shadow-color = .*/shadow-color = \"#000000\"/g" \
			-e "s/corner-radius = .*/corner-radius = 10/g" \
			-e "s/\".*:class_g = 'Alacritty'\"/\"100:class_g = 'Alacritty'\"/g" \
			-e "s/\".*:class_g = 'Floaterm'\"/\"96:class_g = 'Floaterm'\"/g" 

}
# Launch the bar and or eww widgets
launch_bars() {
		polybar -c ${rice_dir}/config.ini &
}



### ---------- Apply Configurations ---------- ###
set_bspwm_config
set_picom_config
set_term_config
set_dunst_config
launch_bars
