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

String getTimestamp(){
  String timestamp = "_" + String.valueOf(month()) + "_";
  timestamp += String.valueOf(day()) + "_";
  timestamp += String.valueOf(year()) + "-";
  timestamp += String.valueOf(hour()) + "_";
  timestamp += String.valueOf(minute()) + "_";
  timestamp += String.valueOf(second());
   return timestamp;
}

void KillGUI() {
  Interactive.setActive( run_toggle, false ); 
  Interactive.setActive( background_toggle, false );
}
