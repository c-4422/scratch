print_logo() {
    # C-4422 pixel art routine, not important for execution
    otterPixelArt=(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 0 0
0 1 2 1 2 2 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 2 2 1 2 1 0
1 2 2 3 1 2 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 1 3 2 2 1
1 2 3 3 3 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 3 3 3 2 1
1 2 3 3 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 3 3 2 1
1 2 2 3 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 3 2 2 1
0 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 0
0 0 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 0 0
0 0 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 0 0
0 0 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 0 0
0 1 2 2 2 4 4 4 4 4 2 2 2 2 2 2 2 2 2 2 4 4 4 4 4 2 2 2 1 0
0 1 2 2 4 4 4 4 5 4 4 2 2 2 2 2 2 2 2 4 4 4 4 5 4 4 2 2 1 0
0 1 2 2 4 4 4 4 4 4 4 2 2 2 2 2 2 2 2 4 4 4 4 4 4 4 2 2 1 0
0 1 2 3 4 4 4 4 4 4 4 2 2 2 2 2 2 2 2 4 4 4 4 4 4 4 3 2 1 0
1 3 3 3 3 4 4 4 4 4 3 2 6 6 6 6 6 6 2 3 4 4 4 4 4 3 3 3 3 1
1 3 3 3 3 3 3 3 3 3 3 6 7 7 7 7 7 7 6 3 3 3 3 3 3 3 3 3 3 1
1 3 3 3 3 3 3 3 3 3 3 7 7 7 7 7 7 7 7 3 3 3 3 3 3 3 3 3 3 1
1 3 3 3 3 3 3 3 3 3 3 3 7 7 7 7 7 7 3 3 3 3 3 3 3 3 3 3 3 1
1 3 3 3 3 3 3 3 3 3 3 3 3 7 7 7 7 3 3 3 3 3 3 3 3 3 3 3 3 1
1 3 3 3 3 3 3 3 3 3 3 3 3 3 1 1 3 3 3 3 3 3 3 3 3 3 3 3 3 1
1 3 3 3 3 3 3 3 1 3 3 3 3 3 1 1 3 3 3 3 3 1 3 3 3 3 3 3 3 1
1 3 3 3 3 3 3 3 3 1 1 1 1 1 3 3 1 1 1 1 1 3 3 3 3 3 3 3 3 1
1 8 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 8 1
0 1 8 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 8 1 0
0 1 1 8 8 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 8 8 1 1 0
0 0 0 1 1 8 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 8 1 1 0 0 0
0 0 0 0 0 1 1 1 8 3 3 3 3 3 3 3 3 3 3 3 3 8 1 1 1 0 0 0 0 0
0 0 0 0 0 0 0 0 1 1 3 3 3 3 3 3 3 3 3 3 1 1 0 0 0 0 0 0 0 0)
    count=0
    for i in "${otterPixelArt[@]}"
    do
        case $i in
            0)
                # Transparent
                echo -en "  "
                ;;
            1)
                # Dark Brown
                echo -en "\x1b[38;2;87;58;44m██\x1b[0m"
                ;;
            2)
                # Brown
                echo -en "\x1b[38;2;154;106;82m██\x1b[0m"
                ;;
            3)
                # Gray
                echo -en "\x1b[38;2;239;187;167m██\x1b[0m"
                ;;
            4)
                # Black
                echo -en "\x1b[38;2;0;0;0m██\x1b[0m"
                ;;
            5)
                # White
                echo -en "\x1b[38;2;255;255;255m██\x1b[0m"
                ;;
            6)
                # Light Pink
                echo -en "\x1b[38;2;254;124;160m██\x1b[0m"
                ;;
            7)
                # Darker Pink
                echo -en "\x1b[38;2;186;91;117m██\x1b[0m"
                ;;
            8)
                # Shading Brown
                echo -en "\x1b[38;2;154;106;82m██\x1b[0m"
                ;;

        esac
        let "count+=1"
        if (( $count % 30 == 0 ))
        then
            echo -en "\n"
        fi
    done
    # End of unimportant pixel art routine
}

print_logo