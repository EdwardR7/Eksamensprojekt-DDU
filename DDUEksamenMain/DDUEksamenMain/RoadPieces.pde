class RoadPieces {
  PImage rImage;

  void Corners() { //size 61x61 pixels for images
    switch(rot) {
      //1 = left     2 = right      3 = up        4 = down      5 = leftup      6 = leftdown      7 = rightup      8 = rightdown;  in the constructor of road
    case 1: //UpRight
      vejFelt[round(mouseX/Scale)][round(mouseY/Scale)] = new Road(round(mouseX/Scale), round(mouseY/Scale), 4, true);
      vejFelt[round(mouseX/Scale)][round(mouseY/Scale+1)] = new Road(round(mouseX/Scale), round(mouseY/Scale+1), 4, true);
      vejFelt[round(mouseX/Scale)][round(mouseY/Scale+2)] = new Road(round(mouseX/Scale), round(mouseY/Scale+2), 4, true);


      vejFelt[round(mouseX/Scale+1)][round(mouseY/Scale)] = new Road(round(mouseX/Scale+1), round(mouseY/Scale), 1, true);
      vejFelt[round(mouseX/Scale+2)][round(mouseY/Scale)] = new Road(round(mouseX/Scale+2), round(mouseY/Scale), 1, true);

      vejFelt[round(mouseX/Scale+1)][round(mouseY/Scale+1)] = new Road(round(mouseX/Scale+1), round(mouseY/Scale+1), 2, true);
      vejFelt[round(mouseX/Scale+2)][round(mouseY/Scale+1)] = new Road(round(mouseX/Scale+2), round(mouseY/Scale+1), 2, true);

      vejFelt[round(mouseX/Scale+1)][round(mouseY/Scale+2)] = new Road(round(mouseX/Scale+1), round(mouseY/Scale+2), 3, true);

      break;

    case 2: //UpLeft
      vejFelt[round(mouseX/Scale)][round(mouseY/Scale)] = new Road(round(mouseX/Scale), round(mouseY/Scale), 1, true);
      vejFelt[round(mouseX/Scale+1)][round(mouseY/Scale)] = new Road(round(mouseX/Scale+1), round(mouseY/Scale), 1, true);
      vejFelt[round(mouseX/Scale+2)][round(mouseY/Scale)] = new Road(round(mouseX/Scale+2), round(mouseY/Scale), 1, true);

      vejFelt[round(mouseX/Scale+2)][round(mouseY/Scale+1)] = new Road(round(mouseX/Scale+2), round(mouseY/Scale+1), 3, true);
      vejFelt[round(mouseX/Scale+2)][round(mouseY/Scale+2)] = new Road(round(mouseX/Scale+2), round(mouseY/Scale+2), 3, true);

      vejFelt[round(mouseX/Scale+1)][round(mouseY/Scale+1)] = new Road(round(mouseX/Scale+1), round(mouseY/Scale+1), 4, true);
      vejFelt[round(mouseX/Scale+1)][round(mouseY/Scale+2)] = new Road(round(mouseX/Scale+1), round(mouseY/Scale+2), 4, true);

      vejFelt[round(mouseX/Scale)][round(mouseY/Scale+1)] = new Road(round(mouseX/Scale), round(mouseY/Scale+1), 2, true);

      break;

    case 3: //DownLeft
      vejFelt[round(mouseX/Scale+2)][round(mouseY/Scale)] = new Road(round(mouseX/Scale+2), round(mouseY/Scale), 3, true);
      vejFelt[round(mouseX/Scale+2)][round(mouseY/Scale+1)] = new Road(round(mouseX/Scale+2), round(mouseY/Scale+1), 3, true);
      vejFelt[round(mouseX/Scale+2)][round(mouseY/Scale+2)] = new Road(round(mouseX/Scale+2), round(mouseY/Scale+2), 3, true);

      vejFelt[round(mouseX/Scale)][round(mouseY/Scale+2)] = new Road(round(mouseX/Scale), round(mouseY/Scale+2), 2, true);
      vejFelt[round(mouseX/Scale+1)][round(mouseY/Scale+2)] = new Road(round(mouseX/Scale+1), round(mouseY/Scale+2), 2, true);

      vejFelt[round(mouseX/Scale)][round(mouseY/Scale+1)] = new Road(round(mouseX/Scale), round(mouseY/Scale+1), 1, true);
      vejFelt[round(mouseX/Scale+1)][round(mouseY/Scale+1)] = new Road(round(mouseX/Scale+1), round(mouseY/Scale+1), 1, true);

      vejFelt[round(mouseX/Scale+1)][round(mouseY/Scale)] = new Road(round(mouseX/Scale+1), round(mouseY/Scale), 4, true);

      break;

    case 4: //DownRight
      vejFelt[round(mouseX/Scale)][round(mouseY/Scale+2)] = new Road(round(mouseX/Scale), round(mouseY/Scale+2), 2, true);
      vejFelt[round(mouseX/Scale+1)][round(mouseY/Scale+2)] = new Road(round(mouseX/Scale+1), round(mouseY/Scale+2), 2, true);
      vejFelt[round(mouseX/Scale+2)][round(mouseY/Scale+2)] = new Road(round(mouseX/Scale+2), round(mouseY/Scale+2), 2, true);

      vejFelt[round(mouseX/Scale)][round(mouseY/Scale)] = new Road(round(mouseX/Scale), round(mouseY/Scale), 4, true);
      vejFelt[round(mouseX/Scale)][round(mouseY/Scale+1)] = new Road(round(mouseX/Scale), round(mouseY/Scale+1), 4, true);

      vejFelt[round(mouseX/Scale+1)][round(mouseY/Scale)] = new Road(round(mouseX/Scale+1), round(mouseY/Scale), 3, true);
      vejFelt[round(mouseX/Scale+1)][round(mouseY/Scale+1)] = new Road(round(mouseX/Scale+1), round(mouseY/Scale+1), 3, true);

      vejFelt[round(mouseX/Scale+2)][round(mouseY/Scale+1)] = new Road(round(mouseX/Scale+2), round(mouseY/Scale+1), 1, true);
      break;
    }
  }

  void doubleRoad() {
    switch(rot) {
    case 1: // v?? horizontal
      vejFelt[round(mouseX/Scale)][round(mouseY/Scale)] = new Road(round(mouseX/Scale), round(mouseY/Scale), 4, true);
      vejFelt[round(mouseX/Scale+1)][round(mouseY/Scale)] = new Road(round(mouseX/Scale+1), round(mouseY/Scale), 3, true);
      break;

    case 2: // v?? diagonal
      vejFelt[round(mouseX/Scale)][round(mouseY/Scale)] = new Road(round(mouseX/Scale), round(mouseY/Scale), 6, true);
      vejFelt[round(mouseX/Scale+1)][round(mouseY/Scale+1)] = new Road(round(mouseX/Scale+1), round(mouseY/Scale+1), 7, true);
      break;

    case 3: // v?? vertical
      vejFelt[round(mouseX/Scale)][round(mouseY/Scale)] = new Road(round(mouseX/Scale), round(mouseY/Scale), 1, true);
      vejFelt[round(mouseX/Scale)][round(mouseY/Scale+1)] = new Road(round(mouseX/Scale), round(mouseY/Scale+1), 2, true);
      break;

    case 4: // v?? diagonal
      vejFelt[round(mouseX/Scale+1)][round(mouseY/Scale)] = new Road(round(mouseX/Scale+1), round(mouseY/Scale), 5, true);
      vejFelt[round(mouseX/Scale)][round(mouseY/Scale+1)] = new Road(round(mouseX/Scale), round(mouseY/Scale+1), 8, true);
      break;
    }
  }

  void singleRoad() {
    switch(rot) {
    case 1: // Up
      vejFelt[round(mouseX/Scale)][round(mouseY/Scale)] = new Road(round(mouseX/Scale), round(mouseY/Scale), 3, true);
      break;
    case 2: // RightUp
      vejFelt[round(mouseX/Scale)][round(mouseY/Scale)] = new Road(round(mouseX/Scale), round(mouseY/Scale), 7, true);
      break;
    case 3: // Right
      vejFelt[round(mouseX/Scale)][round(mouseY/Scale)] = new Road(round(mouseX/Scale), round(mouseY/Scale), 2, true);
      break;
    case 4: // RightDown
      vejFelt[round(mouseX/Scale)][round(mouseY/Scale)] = new Road(round(mouseX/Scale), round(mouseY/Scale), 8, true);
      break;
    case 5: // Down
      vejFelt[round(mouseX/Scale)][round(mouseY/Scale)] = new Road(round(mouseX/Scale), round(mouseY/Scale), 4, true);
      break;
    case 6: // LeftDown
      vejFelt[round(mouseX/Scale)][round(mouseY/Scale)] = new Road(round(mouseX/Scale), round(mouseY/Scale), 6, true);
      break;
    case 7: // Left
      vejFelt[round(mouseX/Scale)][round(mouseY/Scale)] = new Road(round(mouseX/Scale), round(mouseY/Scale), 1, true);
      break;
    case 8: // LeftUp
      vejFelt[round(mouseX/Scale)][round(mouseY/Scale)] = new Road(round(mouseX/Scale), round(mouseY/Scale), 5, true);
      break;
    }
  }
  void traficlights() {
    //r??kke 1
    vejFelt[round(mouseX/Scale)+1][round(mouseY/Scale)] = new Road(round(mouseX/Scale)+1, round(mouseY/Scale), 4, true, true, 0);
    vejFelt[round(mouseX/Scale)+2][round(mouseY/Scale)] = new Road(round(mouseX/Scale)+2, round(mouseY/Scale), 3, true);

    //r??kke 2
    vejFelt[round(mouseX/Scale)][round(mouseY/Scale)+1] = new Road(round(mouseX/Scale), round(mouseY/Scale)+1, 1, true);
    vejFelt[round(mouseX/Scale)+1][round(mouseY/Scale)+1] = new Road(round(mouseX/Scale)+1, round(mouseY/Scale)+1, 0, true);
    vejFelt[round(mouseX/Scale)+2][round(mouseY/Scale)+1] = new Road(round(mouseX/Scale)+2, round(mouseY/Scale)+1, 0, true);
    vejFelt[round(mouseX/Scale)+3][round(mouseY/Scale)+1] = new Road(round(mouseX/Scale)+3, round(mouseY/Scale)+1, 1, true, true, 300);

    //r??kke 3
    vejFelt[round(mouseX/Scale)][round(mouseY/Scale)+2] = new Road(round(mouseX/Scale), round(mouseY/Scale)+2, 2, true, true, 300);
    vejFelt[round(mouseX/Scale)+1][round(mouseY/Scale)+2] = new Road(round(mouseX/Scale)+1, round(mouseY/Scale)+2, 0, true);
    vejFelt[round(mouseX/Scale)+2][round(mouseY/Scale)+2] = new Road(round(mouseX/Scale)+2, round(mouseY/Scale)+2, 0, true);
    vejFelt[round(mouseX/Scale)+3][round(mouseY/Scale)+2] = new Road(round(mouseX/Scale)+3, round(mouseY/Scale)+2, 2, true);

    //r??kke 4
    vejFelt[round(mouseX/Scale)+1][round(mouseY/Scale)+3] = new Road(round(mouseX/Scale)+1, round(mouseY/Scale)+3, 4, true);
    vejFelt[round(mouseX/Scale)+2][round(mouseY/Scale)+3] = new Road(round(mouseX/Scale)+2, round(mouseY/Scale)+3, 3, true, true, 0);
  }
}
