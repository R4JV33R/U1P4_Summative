import ddf.minim.analysis.*;
import ddf.minim.*;

Minim       minim;
AudioPlayer jingle;
FFT         fft;

PVector[] pv;
PVector gravity = new PVector(0, 0.6);
float xSpeed=4;
float ySpeed=4;
int COUNT = 10;
int x = 0;
int y = 0;
int screen;
PVector pos = new PVector (200, 200);


void setup()
{
  size(400, 400, P3D);
  pv = new PVector[40];
  pv[0]= new PVector (10, 10);

  {
    minim = new Minim(this);


    jingle = minim.loadFile("unity.mp3", 1024);


    jingle.loop();


    fft = new FFT( jingle.bufferSize(), jingle.sampleRate() );
  }
  for (int i=0; i<COUNT; i++)
  {
    pv[i] = new PVector (random(50, 400), (100));
  }
}

void draw ()
{
  fill(random(0, 255), random(0, 255), random(0, 255), 10);
  rect(0, 0, width, height);
  fill(255, 255, 255, 25);
  rect(0, 0, width, height);
  fill(155, 0, 155);
  stroke(255);


  fft.forward( jingle.mix );

  for (int i = 0; i < fft.specSize(); i++)
  {

    line( i, height, i, height - fft.getBand(i)*8 );
  }


  fill (random(0, 255), random(0, 255), random(0, 255));
  if (dist(x, y, pos.x, pos.y)<25)
  {
    screen = 2;
  }
  for (int i=0; i<COUNT; i++)
  {
    ellipse(pv[i].x, pv[i].y, 20, 20);

    pv[i].x +=xSpeed;

    if (pv[i].x > width) {
      xSpeed *=-1;
    }


    pv[i].y +=ySpeed;
    if (pv[i].x < 0) {
      xSpeed +=1;
    }
    if (pv[i].y > height) {
      ySpeed *=-1;
    }
    if (pv[i].y < 0) {
      ySpeed *=-1;
    }
  }
}
