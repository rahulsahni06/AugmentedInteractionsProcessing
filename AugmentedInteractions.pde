void setup() {
  //size(600, 600);
  fullScreen();
  background(0); 
}


int x1 = -1, y1 = -1;
int x2 = -1, y2 = -1;
boolean isMousePressed = false;

void draw() {
  stroke(0);
  background(255);
  if(isMousePressed && x1 != -1) {
    drawRectangle(x1, y1, mouseX, mouseY);
    //drawOval();
  }
}

void drawRectangle(int x1, int y1, int x2, int y2) {
  
  if(x1 > x2) {
    int temp = x2;
    x2 = x1;
    x1 = temp;
    
  }
  
  if(y1 > y2) {
    int temp = y2;
    y2 = y1;
    y1 = temp;
  }
  
  rect(x1, y1, x2-x1, y2-y1);
}

void mousePressed() {
  isMousePressed = true;
  x1 = mouseX;
  y1 = mouseY;
  
}

void mouseReleased() {
 isMousePressed = false; 
}
