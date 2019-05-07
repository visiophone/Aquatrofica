import processing.opengl.*;
import plethora.core.*;
import toxi.geom.*;

import codeanticode.syphon.*;
SyphonServer server;

ArrayList <Ple_Agent> boids;

//DESENHAR CIRCULO
Spline3D spG; // LINHA TOTAL
Spline3D sp1;// Linha FILTRO 1
Spline3D sp2;// Linha FILTRO 2
Spline3D sp3;// Linha FILTRO 3

//int radius=500; // radius for the circle
float angle=TWO_PI/30;
int radius=500;

float DIMX = 1900;
float DIMY = 1200;
float DIMZ = 0;

int nrBoids = 250;
int type=0; //Tipo de Boids 0 materia organica //  Nutrientes Inorganicos // Nutrientes Inorganicos 
int id=0; // boid counter

boolean fil0=false; // Filter 1, 2 and 3
boolean fil1=false;
boolean fil2=false;

PFont myFont;

void setup() {

  size(1920, 1200, P3D);
  smooth();
  startSerie(); // Serie Port. Receiving msg from Arduino
  
  // Create syhpon server to send frames out.
  server = new SyphonServer(this, "Processing Syphon");

  startSound();

  //initialize the arrayList
  boids = new ArrayList <Ple_Agent>();

  //build the spline from values
  spG = new Spline3D();
  sp1 = new Spline3D();
  sp2 = new Spline3D();
  sp3 = new Spline3D();
 
  // Starting Splines. Boids follow this lines
  for (int i = 0; i < 35; i ++) {
   Vec3D v = new Vec3D((radius)*sin(angle*i),(radius)*cos(angle*i),0);
    spG.add(v);   
  }
   // Ofset para corrigir os angulos 
   float offSet=35;
       for (int i = 0; i < 28; i ++) {
   Vec3D v = new Vec3D((radius)*sin((angle*i)+radians(0+offSet)),(radius)*cos((angle*i)+radians(0+offSet)),0);
   sp1.add(v);   
  } 
   for (int i = 0; i < 28; i ++) {
   Vec3D v = new Vec3D((radius)*sin((angle*i)+radians(90+offSet)),(radius)*cos((angle*i)+radians(90+offSet)),0);
   sp2.add(v);   
  }  
   for (int i = 0; i < 28; i ++) {
   Vec3D v = new Vec3D((radius)*sin((angle*i)+radians(180+offSet)),(radius)*cos((angle*i)+radians(180+offSet)),0);
   sp3.add(v);   
  }
 
// Start Particles
  for (int i = 0; i < nrBoids; i++) {
    Vec3D v = new Vec3D (0, 0, 200); //set the initial location as 0,0,0
    Ple_Agent pa = new Ple_Agent(this, v); //create the plethora agents!  
    //generate a random initial velocity
    Vec3D initialVelocity = new Vec3D (random(-1, 1), random(-1, 1), random(-1, 1));  
    pa.setVelocity(initialVelocity); //initial velocity   
    pa.initTail(5); //initialize the tail   
    boids.add(pa); //add the agents to the list
  }

 myFont = loadFont("IBMPlexSans-48.vlw");
 textFont(myFont);
}

