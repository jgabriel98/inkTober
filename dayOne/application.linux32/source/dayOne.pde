import java.util.*;

ArrayList<Ring> anel;


void setup() {
  size(800,800,P3D);
  frameRate(60);
  smooth(8);

  
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
void draw() {
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
