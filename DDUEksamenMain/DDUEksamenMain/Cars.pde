class cars {

  int x, y;
  int retning;
  
  cars(int x, int y){
    this.x = round(x*Scale);
    this.y = round(y*Scale);
}

void display(){
  fill(0,0,255);
  rect(x,y,Scale,Scale);
  
}

void move(){
  if (pressed[65]) { /* A */
    if (x/Scale > 0) {
      x -= Scale;
    }
  }

  if (pressed[68]) { /* D */
    if (x/Scale < columns-1) {
      x += Scale;
    }
  }

  if (pressed[87]) { /* W */
    if (y/Scale > 0) {
      y-=Scale;
    }
  }

  if (pressed[83]) { /* S */
    if (y/Scale < rows-1) {
      y+=Scale;
    }
  }
}

void collision(){

  

}

}
