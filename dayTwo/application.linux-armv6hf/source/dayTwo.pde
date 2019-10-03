int FPS = 60;
Util util = new Util();

float theta;
float R, inner_R;

PImage rosto;
Estrela[] estrelas = new Estrela[4*300];



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
  util.setGradient(0, 0, width, height, color(#030415), color(#111124), 'y');

  desenhaEstrelas();



  stroke(255);
  // Let's pick an angle 0 to 90 degrees based on the mouse position
  float a = ((height-mouseY) / (float) width) * 135;
  println(a," - ", mouseY);
  // Convert it to radians
  theta = radians(a);
  pushMatrix();
  // Start the tree from the bottom of the screen
  translate(width/2,height/2);
  // Draw a line 120 pixels
  //line(0,0,0,-230);
  // Move to the end of that line
  translate(0,-70);
  // Start the recursive branching!
  branch(150, theta, #98B2E8, #7600AA);
  popMatrix();
  
  pushMatrix();
  translate(width/2, height/2);
  rotate(radians(180));
  translate(0,70);
  branch(170,radians(23), #455C8E, #554243);
  popMatrix();
  
  image(rosto, width/2, height/2);
}


void branch(float h, float theta, color c1, color finalColor) {
  // Each branch will be 2/3rds the size of the previous one
  h *= 0.68;
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
    branch(h, theta, c2, finalColor);       // Ok, now call myself to draw two new branches!!
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
    branch(h, theta, c2, finalColor);
    popMatrix();
  }
}

float angle = 0;
float speed = 0.001 / frameRate;
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
