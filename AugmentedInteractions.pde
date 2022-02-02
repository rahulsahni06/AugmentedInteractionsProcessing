import java.util.*;

final int FREE_LINE = 1;
final int LINE = 2;
final int RECTANGLE = 3;
final int OVAL = 4;

int shapeToDraw = FREE_LINE;

int x1 = -1, y1 = -1;

boolean isMousePressed = false;

Rectangle rectangle;
Line line;
Oval oval;
FreeLine freeLine;

Stack<Shape> shapesStack = new Stack();

void setup() {
  size(800, 800);
  //fullScreen();
  background(255); 
}


void draw() {
  stroke(0);
  background(255);
  drawSavedShapes();
  drawShapes();
 
}

void drawSavedShapes() {
  for(Shape shape : shapesStack) {
    shape.draw();
  }
}

void drawShapes() {
  if(isMousePressed) {
    if(shapeToDraw == RECTANGLE) {
      drawRectangle(x1, y1, mouseX, mouseY);
    } else if(shapeToDraw == OVAL) {
      drawOval (x1, y1, mouseX, mouseY);
    } else if(shapeToDraw == LINE) {
      drawLine(x1, y1, mouseX, mouseY);
    } else if(shapeToDraw == FREE_LINE) {
      drawFreeLine(mouseX, mouseY, pmouseX, pmouseY);
    }
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
  rectangle = new Rectangle(x1, y1, x2, y2);  
  
}

void drawLine(int x1, int y1, int x2, int y2) {
  line(x1, y1, x2, y2);
  line = new Line(x1, y1, x2, y2);
}

void drawOval (int x1, int y1, int x2, int y2){
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
  
  ellipseMode(CORNER);
  ellipse(x1, y1, x2-x1, y2-y1);
  oval = new Oval(x1, y1, x2-x1, y2-y1);
  
}

void drawFreeLine(int x1, int y1, int x2, int y2) {
  line(x1, y1, x2, y2);
  freeLine = new FreeLine(new Line(x1, y1, x2, y2));
  shapesStack.push(freeLine);
}

void mousePressed() {
  isMousePressed = true;
  x1 = mouseX;
  y1 = mouseY; 
}

void mouseReleased() {
 isMousePressed = false; 
 
 if(shapeToDraw == RECTANGLE) {
      shapesStack.push(rectangle);
  } else if(shapeToDraw == OVAL) {
    shapesStack.push(oval);
  } else if(shapeToDraw == LINE) {
    shapesStack.push(line);
  } 
}

void keyPressed() {
  
  if(mousePressed) {
    return;
  }
  
  if(key == BACKSPACE && shapesStack.size() >= 1) {
    shapesStack.pop();
  } else if(key=='o' || key == 'O' ) {
    shapeToDraw = OVAL;
  } else if(key=='l' || key == 'L' ) {
    shapeToDraw = LINE;
  } else if(key=='f' || key == 'F' ) {
    shapeToDraw = FREE_LINE;
  } else if(key == 'r' || key == 'R') {
    shapeToDraw = RECTANGLE;
  }
}

abstract class Shape {
  abstract void draw();
}

class Point {
  int x, y;
  Point(int x, int y) {
    this.x = x;
    this.y = y;
  }
}

class Rectangle extends Shape {
  int x1, y1, x2, y2;
  Point p1, p2;
  
  Rectangle(int x1, int y1, int x2, int y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.p1 = new Point(x1, y1);
    this.p2 = new Point(x2, y2);
  }
  
 
  void draw() {
    rect(p1.x, p1.y, p2.x-p1.x, p2.y-p1.y);
  }
}

class Line extends Shape {
  int x1, y1, x2, y2;
  Point p1, p2;
  
   Line(int x1, int y1, int x2, int y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.p1 = new Point(x1, y1);
    this.p2 = new Point(x2, y2);
  }
  
  void draw() {
    line(p1.x, p1.y, p2.x, p2.y);
  }
}

class Oval extends Shape {
  int x, y, width, height;
  
  Oval(int x, int y, int width, int height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }
  
  void draw() {
    ellipse(x, y, width, height);
  }
}

class FreeLine extends Shape {
  Line line;
  
  FreeLine(Line line) {
    this.line = line;
  }
  
  void draw() {
    line.draw();
  }
  
}
