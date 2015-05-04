import de.bezier.guido.*;

/*************************************************
  Portrait Maker Project
  by Sanjay Y Patel
  @bupping on twitter
  sanjayypatel on github
  feedback, ideas and suggestions welcome
*************************************************/

//Initialize global variables used by drawing algorithm

//--Original image file variable
PImage img;

//*************************************************
//--Initialize utility variables
//--NOT MEANT TO BE CHANGED BY USER
int counter = 0;
float totalR = 0;
float totalG = 0;
float totalB = 0;
int numOfPixels = 0;
float averageR = 0;
float averageG = 0;
float averageB = 0;
int tempLoc = 0;
boolean running = false;
boolean background_image;
Toggle run_toggle;
Toggle background_toggle;



//*************************************************


//*************************************************
//--USER SETTINGS

//Path to original file
String original = "./img/daxdog.jpg";

int     rectSize              = 256;
int     timeFrame             = 100;
int     amountToAdd           = 20;
int     rectSizeDecrement     = 16;

//0 for light emphasis, 255 for dark emphasis
int     alphaScale            = 255;
//adjust color of loc1 and loc2 points respectively
int     colorScale1           = 0;
int     colorScale2           = 0;
//distance is divided by modifier which sets the alpha for lines
int     lineAlphaModifier     = 6;
int     baseAlphaLine         = 45;
int     rectAlphaModifier     = 3;
int     baseAlphaRect         = 64;
boolean rectFilled            = true;
boolean rectStroked           = true;

//these divide the image width/height and set limits to distance
//between the two random points
float   distanceWDivisor      = 2;
float   distanceHDivisor      = 2;
float   distanceModifier      = .5;
//*************************************************


//*************************************************
//--DEBUG VARIABLE - SET TO TRUE FOR CONSOLE MESSAGES
boolean debug = true;
//*************************************************

//INITIALIZE THE PROGRAM
void setup() {
  
  Interactive.make(this);
  //Load original image file
  loadPixels();
  img = loadImage(original);
  if(debug) println(img.pixels.length);
  numOfPixels = img.pixels.length;
  //Set size of new image to size of original
  size(img.width, img.height);

  //Create Rects by passing a center point and dimensions, rather than a corner
  rectMode(CENTER);
  
  
  //Create GUI Elements
  background_toggle = new Toggle( 15f, 15f, 15f, true);
  run_toggle = new Toggle( 30f, 15f, 15f, false);
  
  
  //Iterate over the entire img and summ all of the color channels
    for(int x= 0; x < img.width; x++) {
      for(int y = 0; y < img.height; y++) {
        tempLoc = x + y*img.width;
        totalR += red(img.pixels[tempLoc]);
        totalG += green(img.pixels[tempLoc]);
        totalB += blue(img.pixels[tempLoc]);
      }
    }
    //Calculate average RGB values for img
    averageR = totalR / numOfPixels;
    averageG = totalG / numOfPixels;
    averageB = totalB / numOfPixels;

  //display background image behind GUI
  background(img);
}

void draw() {

  if(run_toggle.on) {
    if(run_toggle.isActive()){
      KillGUI();
      if(background_image) {
        background(img);
      }else { 
        //Set background to average color of entire img
        background( abs(averageR - colorScale1) , abs(averageG - colorScale1), abs(averageB - colorScale1)); 
      }
    }
    //Increment counter to track of number of pairs of rectangles
    counter++;
    
    //if rectSize value falls below 1 then, stop drawing
    if(rectSize < 1) { 
      saveFrame("./out/output" + getTimestamp() + ".png");
      if(debug) println("done");
      exit();
    }else{//otherwise draw
      generateRectsandLines();
    }
 
    //when counter triggers trimeframe, rectSize is decremented
    //and timeframe incremented which leads to more and smaller rects  
    if(counter == timeFrame) {
      rectSize -= rectSizeDecrement;
      timeFrame += amountToAdd;
      distanceWDivisor += distanceModifier;
      distanceHDivisor += distanceModifier;
      counter = 0;
      if(debug) println(rectSize);
    }
  }else {
    //Based on user input, set the initial background to either the original image or the average color of entire image.
    if(background_toggle.on) {
      background(img);
      if(!background_image) background_image = true;
    }else { 
      //Set background to average color of entire img
      background( abs(averageR - colorScale1) , abs(averageG - colorScale1), abs(averageB - colorScale1)); 
      if(background_image) background_image = false;
    }
    
  }
  
}



