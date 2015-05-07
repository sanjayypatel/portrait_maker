//Uses the GUIDO library by fjenett - https://github.com/fjenett/Guido
//supplies framework for GUI classes and interactivity
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
PImage loadedImg;

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
boolean selected = false;
PFont myFont;

//*************************************************
//--GUI ELEMENTS
Toggle run_toggle;
Toggle background_toggle;
Slider rectSize_slider; //16 - 512
Slider rectDecrement_slider; //2 - 64
Slider timeFrame_slider; //100 - 1000
Slider amountToAdd_slider; // 0 - 1000
Slider alphaScale_slider; //0 - 256

Toggle rectFilled_toggle;
Toggle rectStroked_toggle;
//baselinealphas mods
//alphascalers
//*************************************************





//*************************************************
//--USER SETTINGS

//Path to original file
String original = "./img/daxdog.jpg";

float   rectSize              = 512;
int     timeFrame             = 1000;
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
  size(displayWidth , displayHeight );
  if(frame != null) frame.setResizable(true);
  selectInput("Choose an image to process: ", "imageSelected");
  setupFont();
  
  //Create GUI Elements
  rectMode(CORNER);
  run_toggle = new Toggle( 215f, 15f, 15f, false);
  background_toggle = new Toggle( 215f, 45f, 15f, false);
  rectSize_slider = new Slider (215f, 75f, 256f, 15f);
  rectDecrement_slider = new Slider (215f, 105f, 256f, 15f);
  timeFrame_slider = new Slider (215f, 135f, 256f, 15f);
  amountToAdd_slider = new Slider (215f, 165f, 256f, 15f);
  alphaScale_slider = new Slider (215f, 195f, 256f, 15f, 1f);
  
  rectFilled_toggle = new Toggle( 712f, 15f, 15f, true);
  rectStroked_toggle = new Toggle( 712f, 45f, 15f, true);

  //display background image behind GUI
  background(0);
} //setup()

void draw() {

  if(run_toggle.on) { //If the run_toggle has been flipped, then enter the drawing phase
  
    //First, kill all GUI elements - but check if active first so that this executes only once
    if(run_toggle.isActive()){
      KillGUI();
      rectMode(CENTER);
      //set the background one last time to cover up the now-deactivated GUI
      if(background_image) {//background_image stores the background_toggle setting so that it can be used after Killing GUI
        background(img);
      }else { 
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
  }else if(selected){ //This will loop while the GUI is active and run_toggle has not been flipped
    //Inside the else if (selected) changes to the GUI will be read and user settings (global vars) will be updated
    //once run_toggle is turned on, the ability to change settings based on GUI will be disabled.
   
    //Based on user input, set the initial background to either the original image or the average color of entire image.
    if(background_toggle.on) { //this will update display while user is choosing settings.
      background(img);
      if(!background_image) background_image = true;
    }else { 
      //Set background to average color of entire img
      background( abs(averageR - colorScale1) , abs(averageG - colorScale1), abs(averageB - colorScale1)); 
      if(background_image) background_image = false;
    }
    if((rectSize_slider.value * 496) + 16 != rectSize){
      rectSize = (rectSize_slider.value * 496) + 16;
    }
    if(floor((rectDecrement_slider.value * 62) + 2) != rectSizeDecrement){
      rectSizeDecrement = floor((rectDecrement_slider.value * 62) + 2);
    }
    if(floor((timeFrame_slider.value * 900) + 100) != timeFrame){
      timeFrame = floor((timeFrame_slider.value * 900) + 100);
    }  
    if(floor(amountToAdd_slider.value * 1000) != amountToAdd){
      amountToAdd = floor(amountToAdd_slider.value * 1000);
    }      
    if(floor(alphaScale_slider.value * 256) != alphaScale){
      alphaScale = floor(alphaScale_slider.value * 256);
    }   
    if(rectFilled_toggle.on != rectFilled) {
      rectFilled = rectFilled_toggle.on;
    } 
    if(rectStroked_toggle.on != rectStroked) {
      rectStroked = rectStroked_toggle.on;
    } 
    fill(255);
    textSize(24);
    text("Run Program:", 15, 30);
    text("Background Visible:", 15, 60); 
    text("Start Size " + String.valueOf(floor(rectSize)) + " :", 15, 90);
    text("Decrement by " + String.valueOf(rectSizeDecrement) + " :", 15, 120);
    text("Time per Size " + String.valueOf(timeFrame) + " :", 15, 150);
    text("Add to Time " + String.valueOf(amountToAdd) + " :", 15, 180);
    text("Alpha Color Scale  " + String.valueOf(alphaScale) + " :", 15, 210);
    text("Rects Filled: ", 512, 30);
    text("Rects Stroked: ", 512, 60);
  }
  
} //draw()




