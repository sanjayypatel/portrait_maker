PImage img;

int counter = 0;
float totalR = 0;
float totalG = 0;
float totalB = 0;
int tempLoc = 0;

int     pointillize           = 256;
int     timeFrame             = 1000;
int     amountToAdd           = 50;
int     pointillizeDecrement  = 16;
boolean backgroundImage       = false;

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

//every timeframe xmodifier shifts drawing horizontally
int     xModifier             = 50;
int     xModIncrement         = 100;

//these divide the image width/height and set limits to distance
//between the two random points
float   distanceWDivisor      = 2;
float   distanceHDivisor      = 2;
float   distanceModifier      = .5;

boolean debug = true;


void setup() {
  loadPixels();
  img = loadImage("groupy.jpg");
 // println(img.pixels.length);
  
  size(img.width, img.height);
  //background(0);
  smooth();
  rectMode(CENTER);
  for(int x= 0; x < img.width; x++) {
    for(int y = 0; y < img.height; y++) {
      tempLoc = x + y*img.width;
      totalR += red(img.pixels[tempLoc]);
      totalG += green(img.pixels[tempLoc]);
      totalB += blue(img.pixels[tempLoc]);
    }
  }
  totalR /= img.width * img.height;
  totalG /= img.width * img.height;
  totalB /= img.width * img.height;
  if(backgroundImage) background(img);
  else background( abs(totalR - colorScale1) , abs(totalG - colorScale1), abs(totalB - colorScale1)); 
}

void draw() {

  //increment counter to track steps
  counter++;

  //if pointillize value falls below 2 then, stop drawing
  if(pointillize < 1) { 
    saveFrame("output.png");
    if(debug) println("done");
    exit();
  }else{//otherwise draw
    generateRectsandLines();
  }

  //when counter triggers trimeframe, pointillize is decremented
  //and timeframe incremented which leads to more and smaller rects  
  if(counter == timeFrame) {
    pointillize -= pointillizeDecrement;
    timeFrame += amountToAdd;
    xModifier += xModIncrement;
    distanceWDivisor += distanceModifier;
    distanceHDivisor += distanceModifier;
    counter = 0;
    if(debug) println(pointillize);
    
  }
  

}

void keyPressed() {
 switch(key){
   case 's':
   saveFrame("ouput-##########.png");
   break;  
   case 'p':
   noLoop();
   break;
   case 'o':
   loop();
   break;
 }
}


