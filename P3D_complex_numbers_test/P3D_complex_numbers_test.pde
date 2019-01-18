final boolean isCylinder = false; //if false defaults to torus morphed into sphere. Otherwise, it turns into - you guessed it- a cylinder

//there are keybindings to toggle each of these, uhhh look in the input_registration tab to find out.
boolean drawLines = false;
boolean sweepingDraw = false;
boolean drawMidpoints = false;
boolean drawGrid = true;
boolean drawSphere = false;

//the number of points in each axis, (a + bi) you can have before it loops back around
int num_a = 100;
int num_b = 100;

int sweepPercent = 10; //The percent of the sphere that will be drawn at once when sweeping. Please keep this within reasonable bounds
int sweepSpeed = 1; //The speed at which it will sweep through. Experiment between 0.2 and 2-5

// point (a + bi) will be connected to point (a + bi)(c + di)
//Also keybindings are available to increment/decrement each of these
int c = 1; 
int d = 1; 



int aindex;
int bindex; 
//sP stands for spherePoints, the lookup table for the location of all the points on
//the sphere.

//mP are the midPoints of each line.
float[][][] sP;
float[][][] mP;

float abRatio;
boolean isSweepingDraw;


float time = 0;

//i don't remember why this is here
float lx1;
float ly1;
float lz1;
float lx2;
float ly2;
float lz2;
//number of points that will be represented

void setup() {
  //  size(1000, 1000, P3D);
  fullScreen(P3D);
  translateX = width/2;
  translateY = height/2;
  background(0);
  stroke(255, 255, 255);
  strokeWeight(5);

  sP = new float[500][500][3];
  mP = new float[500][500][3];
  updatesP(num_a, num_b);
  updatemP(num_a, num_b);
  colorMode(HSB, 100, 100, 100, 100);
  
//  ortho();
}

void updatesP(int num_a, int num_b) {

  float sina;
  float cosa;
  float sinb;
  float cosb;

  for (float a  = 0; a < num_a; a++) {
    sina = sin(map(a, 0, num_a, 0, TAU));
    cosa = cos(map(a, 0, num_a, 0, TAU));
    for (float b  = 0; b < num_b; b++) {
      if (isCylinder) {

        sP[int(a)][int(b)][0] = 300*sina;
        sP[int(a)][int(b)][1] = map(b, 0, num_b, -300, 300);
        sP[int(a)][int(b)][2] = 300*cosa;
        
      } else {

        sinb = sin(map(b, 0, num_b, 0, TAU));
        cosb = cos(map(b, 0, num_b, 0, TAU));

        sP[int(a)][int(b)][0] = 300*sina*cosb; //x coord
        sP[int(a)][int(b)][1] = 300*sinb;  // y coord
        sP[int(a)][int(b)][2] = 300*cosa *cosb; // z coord 
        //   println(str(sP[int(a)][int(b)][0]) + "," + sP[int(a)][int(b)][1]+
      }
    }
  }
}

void updatemP(int num_a, int num_b) {
  for (int a = 0; a < num_a; a++) {
    for (int b = 0; b < num_b; b++) {  

      aindex = (a * c - b * d) % num_a;
      if (aindex < 0) {
        aindex = num_a + aindex;
      }

      bindex = (a * d + b * c) % num_b;
      if (bindex < 0) {
        bindex = num_b + bindex;
      }

      lx1 = sP[a][b][0];
      ly1 = sP[a][b][1];
      lz1 = sP[a][b][2];

      lx2 = sP[aindex][bindex][0];
      ly2 = sP[aindex][bindex][1];
      lz2 = sP[aindex][bindex][2];

      mP[a][b][0] = (lx1 + lx2)/2;
      mP[a][b][1] = (ly1 + ly2)/2;
      mP[a][b][2] = (lz1 + lz2)/2;
    }
  }
}
void draw() {
  clear();

  pushMatrix();
  applyTransformations();

  strokeWeight(1);
  isSweepingDraw = true;
  for (int a = 0; a < num_a; a++) {
    for (int b = 0; b < num_b; b++) {
      abRatio = 100*(float(a)/float(num_a)) ;//+ 50*(float(b)/float(num_b));

      if (sweepingDraw) {
        if (0  < (abRatio+time)%100  && sweepPercent  > (abRatio+time)%100) {
          isSweepingDraw = true;
        } else {
          isSweepingDraw = false;
        }
      } 

      if (drawSphere) {
        strokeWeight(2);
        stroke(0, 0, 255); 
        point(sP[a][b][0], sP[a][b][1], sP[a][b][2]);
      }

      if (isSweepingDraw) {
        aindex = (a * c - b * d) % num_a;
        if (aindex < 0) {
          aindex = num_a + aindex;
        }

        bindex = (a * d + b * c) % num_b;
        if (bindex < 0) {
          bindex = num_b + bindex;
        }

        lx1 = sP[a][b][0];
        ly1 = sP[a][b][1];
        lz1 = sP[a][b][2];

        lx2 = sP[aindex][bindex][0];
        ly2 = sP[aindex][bindex][1];
        lz2 = sP[aindex][bindex][2];




        stroke(abRatio, 100, 100, 50);
        if (drawLines) {
          strokeWeight(1);
          line(lx1, ly1, lz1, lx2, ly2, lz2);
        }

        if (drawMidpoints) {
          strokeWeight(10);
          point(mP[a][b][0], mP[a][b][1], mP[a][b][2]);
        }

        if (drawGrid) {
          strokeWeight(2);
          line(mP[a][b][0], mP[a][b][1], mP[a][b][2], 
            mP[(a+1) % num_a][b][0], mP[(a+1) % num_a][b][1], mP[(a+1) % num_a][b][2]);

          line(mP[a][b][0], mP[a][b][1], mP[a][b][2], 
            mP[a][(b+1)%num_b][0], mP[a][(b+1)%num_b][1], mP[a][(b+1)%num_b][2]);
        }
      }

      //text("("+str(a) + ", " + str(b) + ")",lx1,ly1,lz1);
    }
  }
  popMatrix();

  text("c: " + str(c), 0, 10);
  text("d: " + str(d), 0, 20);

  time+= sweepSpeed;
}
