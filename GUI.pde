//Classes are modified versions of the GUIDO library examples

public class Toggle {
    float x, y, width, height;
    public boolean on;
    boolean activated = true;  
    Toggle ( float xPos, float yPos, float w, boolean defaultValue) {
        x = xPos; 
        y = yPos; 
        width = w; 
        height = w;
        on = defaultValue;
        Interactive.add( this ); // register it with the manager
    }
// called by manager
    void mousePressed () {
        on = !on;
    }
    void draw () {
        if ( on ) fill( 200 );
        else fill( 100 );  
        rect(x, y, width, height);
    }
    boolean isActive () {
        return activated;
    }
    void setActive ( boolean setTo ) {
        activated = setTo;
    }
} //Toggle class

public class Slider
{
    float x, y, width, height;
    float valueX = 0, value;
    boolean activated = true;
    
    Slider ( float xx, float yy, float ww, float hh ) {
        x = xx; 
        y = yy; 
        width = ww; 
        height = hh;
        valueX = x + ww/2;
        value = map( valueX, x, x+width-height, 0, 1 );
        // register it
        Interactive.add( this );
    }
    Slider ( float xx, float yy, float ww, float hh, float defaultValue ) {
        x = xx; 
        y = yy; 
        width = ww; 
        height = hh;
        if(0 <= defaultValue && defaultValue <= 1)
          valueX = x + (defaultValue * width) - height;
        else
          valueX = x + ww/2;
        value = map( valueX, x, x+width-height, 0, 1 );
        // register it
        Interactive.add( this );
    }
    
    // called from manager
    void mouseDragged ( float mx, float my ) {
        valueX = mx - height/2;
        if ( valueX < x ) valueX = x;
        if ( valueX > x+width-height ) valueX = x+width-height;
        value = map( valueX, x, x+width-height, 0, 1 );
    }
    void draw () {
        noStroke();
        fill( 100 );
        rect(x, y, width, height);     
        fill( 120 );
        rect( valueX, y, height, height );
    }
        boolean isActive () {
        return activated;
    }
    void setActive ( boolean setTo ) {
        activated = setTo;
    }
} //Toggle class
