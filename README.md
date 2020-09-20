# darktable-glance
Use tablet as second monitor for darktable


## RATIONALE

I use a dell laptop running Ubuntu as my main darktable system.  The color
reproduction is good, but not great.  I recently made the mistake of developing
a bunch of photos in darktable, then noticing that they all looked
oversaturated on an iPad.  And my understanding is that Apple's color
reproduction is very good, plus most of my clients will be viewing the photos
I produce on Apple products, so I'd like to make sure it looks good there.

I tried a few different solutions, including trying to get linux to believe
there's a second monitor attached, and trying to use some esoteric vnc settings
so that the iPad shows the fake second monitor, but I could never get it working reliably.

This solution works reliably.

## How it works

Set up a script that takes a screenshot of the darktable image preview window every second, and saves it to a file.

Then use python simple server, and a html file that refreshes every second, to display it on the iPad.

There's about 1-2 seconds delay, so this wouldn't work if your main system is
totally off, but it works well for double-checking that the levels you're
picking are good.

## PRECAUTIONS

I had to make sure that the Preview Display Profile was set to "Adobe RGB".
Otherwise the colors on the iPad didn't match.  I don't really grok color
profiles though, so your mileage may vary.  I'd recommend taking a photo,
exporting it, pulling it up on the iPad, and making sure that the colors of the
exported photo matches the preview window.

## How to use

1. Run darktable-glance.sh script
2. In Darktable, click on preview second window in bottom-left of window.  
3. Make sure tablet is connected to same network as computer
4. Check IP of computer (likely beginning with 192.168, you can see it with `ifconfig`)
5. On tablet, open web browser, and navigate to http://<Computer IP>:8989/

