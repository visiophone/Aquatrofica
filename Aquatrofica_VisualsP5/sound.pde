import processing.sound.*;
SoundFile sound0;
SoundFile sound1;
SoundFile sound2;
SoundFile sound3;

SoundFile pedraIn;
SoundFile pedraOut;


int filtroCount=0; // Saber quantos filtros estão, para saber que filtros tocar
int filtroCountPre=0; // Check Mudança filros

boolean fil0Pre=false;
boolean fil1Pre=false;
boolean fil2Pre=false;

void startSound(){
  
  // Load a soundfile
  sound0 = new SoundFile(this, "pedras0.wav");
  sound1 = new SoundFile(this, "pedras1.wav");
  sound2 = new SoundFile(this, "pedras2.wav");
  sound3 = new SoundFile(this, "pedras3.wav");
 
  pedraIn = new SoundFile(this, "pedra_in.wav");
  pedraOut = new SoundFile(this, "pedra_out.wav");
  
  sound0.loop();
  println("0 "+sound0.isPlaying()+" | 1 "+sound1.isPlaying()+" | 2 "+sound2.isPlaying()+" | 3 "+sound3.isPlaying());
}


void sound(){
  
  // SOUNDS DE FUNDO
  filtroCount=int(fil0)+int(fil1)+int(fil2); // CONTAGEM DOS FILTROS
  
  if(filtroCount!=filtroCountPre){    
    println("Change "+filtroCount); // SE HA MUDANÇA NO NR DE FILTROS
    sound0.stop(); // APAGAM TODOS
    sound1.stop();
    sound2.stop();
    sound3.stop();
   
    if(filtroCount==0) sound0.loop(); // DISPARA O NR EXACTO
    if(filtroCount==1) sound1.loop();
    if(filtroCount==2) sound2.loop();
    if(filtroCount==3) sound3.loop();    
    
    println("0 "+sound0.isPlaying()+" | 1 "+sound1.isPlaying()+" | 2 "+sound2.isPlaying()+" | 3 "+sound3.isPlaying());
  }
  
  filtroCountPre=filtroCount;
  
  // SONS PEDRA ON / OFF  
  if(fil0) { if(fil0Pre==false) pedraIn.play();}
  if(!fil0) { if(fil0Pre==true) pedraOut.play();}
  
  if(fil1) { if(fil1Pre==false) pedraIn.play();}
  if(!fil1) { if(fil1Pre==true) pedraOut.play();}
  
  if(fil2) { if(fil2Pre==false) pedraIn.play();}
  if(!fil2) { if(fil2Pre==true) pedraOut.play();}
  
  fil0Pre=fil0;
  fil1Pre=fil1;
  fil2Pre=fil2;
  
}
