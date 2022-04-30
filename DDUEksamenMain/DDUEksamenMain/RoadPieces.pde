class RoadPieces {
  PImage rImage;

  void Corners() {
    switch(rotate) {
      //1 = left     2 = right      3 = up        4 = down
    case 1: //UpRight


      vejFelt[round(mouseX/Scale)][round(mouseY/Scale-1)] = new Road(round(mouseX/Scale), round(mouseY/Scale-1), 1, true);
      vejFelt[round(mouseX/Scale+1)][round(mouseY/Scale-1)] = new Road(round(mouseX/Scale+1), round(mouseY/Scale-1), 1, true);

      vejFelt[round(mouseX/Scale)][round(mouseY/Scale)] = new Road(round(mouseX/Scale), round(mouseY/Scale), 2, true);
      vejFelt[round(mouseX/Scale+1)][round(mouseY/Scale)] = new Road(round(mouseX/Scale+1), round(mouseY/Scale), 2, true);


      vejFelt[round(mouseX/Scale)][round(mouseY/Scale+1)] = new Road(round(mouseX/Scale), round(mouseY/Scale+1), 3, true);

      vejFelt[round(mouseX/Scale-1)][round(mouseY/Scale-1)] = new Road(round(mouseX/Scale-1), round(mouseY/Scale-1), 4, true);
      vejFelt[round(mouseX/Scale-1)][round(mouseY/Scale)] = new Road(round(mouseX/Scale-1), round(mouseY/Scale), 4, true);
      vejFelt[round(mouseX/Scale-1)][round(mouseY/Scale+1)] = new Road(round(mouseX/Scale-1), round(mouseY/Scale+1), 4, true);



      break;


    case 2: //DownLeft
      vejFelt[round(mouseX/Scale)][round(mouseY/Scale-1)] = new Road(round(mouseX/Scale), round(mouseY/Scale-1), 1, true);
      vejFelt[round(mouseX/Scale+1)][round(mouseY/Scale-1)] = new Road(round(mouseX/Scale+1), round(mouseY/Scale-1), 1, true);
      vejFelt[round(mouseX/Scale-1)][round(mouseY/Scale-1)] = new Road(round(mouseX/Scale-1), round(mouseY/Scale-1), 1, true);


      vejFelt[round(mouseX/Scale-1)][round(mouseY/Scale)] = new Road(round(mouseX/Scale-1), round(mouseY/Scale), 2, true);


      vejFelt[round(mouseX/Scale+1)][round(mouseY/Scale)] = new Road(round(mouseX/Scale+1), round(mouseY/Scale), 3, true);
      vejFelt[round(mouseX/Scale+1)][round(mouseY/Scale+1)] = new Road(round(mouseX/Scale+1), round(mouseY/Scale+1), 3, true);


      vejFelt[round(mouseX/Scale)][round(mouseY/Scale)] = new Road(round(mouseX/Scale), round(mouseY/Scale), 4, true);
      vejFelt[round(mouseX/Scale)][round(mouseY/Scale+1)] = new Road(round(mouseX/Scale), round(mouseY/Scale+1), 4, true);

      break;


    case 3: //UpLeft
      vejFelt[round(mouseX/Scale)][round(mouseY/Scale)] = new Road(round(mouseX/Scale), round(mouseY/Scale), 1, true);
      vejFelt[round(mouseX/Scale-1)][round(mouseY/Scale)] = new Road(round(mouseX/Scale-1), round(mouseY/Scale), 1, true);


      vejFelt[round(mouseX/Scale)][round(mouseY/Scale+1)] = new Road(round(mouseX/Scale), round(mouseY/Scale+1), 2, true);
      vejFelt[round(mouseX/Scale-1)][round(mouseY/Scale+1)] = new Road(round(mouseX/Scale-1), round(mouseY/Scale+1), 2, true);


      vejFelt[round(mouseX/Scale+1)][round(mouseY/Scale)] = new Road(round(mouseX/Scale+1), round(mouseY/Scale), 3, true);
      vejFelt[round(mouseX/Scale+1)][round(mouseY/Scale+1)] = new Road(round(mouseX/Scale+1), round(mouseY/Scale+1), 3, true);
      vejFelt[round(mouseX/Scale+1)][round(mouseY/Scale-1)] = new Road(round(mouseX/Scale+1), round(mouseY/Scale-1), 3, true);


      vejFelt[round(mouseX/Scale)][round(mouseY/Scale-1)] = new Road(round(mouseX/Scale), round(mouseY/Scale-1), 4, true);

      break;

    case 4: //DownRight
      vejFelt[round(mouseX/Scale+1)][round(mouseY/Scale)] = new Road(round(mouseX/Scale+1), round(mouseY/Scale), 1, true);


      vejFelt[round(mouseX/Scale)][round(mouseY/Scale+1)] = new Road(round(mouseX/Scale), round(mouseY/Scale+1), 2, true);
      vejFelt[round(mouseX/Scale-1)][round(mouseY/Scale+1)] = new Road(round(mouseX/Scale-1), round(mouseY/Scale+1), 2, true);
      vejFelt[round(mouseX/Scale+1)][round(mouseY/Scale+1)] = new Road(round(mouseX/Scale+1), round(mouseY/Scale+1), 2, true);

      vejFelt[round(mouseX/Scale)][round(mouseY/Scale)] = new Road(round(mouseX/Scale), round(mouseY/Scale), 3, true);
      vejFelt[round(mouseX/Scale)][round(mouseY/Scale-1)] = new Road(round(mouseX/Scale), round(mouseY/Scale-1), 3, true);



      vejFelt[round(mouseX/Scale-1)][round(mouseY/Scale)] = new Road(round(mouseX/Scale-1), round(mouseY/Scale), 4, true);
      vejFelt[round(mouseX/Scale-1)][round(mouseY/Scale-1)] = new Road(round(mouseX/Scale-1), round(mouseY/Scale-1), 4, true);

      break;
    }
  }

  void mainRoad() {
  }
}
