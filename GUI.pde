
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
}

public class SettingsMaster {

  
  SettingsMaster() {
    
  }

}

