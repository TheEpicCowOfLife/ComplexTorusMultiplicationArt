
void keyPressed() {

  if (key == 'a') {
    c ++;
    updatemP(num_a, num_b);
  }
  if (key == 's') {
    c --;    
    updatemP(num_a, num_b);
  }
  if (key == 'z') {
    d ++;
    updatemP(num_a, num_b);
  }
  if (key == 'x') {
    d --;
    updatemP(num_a, num_b);
  } 
  if (key == 'q'){
    drawLines = !drawLines;
  }
  if (key == 'w'){
    drawMidpoints = !drawMidpoints;
  }
  if (key == 'e'){
    sweepingDraw = !sweepingDraw;
  }
  if (key == 'r'){
    drawGrid = !drawGrid;
  }
  if (key == 't'){
    drawSphere = !drawSphere;
  }
}
