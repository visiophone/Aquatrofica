// screen with extra info + legendas

void info(){

  if(fil0){ 
  pushMatrix();
  translate(radius+130,radius);
  textAlign(LEFT);
  rotate(radians(-90));
  fill(255);
  textSize(24); 
  text("OURIÇOS | PEPINOS DO MAR",-20,0); 
  stroke(200);
  strokeWeight(3);
  line(0,-50,0,-radius);
  popMatrix();
}

  
///  
if(fil1){
  pushMatrix();
  translate(radius+130,0);
  textAlign(CENTER);
  rotate(radians(-90));
  fill(255);
  textSize(24); 
  text("MEXILHÕES | OSTRAS",0,0); 
  popMatrix();
}
//  

if(fil2){ 
  pushMatrix();
  translate(radius+130,-radius);
  textAlign(RIGHT);
  rotate(radians(-90));
  fill(200);
  textSize(24); 
  text("MACROALGAS MARINHAS",20,0);
   stroke(200);
  strokeWeight(2);
  line(0,-50,0,-radius);
  popMatrix();
}

// LEGENDA GERAL
  pushMatrix();
  noStroke();
  translate((width/2)-270,(height/2)-65);
  rotate(radians(-90));
  textAlign(LEFT);
  fill(0,232,255);
  ellipse(0,-5,15,15);
  fill(255);
  textSize(18); 
  text("MATÉRIA ORGÂNICA",20,0); 
  //println("hei!!");
  
  fill(255,0,80);
  ellipse(0,20,15,15);
  fill(255);
  textSize(18); 
  text("NUTRIENTES ORGÂNICOS",20,25); 
  
  fill(150,255,0);
  ellipse(0,45,15,15);
  fill(255);
  textSize(18); 
  text("NUTRIENTES INORGÂNICOS",20,50);
  
  fill(255);
  ellipse(0,70,15,15);
  fill(255);
  textSize(18); 
  text("ÁGUA",20,75); 
  popMatrix();
}
