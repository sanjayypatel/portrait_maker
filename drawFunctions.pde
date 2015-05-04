void generateRectsandLines() {
  
  // Pick two random points
  int x1 = int(random(img.width));
  int y1 = int(random(img.height));
  float xRange = img.width/distanceWDivisor;
  float yRange = img.height/distanceHDivisor;
  int x2 = abs(int(x1 + random(-xRange, xRange)));
  int y2 = abs(int(y1 + random(-yRange, yRange)));
  
  if (x2 < 0 ) { x2 = 0;}
  if (x2 >= img.width) { x2 = img.width - 1; }
  if (y2 < 0) {y2 = 0;}
  if (y2 >= img.height) { y2 = img.height - 1; }  
  
  float distance = sqrt(sq(x2 - x1) + sq(y2 - y1));

  int loc1 = x1 + y1*img.width;
  //println("loc1 " + loc1);
  int loc2 = x2 + y2*img.width;
  //println("loc2 " + loc2 + " img.pixels.length " + img.pixels.length);
    // Look up the RGB color in the source image
  float r1 = abs(red(img.pixels[loc1]) - colorScale1);
  float g1 = abs(green(img.pixels[loc1]) - colorScale1);
  float b1 = abs(blue(img.pixels[loc1]) - colorScale1);
  float a1 = brightness(img.pixels[loc1]);
  float r2 = abs(red(img.pixels[loc2]) - colorScale2);
  float g2 = abs(green(img.pixels[loc2]) - colorScale2);
  float b2 = abs(blue(img.pixels[loc2]) - colorScale2);
  float a2 = brightness(img.pixels[loc2]);
    
    //Set alpha values derived from brightness values
  a1 = abs(a1 - alphaScale)/rectAlphaModifier + baseAlphaRect;
  a2 = abs(a2 - alphaScale)/rectAlphaModifier + baseAlphaRect;
    
    //get average values for line color
    //and distance between points for alpa value
  float rAve = (r1 + r2) /2;
  float gAve = (g1 + g2) /2;
  float bAve = (b1 + b2) /2;
  distance = (distance / img.width) * 255;
    
    //draw rects at loc1 and loc2 and set size semi-randomly based
    //on current rectSize values
  if(rectStroked) stroke(r2, g2, b2, a2*2);
  else noStroke();
  if(rectFilled) fill(r1,g1,b1, a1);
  else noFill();
  rect(x1, y1, rectSize/random(1,8), rectSize/random(1, 8));
  if(rectStroked) stroke(r1, g1, b1, a1*2);
  else noStroke();
  if(rectFilled) fill(r2, g2, b2, a2);
  else noFill();
  rect(x2, y2, rectSize/random(1, 8), rectSize/random(1, 8));
   
  //draw line connecting loc1 and loc2 using average color 
  //stroke(rAve, gAve, bAve, abs(255 - distance)/lineAlphaModifier + baseAlphaLine);
  //draw line connecting loc1 and loc2 using loc1 color
  stroke(r1, g1, b1, abs(255 - distance)/lineAlphaModifier + baseAlphaLine);
  line(x1, y1, x2, y2);
  
}
