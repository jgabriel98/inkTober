void setup() {
  size(500, 800, P3D);
  frameRate(30);
}

int z=0;
void draw() {
  background(0);


  pointLight(255, 100, 100, mouseX, mouseY, 0);
  translate(width/2, height/2, z);

  noStroke();
  fill(255, 255, 255, 220);
  sphere(50);
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  z -= 5*e;
  println(z);
}
