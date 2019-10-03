import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class dayOne extends PApplet {



ArrayList<Ring> anel;


public void setup() {
  
  frameRate(60);
  

  
  float rotSum = 0;
  anel = new ArrayList<Ring>(17);
  for(int i=0; i<20; i++){
    anel.add(new Ring());
    anel.get(i).spin(rotSum);
    anel.get(i).setSpinSpeed(random(0,1));
    //anel[i].setAngle(random(anel[i].defaultAngle * 0.80, anel[i].defaultAngle * 1.2)); 
    
    //rotSum += random(0,2*PI);
    rotSum += anel.get(0).defaultAngle;
  }
  Collections.sort(anel);
}
int ringToColor = 0;
public void draw() {
  background(255,255,255,255);
  


  if((frameCount) % ceil(60/anel.size()) == 0){
    anel.get(ringToColor).cor = color(random(0,255), random(0,255), random(0,255), random(50,255));
    ringToColor = (ringToColor+1) % anel.size();
  }
   
  for(int i=0; i < anel.size(); i++){ //<>//
    anel.get(i).draw();
    float x = mouseX-(width/2), y = (height-mouseY) - (height/2);
    float theta = atan2(y,x);
    anel.get(i).rotate(theta);

    //anel.get(i).rotate(degrees(theta));
    //anel.get(i).setAngle(degrees( anel.get(i).defaultAngle) );
    
    if(i%2==0)
      anel.get(i).spin(anel.get(i).getSpinSpeed());
    else
      anel.get(i).spin(-anel.get(i).getSpinSpeed());
    println(anel.get(i).getSpinSpeed(), " - ", x, ", ",y);
  }

}
class Ring implements Comparable<Ring>{
  
  private float x,y,z;
  private float z_rot, y_rot;
  public final float defaultSpinSpeed = 1;//em graus
  private float spinSpeed = defaultSpinSpeed; 
  public final float defaultAngle = (PI/2) *0.30f ;
  private float angle = defaultAngle;
  
  float size;
  public int cor;
  
  boolean upRot = true;

  Ring(){
    x = width/2;
    y = height/2;
    z = 100;
    z_rot = 0.0f;
    y_rot = 0.0f;
    size = random(200,400);
    cor = color(random(0,255), random(0,255), random(0,255), random(100,255));
  }

  public void draw(){
    pushMatrix();
    noFill();
    strokeWeight(4);
    stroke(cor);
    ellipseMode(CENTER);
    translate(x,y,z);
    rotateZ(z_rot);
    rotateY(y_rot);
    //rotateY(angle);
    //rotateY(PI/2*sin(z_rot));
    //rotateX(PI/2*cos(z_rot));
    ellipse(0,0,size, size);
    popMatrix();
  }
  
  public void spin(float rotAdd){
    y_rot += radians(rotAdd);
    if(y_rot >=360)
      y_rot = y_rot - 360;
    if(y_rot <= -360)
      y_rot = y_rot + 360;
  }
  
  public void setSpinSpeed(float rotSpeed){ spinSpeed = rotSpeed; }
  public float getSpinSpeed(){ return spinSpeed; }

  public void rotate(float rotAdd){
    z_rot += radians(rotAdd);
    if(z_rot >=360)
      z_rot = z_rot - 360;
    if(z_rot <= -360)
      z_rot = z_rot + 360;
  }  
  public void spin(){
    spin(spinSpeed);
  }
  public void setRotation(float rot){z_rot = radians(rot);}
  public float getRotation(){ return degrees(z_rot); }
  
  
  public void setAngle(float graus){ angle = radians(graus); }
  

  
  public void setX(float x){ this.x = x; }
  public void setY(float y){ this.y = y; }
  public void setZ(float z){ this.z = z; }

  public float getX(){ return x; }
  public float getY(){ return y; }
  public float getZ(){ return z; }
  
  
  @Override
  public int compareTo(Ring r){
    if(this.size < r.size) return -1;
    if(this.size > r.size) return 1;
    
    return 0;
  }
}
  public void settings() {  size(800,800,P3D);  smooth(8); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "dayOne" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
