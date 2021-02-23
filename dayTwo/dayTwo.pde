int FPS = 60;
Util util = new Util();

float theta;
float R, inner_R;

PImage rosto;
Estrela[] estrelas = new Estrela[4*350];



void setup() {
  size(1280, 760, P2D);
  frameRate(FPS);
  rosto = loadImage("data/duasFaces-vazia.png");
  rosto.resize(0,min(width-50, height-50));
  
  R = sqrt(pow(width*2,2) + pow(height*2,2));
  inner_R = sqrt(pow(width,2) + pow(height,2));
  for(int i=0; i<estrelas.length; i++){
    estrelas[i] = new Estrela((int)random(0,estrelas[i].totalFrames));
    
    double r = random(inner_R, R);
    float a = random(0,1) * TWO_PI;
    estrelas[i].setX((int) (r*cos(a)) );
    estrelas[i].setY((int) (r*sin(a)) );
  }
  imageMode(CENTER);
}

float rotation = 0;
void draw() {
  util.setGradient(0, 0, width, height, color(#030415), color(#111120), 'y');

  desenhaEstrelas();
  controla_aparencia_do_cursor();
  



  stroke(255);
  // Let's pick an angle 0 to 90 degrees based on the mouse position
  float a = ((height-mouseY) / (float) height) * 120;
  theta = radians(a);
  
  pushMatrix();
  
  translate(width/2,height/2);// começa a arvore/cerebro no meio da tela
  translate(0,-70);  //move so mais um pouquinho
  
  color c1 = lerpColor(#98B2E8,#FFFFFF, mouseY / (float) height); //#7600AA
  color c2 = lerpColor(#C505E2,#FFFFFF, mouseY / (float) height); //#7600AA
  // Start the recursive branching!
  branch(150, theta, 0.68, c1, c2);
  popMatrix();
  
  
  pushMatrix();
  translate(width/2, height/2);
  rotate(radians(180));
  
  
  calcPulseStep();
  float pulse_range = (1-(mouseY / (float)height));
  color c3 = lerpColor(#455C8E, #D83D3D, pulse_step * pulse_range*1.5);  //pulsar entre a cor normal e vermelho
  stroke(lerpColor(c1,c3, 0.5));
  line(0,0,0,70);
  
  branch(200,radians(25), 0.58, c3, #554243);
  popMatrix();
  
  image(rosto, width/2, height/2);
}

float pulse_step = 0.0;
boolean pulse_direction = true;  //true para valor subindo, false para descendo
void calcPulseStep(){
  float step_size = 0.70 / frameRate;  //ciclo com duração de 0.70/s (0,7 ciclo a cada 1 segundos)
  
  if(pulse_step+step_size >= 0.999)
    pulse_direction = false;
  else if(pulse_step-step_size <= 0.001)
    pulse_direction = true;
  
  if(pulse_direction == true){
    pulse_step += step_size;
  }else{
    pulse_step -= step_size; 
  }
  
}


void branch(float h, float theta, float growth_rate, color c1, color finalColor) {
  // Each branch will be 2/3rds the size of the previous one
  h *= growth_rate;
  color c2= lerpColor(c1, finalColor, 1/h);
  
  // All recursive functions must have an exit condition!!!!
  // Here, ours is when the length of the branch is 2 pixels or less
  if (h > 2) {
    pushMatrix();    // Save the current state of transformation (i.e. where are we now)
    rotate(theta);   // Rotate by theta
    
    beginShape(LINES);
    stroke(c1);
    vertex(0,0);
    stroke(c2);
    vertex(0,-h);
    endShape();
    
    translate(0, -h); // Move to the end of the branch
    branch(h, theta, growth_rate, c2, finalColor);       // Ok, now call myself to draw two new branches!!
    popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state
    
    // Repeat the same thing, only branch off to the "left" this time!
    pushMatrix();
    rotate(-theta);
    
    beginShape(LINES);
    stroke(c1);
    vertex(0,0);
    stroke(c2);
    vertex(0,-h);
    endShape();
    
    translate(0, -h);
    branch(h, theta, growth_rate, c2, finalColor);
    popMatrix();
  }
}

float angle = 0;
float speed = 0.0005 / frameRate;
void desenhaEstrelas(){
  for(int i=0; i<estrelas.length; i++){
    pushMatrix();
    translate(0, height);
    translate(0, inner_R);
    rotate(radians(angle+=speed));
    estrelas[i].draw();
    popMatrix();
  }
}

void controla_aparencia_do_cursor(){
  if(mousePressed == false){
    noCursor();
  } else {
    cursor(ARROW);
  }
}
