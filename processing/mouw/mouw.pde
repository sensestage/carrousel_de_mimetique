
import oscP5.*;
import netP5.*;

import peasy.*;


OscP5 oscP5;

PeasyCam cam;

String line;

PFont font;

//int NUM_PADS = 4;
MouwSensor mouw;

/* ------------------------------- */
void setup()  { 
  
  size(600, 700, P3D); 
  frameRate(60);
  
  font = loadFont("Monaco-48.vlw");
  textFont(font, 12);


  cam = new PeasyCam(this, 0,0,0, 200);
  cam.setMinimumDistance(10);
  cam.setMaximumDistance(1000);

  ambientLight(150, 150, 150, 0 , 50, 0);
  strokeWeight(1);
  colorMode(RGB, 100); 
  noFill();  

  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,12000);

  createMouw();
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
//  print("### received an osc message.");
//  print(" addrpattern: "+theOscMessage.addrPattern());
//  println(" typetag: "+theOscMessage.typetag());

  // in case of four minibees for the four pads
  if(theOscMessage.checkAddrPattern("/minibee/data")==true){
    if(theOscMessage.checkTypetag("if")) {
      /* parse theOscMessage and extract the values from the osc message arguments. */
      int minibeeID = theOscMessage.get(0).intValue();  
      float val = theOscMessage.get(1).floatValue();
//      println( "x :" + x + " y :" + y +" z :" + z );
      mouw.updateSensor( val );
      return;
    }
  }
  if(theOscMessage.checkAddrPattern("/minibee/stddev")==true){
    if(theOscMessage.checkTypetag("if")) {
      /* parse theOscMessage and extract the values from the osc message arguments. */
      int minibeeID = theOscMessage.get(0).intValue();  
      float val = theOscMessage.get(1).floatValue();
      mouw.updateVariation( val );
      return;
    }
  }
}


void createMouw() {
  mouw = new MouwSensor(this, "1", 0, 0, 0) ;
}

void draw()  {
  background(0);
  mouw.display();
} 