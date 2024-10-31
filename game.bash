#!/bin/bash

# تنظیمات اولیه
grid_size=10
player_x=0
player_y=0
treasure_x=$((RANDOM % grid_size))
treasure_y=$((RANDOM % grid_size))
difficulty=1

# تابع رنگی کردن متن
yellow_text() {
    echo -e "\e[33m$1\e[0m"
}

# تابع نمایش وضعیت فعلی
display_grid() {
    clear
    for ((i = 0; i < grid_size; i++)); do
        for ((j = 0; j < grid_size; j++)); do
            if [[ $i -eq $player_x && $j -eq $player_y ]]; then
                echo -n "$(yellow_text '⬜') "
            elif [[ $i -eq $treasure_x && $j -eq $treasure_y ]]; then
                echo -n "T "
            else
                echo -n ". "
            fi
        done
    done
    echo
    yellow_text "Difficulty Level: $difficulty"
}

# حلقه بازی
while true; do
    display_grid
    
    # گرفتن ورودی حرکت از بازیکن
    read -p "Move (w/a/s/d): " move
    case $move in
        w) ((player_x--));;
        a) ((player_y--));;
        s) ((player_x++));;
        d) ((player_y++));;
    esac

    # بررسی وضعیت بازی
    if [[ $player_x -eq $treasure_x && $player_y -eq $treasure_y ]]; then
        yellow_text "Congratulations! You've found the treasure!"
        read -p "Do you want to play another round? (y/n): " answer
        if [[ $answer == "y" ]]; then
            grid_size=$((grid_size + difficulty))
            player_x=0
            player_y=0
            treasure_x=$((RANDOM % grid_size))
            treasure_y=$((RANDOM % grid_size))
            ((difficulty++))
        else
            break
        fi
    fi
done
