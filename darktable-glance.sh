#!/bin/bash
set -eu -o pipefail
hostdir="$HOME/tmp/serv-dt"

mkdir -p "$hostdir"

cat > "$hostdir/index.html" <<EOF
<html>

<head>
<script language="JavaScript"><!--
function refreshIt() {
   if (!document.images) return;
   document.images['myCam'].src = 'dt.jpg?' + Math.random();
   setTimeout('refreshIt()',250); // refresh every 5 secs
}
//--></script>
</head>

<body onLoad=" setTimeout('refreshIt()',1000)" style='background: #666666;'>


<img src="dt.jpg" id="myCam" name="myCam" style="position:absolute; top:0px;left:0;width:100%;">
<br/>
<br/>
<br/>

</body>

</html>
EOF

( cd "$hostdir" && python -m SimpleHTTPServer 8989 ) & 

convert -size 800x800 xc:black "$hostdir/blank.jpg"
cp "$hostdir/blank.jpg" "$hostdir/dt.jpg"

while true; do
  win=$(xdotool search -name 'darktable - darkroom preview' || true)
  if [[ $win -gt 1 ]]; then
    echo 'importing'
    import -quality 98 -silent -window "$win" "$hostdir/dttmp.jpg" -resize 50%
    mv "$hostdir/dttmp.jpg" "$hostdir/dt.jpg"
  else
    echo "no win"
    cp "$hostdir/blank.jpg" "$hostdir/dt.jpg"
  fi
  sleep 0.5
done

wait
