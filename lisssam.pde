import java.math.BigDecimal;

final static float DEFAULT_AMPLITUDE = 50.0;

boolean timeStopped = false;

float x;
float y;

float prevX;
float prevY;

float amplitudeY;
float amplitudeX;


float frequencyY;
float frequencyX;

boolean hasMouseBeenPressed = false;


void setup() {
  size(1280, 640); 
  stroke(255);
  background(10, 30, 40);

  x = width/2;
  y = height/2;
  
  amplitudeX = DEFAULT_AMPLITUDE;
  amplitudeY = DEFAULT_AMPLITUDE;
  
  frequencyX = 20.0;
  frequencyY = 20.0;
}

void draw() {
  translate(width/2,height/2);
  resetBackground();
  print("X Frequency set to: " + frequencyX+  "  |  Y Frequency set to: " + frequencyY+ "\n");
  loop();
  for(int x = 0; x < 3000; x++){
    drawFigure(x);
  }
}

void loop(){

  if(mousePressed){
    if(mouseButton == LEFT){
      print("Increasing amplituteY: " + amplitudeY+ "\n");
      amplitudeY ++;  
    } else if(mouseButton == RIGHT) {
      timeStopped = true;
      if(amplitudeX < 1 && amplitudeX <= DEFAULT_AMPLITUDE){
          print("AmplitudeX was 0, incrementing to "+ amplitudeX +"\n");
          amplitudeX += 0.1;
      }
      amplitudeX -= 1;
      print("Decreasing amplituteX: " + amplitudeX+ "\n");
    }
  }
  if(hasMouseBeenPressed){
    if(amplitudeY > DEFAULT_AMPLITUDE){
      print("Decrementing amplitudeY to default..."+ "\n");
      amplitudeY -= 1;
    } else if(amplitudeX < DEFAULT_AMPLITUDE){
        print("Incrementing amplitudeX to default..."+ "\n");
        amplitudeX += 0.5;
    } else if(amplitudeX == DEFAULT_AMPLITUDE && amplitudeY == DEFAULT_AMPLITUDE){
        hasMouseBeenPressed = false; 
    }
    print("Amplitudes: X " + amplitudeX + " Y " + amplitudeY+ "\n");
  }
}

void drawFigure(int clock){
  y = sin(clock / frequencyY) * amplitudeY*3;
  x = cos(clock / frequencyX) * amplitudeX*3;
  if(clock == 0){
    prevX = x;
    prevY = y;
  }
  line(x ,y, prevX, prevY);  
  prevX = x;
  prevY = y;
}

void resetBackground(){
    background(10, 30, 40);
}

void mousePressed(){
    hasMouseBeenPressed = false;
}
void mouseReleased(){
  print("Mouse has been released"+ "\n");
  timeStopped = false;
  hasMouseBeenPressed = true;
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      frequencyX =  round(frequencyX + 0.5, 1);
    }
    if(keyCode == DOWN){
     frequencyX = round(frequencyX - 0.5, 1);
    }
  }
}

void mouseWheel(MouseEvent event){
  frequencyY += event.getCount();
}

float round(float d, int decimalPlace) {
    BigDecimal bd = new BigDecimal(Float.toString(d));
    bd = bd.setScale(decimalPlace, BigDecimal.ROUND_HALF_UP);
    return bd.floatValue();
}
