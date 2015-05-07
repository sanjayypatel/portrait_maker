Portrait Maker Project
by Sanjay Y Patel
@sanjayypatel on twitter
sanjayypatel on github
feedback, ideas, suggestions welcome!

This is a project built in Processing (processing.org) using Java.  The main
goal is to take a picture file as input, and rebuild it using rects and lines
that derive their color and alpha settings from pixels in the original.

Basically, a copy of the original is generated using imperfect, sometimes-modified
pairs of rectangles. Each pair of rectangles is joined by a line segment attaching
their center points.  

By changing the "settings" - Global variables at the head of the main file -
a user is able to modify the runtime, general size, colorshift, and other settings
of the generated image.  

TODO LIST:

* clean up old code and comments - this was a rough idea iterated on quickly and
sloppily.
* create user interface - expose settings when first run so that it's easier for
a user to adjust settings before running the process
* isolate and modularize the various alternative generating methods - this is
just one of a set of algorithms that could be used. pulling from other/older
versions and creating the option to utilize those features.
* BUG -  Sometimes, application crashes on image load due to size mismatch between image and application.


NOTES:
This sketch requires the GUIDO library by fjenett for
https://github.com/fjenett/Guido
