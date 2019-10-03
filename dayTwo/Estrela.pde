public class Estrela{
  int x, y;
  private int width=0, height=0;
  PImage[] frames;
  static public final int totalFrames = 8 ;
  int frame = 0;
  static final String filePrefix = "data/start blinking-";
  
  public Estrela(int frameStart){
    this();
    frame = frameStart;
  }
  public Estrela(){
    frames = new PImage[totalFrames];
    for (int i = 0; i < totalFrames; i++) {
      String filename = filePrefix + nf(i+1, 1) + ".png";
      frames[i] = loadImage(filename);
      width = Math.max(width,frames[i].width);
      height = Math.max(height,frames[i].height);
    }
  }

  
  public void draw(){
    if(frameCount % (frameRate/frames.length) == 0)
      frame = ++frame % frames.length;
    image(frames[frame], getX(), getY());
  }
  
  public int getWidth(){ return this.width; }
  public int getHeight(){ return this.height; }
  
  public void setX(int x){ this.x = x; }
  
  public void setY(int y){ this.y = y; }

  public int getX(){ return x; }

  public int getY(){ return y; }

}
