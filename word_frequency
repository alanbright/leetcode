filename='words.txt'
awk '
{
    for( i = 1; i <= NF; i++){
        color[$i]++;
    }
}
END {
    for(i in color ){
        printf( "%s %d\n", i, color[i] );
    }
}
' $filename | sort -nr -k 2
