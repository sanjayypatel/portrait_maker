
void keyPressed() {
 switch(key){
   case 's'://save current frame
   saveFrame("./out/ouput" + getTimestamp() + ".png");
   break;  
   case 'p'://pause the program
   noLoop(); 
   break;
   case 'o'://resume the program
   loop();
   break;
 }
}

void imageSelected(File selection) {
  if(selection == null){
      println ("Error: no file selected"); 
      exit();
  } else {
    original = selection.getAbsolutePath();
    println("selected file");
    loadedImg = loadImage(original);
    imageStretch();
    if(debug) println(img.pixels.length);
    numOfPixels = img.pixels.length;
    //Set size of new image to size of original
//    frame.setSize(img.width, img.height);
    findAverageColor();
    selected = true;
  }
}

void setupFont(){
  myFont = createFont("Urba.ttf", 24);
  textFont(myFont);
//  textAlign(LEFT, TOP);
}

void findAverageColor(){
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
}

void imageStretch() {
  img = loadedImg;
  img.resize(displayWidth, displayHeight);
}
void imageCropWidth() {
 img.resize(0, displayHeight);
// img = img.copy(loadedImg, 0, 0, 
}


//Creates a Timestamp as a string to prevent output files from overwriting each other
String getTimestamp(){
  String timestamp = "_" + String.valueOf(month()) + "_";
  timestamp += String.valueOf(day()) + "_";
  timestamp += String.valueOf(year()) + "-";
  timestamp += String.valueOf(hour()) + "_";
  timestamp += String.valueOf(minute()) + "_";
  timestamp += String.valueOf(second());
   return timestamp;
}

//Send a deactivate message to each element in the GUI
//Called only once, when run_toggler is flipped on
void KillGUI() {
  Interactive.setActive( run_toggle, false ); 
  Interactive.setActive( background_toggle, false );
  Interactive.setActive( rectSize_slider, false );
  Interactive.setActive( rectDecrement_slider, false);
}

