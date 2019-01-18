float translateX = 500;
float translateY = 500;
float translateZ = 0;
float rotateX = PI/2;
float rotateY = 0;
float dmx = 0;
float dmy = 0;

void applyTransformations(){
  translate(translateX, translateY, translateZ);
  rotateX(rotateX);
  rotateY(rotateY);

}

void mouseDragged() {
  dmx = mouseX - pmouseX;
  dmy = mouseY - pmouseY;
  //orbit
  if (mouseButton == LEFT) {
    rotateX -= dmy * 0.005;
    rotateY += dmx * 0.005;
  } 
 
  //pan
  //i don't like panning, it puts it off centre and I don't like it
  //You can enable that if you want
  else if (mouseButton == CENTER && 1 == 2) {
    translateX += dmx * 1;
    translateY += dmy * 1;
  } 
  
  //zoom
  else if (mouseButton == RIGHT){
    translateZ += dmy; 
  }
  
}
