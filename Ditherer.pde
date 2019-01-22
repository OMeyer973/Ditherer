// small app to blur an image by exchanging pixels 2 by 2

import controlP5.*;
import com.hamoid.*;

int ditterRadius = 5;
int ditterSpeed = 100;

int UIX = 600, UIY = 80;
int sizeX = UIX, sizeY = UIY; //must be the size of the input image


//computing variables  
String diffusePath, diffuseName;
PImage diffuse;
boolean init = false;
boolean running = false;

//GUI variables
ControlP5 cp5;

//export variables

void settings() {
  
  size(sizeX, sizeY);
}

  
void setup () {
  //initialisation of variables
  background(0);
  noStroke();
  cp5 = new ControlP5(this);
  
   cp5.addButton("selectFile")
   .setLabel("select picture")
   .setPosition(10,10)
   .setSize(90,20)
   ;
   
   cp5.addButton("resetImage")
   .setLabel("reset image")
   .setPosition(120,10)
   .setSize(90,20)
   ;
  
   cp5.addButton("export")
   .setLabel("export image")
   .setPosition(230,10)
   .setSize(90,20)
   ;
    
   cp5.addSlider("ditterRadius")
     .setLabel("ditter radius")
     .setPosition(10,40)
     .setSize(500,10)
     .setRange(0,300)
     ;
     
   cp5.addSlider("ditterSpeed")
     .setLabel("ditter speed")
     .setPosition(10,60)
     .setSize(500,10)
     .setRange(0,2000)
     ;
}

void draw () {
  
  if (running) { 
    image(diffuse,0,UIY);
    for (int i=0; i<= ditterSpeed; i++) {
      exchange2Pixels(diffuse);
    }
  }
}

void exchange2Pixels(PImage diffuse) {
  int x = (int)random(0, sizeX-1);
  int y = (int)random(0, sizeY-1);
  color pixelColor = diffuse.get(x,y);
  
  int x2 = x + (int)random(-ditterRadius, ditterRadius);
  x2 = constrain(x2, 0, sizeX-1);
  int y2 = y + (int)random(-ditterRadius, ditterRadius);
  y2 = constrain(y2, 0, sizeY-1);
  color pixelColor2 = diffuse.get(x2,y2);
  
  diffuse.set(x,  y,  pixelColor2);
  diffuse.set(x2, y2, pixelColor);
}

void selectFile() {
  running = false;
  println("select a file");
  selectInput("Select an image to ditter", "diffuseSelected");
}

void diffuseSelected(File selection) {
  if (selection == null) {
    println("image import got cancelled");
  } else {
    diffusePath = selection.getAbsolutePath();
    diffuseName = selection.getName();
    resetImage();
  }
}

void resetImage() {
  diffuse = loadImage(diffusePath);
  sizeX = diffuse.width;
  sizeY = diffuse.height;
  surface.setSize(max(sizeX, UIX),sizeY+UIY);
  running = true;
 }
 
 void export() {
   diffuse.save(diffuseName + "_out-" + year() + month() + day() + hour() + minute() + second() + ".png");
   javax.swing.JOptionPane.showMessageDialog(null,"Saved file : " + diffuseName + "_out-" + year() + month() + day() + hour() + minute() + second() + ".png");
 }