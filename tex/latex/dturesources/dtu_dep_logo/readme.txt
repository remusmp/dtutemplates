 
To convert the eps files from portalen to pdf use
this bash one-liner: 
for i in *.eps; do convert $i "${i%.*}.pdf"; done

