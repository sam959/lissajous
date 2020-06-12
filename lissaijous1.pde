import java.math.BigDecimal;
float counter;
float x;
float y;

float amplitudeY;
float frequencyY;
float frequencyX;
boolean hasMouseBeenPressed = false;

void setup() {
  size(640, 640); 
  //stroke(222, 189, 24);
  background(10, 30, 40);
  frameRate(2000);
  x = width/2;
  y = height/2;
  
  amplitudeY = 50.0;
  frequencyY = 1.0;
  frequencyX = 2;
}

void draw() {
  print("X Frequency set to: " + frequencyX+  "  |  Y Frequency set to: " + frequencyY+ "\n");
  if(frameCount %7 == 0){
    //blendMode(DIFFERENCE);
    fill(10, 30, 40, 2);
    noStroke();
    rect(0,0, width, height);
  }
  stroke(222, 189, 24);
  strokeWeight(1);

  translate(width/2,height/2);
  x++;
  loop();
}

void loop(){
 
  if(mousePressed){
    if(mouseButton == RIGHT){
      background(10, 30, 40);
    }
    else{
      amplitudeY +=  0.02;  
    }
  }
  if(hasMouseBeenPressed){
    if(amplitudeY > 50){
      amplitudeY -= 0.02;
    } else {
     hasMouseBeenPressed = false; 
    }
  }
  y = sin(x / frequencyY) * amplitudeY*3;
  float xCoord = sin(x / frequencyX) * amplitudeY*3;
  point(xCoord,y);
}

void mouseWheel(MouseEvent event){
  frequencyY = round(frequencyY+ (event.getCount()*0.1), 1);
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      frequencyX =  round(frequencyX + 0.1, 1);
    }
    if(keyCode == DOWN){
     frequencyX = round(frequencyX - 0.1, 1);
    }
    
  }
}

void mouseReleased(){
  hasMouseBeenPressed = true;
}

float round(float d, int decimalPlace) {
    BigDecimal bd = new BigDecimal(Float.toString(d));
    bd = bd.setScale(decimalPlace, BigDecimal.ROUND_HALF_UP);
    return bd.floatValue();
}