void draw() {
background(0);
sound();
serie();
translate(width/2,height/2);

strokeWeight(1);
stroke(255);

  // Main Cricle / Path
  for (int i = 1; i < spG.pointList.size(); i++) {
    Vec3D v1 = spG.pointList.get(i);
    Vec3D v2 = spG.pointList.get(i-1);
    stroke(255);
  // line(v1.x, v1.y, v1.z, v2.x, v2.y, v2.z);
  }
  
  // FILTRO 1
    for (int i = 1; i < sp1.pointList.size(); i++) {
    Vec3D v1 = sp1.pointList.get(i);
    Vec3D v2 = sp1.pointList.get(i-1);
    stroke(255,30);
    strokeWeight(4);
      if(fil0){fill(0,0); stroke(255);strokeWeight(8);}
     else {fill(0,0); stroke(255);strokeWeight(3);}
    if(i==sp1.pointList.size()-1)  ellipse(v1.x, v1.y,170,170);
  }
  
    // FILTRO 2
    for (int i = 1; i < sp2.pointList.size(); i++) {
    Vec3D v1 = sp2.pointList.get(i);
    Vec3D v2 = sp2.pointList.get(i-1);
    stroke(255,30);
    strokeWeight(4);  
     if(fil1){fill(0,0); stroke(255);strokeWeight(8);}
     else {fill(0,0); stroke(255);strokeWeight(3);}
     
    if(i==sp2.pointList.size()-1)  ellipse(v1.x, v1.y,170,170);
   
  }
    // FILTRO 3
    for (int i = 1; i < sp3.pointList.size(); i++) {
    Vec3D v1 = sp3.pointList.get(i);
    Vec3D v2 = sp3.pointList.get(i-1);
   stroke(255,30);
    strokeWeight(4); 
       if(fil2){fill(0,0); stroke(255);strokeWeight(8);}
     else {fill(0,0); stroke(255);strokeWeight(3);}
    if(i==sp3.pointList.size()-1)  ellipse(v1.x, v1.y,170,170);   
  }
 
  strokeWeight(1);

  //run all agents
  for (Ple_Agent pa : boids) {
   
id++;
if(id<50) type=0;
if(id>=50 && id<100)type=1;
if(id>=100 && id<150)type=2;
if(id>=150) type=3;

    Vec3D fLoc = pa.futureLoc(20); //calculate future location  
   
  // float m= -5;
  float m= map(mouseX,0,width,-10,-25);
  //calculate closest normal to spline 
  Vec3D cns ;
  cns = pa.closestNormalandDirectionToSpline(sp1, fLoc,m);
  
  if(type==0) {
    if(fil0==false) {
      cns = pa.closestNormalandDirectionToSpline(spG, fLoc,m);
      pa.separationCall(boids,map(id,0,nrBoids,100,30),2);
    }
    else {
    cns = pa.closestNormalandDirectionToSpline(sp1, fLoc,m);
    pa.separationCall(boids,map(id,0,nrBoids,40,10),2);  
}
  }
  
   if(type==1) {
    if(fil1==false) {
       pa.separationCall(boids,map(id,0,nrBoids,80,30),2);
      cns = pa.closestNormalandDirectionToSpline(spG, fLoc,m);}
    else {
      cns = pa.closestNormalandDirectionToSpline(sp2, fLoc,m);}
      pa.separationCall(boids,map(id,0,nrBoids,40,10),2); 
  }
  
    if(type==2) {
    if(fil2==false) {
      cns = pa.closestNormalandDirectionToSpline(spG, fLoc,m);
       pa.separationCall(boids,map(id,0,nrBoids,80,50),2);
    }
    else {
    cns = pa.closestNormalandDirectionToSpline(sp3, fLoc,m); 
  pa.separationCall(boids,map(id,0,nrBoids,40,10),2);
}
  }
 
    if(type==3) { 
    cns = pa.closestNormalandDirectionToSpline(spG, fLoc,m);
pa.separationCall(boids,map(id,0,nrBoids,80,50),2);  
}
  
    stroke(255, 0, 0);
    // pa.vLine(cns, fLoc); // LOCALIZAÇAO linha direcçao  
    pa.seek(cns, 2); //follow point obtained from spline   
    pa.bounceSpace(DIMX/2, DIMY/2, DIMY/2); //define the boundries of the space as bounce  

    pa.setMaxspeed(1); //set the max speed of movement:
    //pa.setMaxforce(0.05);
    pa.update(); //update agents location based on past calculations
    
    float sz=map(id,0,nrBoids,25,5);   
    strokeWeight(sz); //Display the location of the agent with a point
           
    if(type==0) stroke(0,232,255);
    if(type==1) stroke(255,0,80);
    if(type==2) stroke(150,255,0);
    if(type==3) stroke(255,255,255);

    pa.displayPoint();
    
    strokeWeight(1); //Display the direction of the agent with a line
    stroke(255,0,0,0);
  //pa.displayDir(pa.vel.magnitude()*3);
  }
  id=0;
  
  fill(255);

  textAlign(LEFT);
   textSize(14);
 // text("FPS "+frameRate,-(width/2)+20,(height/2)-40);
  //text("F1 "+fil0+" | F2 "+fil1+" | F3 "+fil2,-(width/2)+20,(height/2)-20);

 //gui();
 info(); // SCREEN TEXT EXTRA INFO
 server.sendScreen();
}
