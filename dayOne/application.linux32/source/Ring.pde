class Ring implements Comparable<Ring>{
  
  private float x,y,z;
  private float z_rot, y_rot;
  public final float defaultSpinSpeed = 1;//em graus
  private float spinSpeed = defaultSpinSpeed; 
  public final float defaultAngle = (PI/2) *0.30 ;
  private float angle = defaultAngle;
  
  float size;
  public color cor;
  
  boolean upRot = true;

  Ring(){
    x = width/2;
    y = height/2;
    z = 100;
    z_rot = 0.0;
    y_rot = 0.0;
    size = random(200,400);
    cor = color(random(0,255), random(0,255), random(0,255), random(100,255));
  }

  void draw(){
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
  
  void spin(float rotAdd){
    y_rot += radians(rotAdd);
    if(y_rot >=360)
      y_rot = y_rot - 360;
    if(y_rot <= -360)
      y_rot = y_rot + 360;
  }
  
  void setSpinSpeed(float rotSpeed){ spinSpeed = rotSpeed; }
  float getSpinSpeed(){ return spinSpeed; }

  void rotate(float rotAdd){
    z_rot += radians(rotAdd);
    if(z_rot >=360)
      z_rot = z_rot - 360;
    if(z_rot <= -360)
      z_rot = z_rot + 360;
  }  
  void spin(){
    spin(spinSpeed);
  }
  void setRotation(float rot){z_rot = radians(rot);}
  float getRotation(){ return degrees(z_rot); }
  
  
  void setAngle(float graus){ angle = radians(graus); }
  

  
  void setX(float x){ this.x = x; }
  void setY(float y){ this.y = y; }
  void setZ(float z){ this.z = z; }

  float getX(){ return x; }
  float getY(){ return y; }
  float getZ(){ return z; }
  
  
  @Override
  public int compareTo(Ring r){
    if(this.size < r.size) return -1;
    if(this.size > r.size) return 1;
    
    return 0;
  }
}
