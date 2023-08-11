PImage userCar;
PImage enemyCar;
int x;
float y;
boolean moveRight, moveLeft, moveUp, moveDown;
boolean gameOver;
boolean winGame = false;
int startPoint = 0;
int userSpeed;
int lineSpeed;
float lineY;
int policeSpacing;
int enemyCount = 40;
int time = second();
int[] enemiesX = new int[enemyCount];
int[] enemiesY = new int[enemyCount];
int enemySpeed = 8;
int m = millis();

void setup() {
  size(600, 600);
  userCar = loadImage("car.png");
  enemyCar = loadImage("unnamed.png");
  enemyCar.resize(50, 60);
  x = width/2;
  y = 5*height/6;
  gameOver = false;
  userSpeed = 8;
  lineSpeed = 5;
  lineY = -80;
  policeSpacing = 180;
  for (int i = 0; i < enemyCount; i += 1) {
    enemiesX[i] = (int) random(90, 455);
    enemiesY[i] = i * (policeSpacing) - ((policeSpacing * enemyCount) + 300);
  }
}

void draw() {
  background(#14902A);
  fill(#626161);
  noStroke();
  rect(90, 0, 420, 600);
  fill(255);
  rect(90, 0, 420, 600);
  fill(255);
  strokeWeight(8);
  rect(95, 0, 5, 600); // Left White Boundary Line
  rect(500, 0, 5, 600); // Right White Boundary Line
  fill(0);
  textSize(20);
  textAlign(RIGHT);
  text("Enemies left: " + conditions(enemyCount), width - 10, 30);
  textAlign(LEFT);

  // YELLOW LINES MOVING!!!
  for (int j = 0; j < 13; j += 1) {
    fill(#E8BC09);
    noStroke();
    rect(300, lineY + 70*j, 8, 50);
    lineY = lineY + 0.2;
    if (lineY + 550 > height) {
      lineY = -25;
      rect(300, lineY, 8, 60);
    }
  }

  // Drawing Enemies
  for (int i = 0; i < enemyCount; i += 1) {
    image(enemyCar, enemiesX[i], enemiesY[i]);
    enemiesY[i] = enemiesY[i] + enemySpeed;
  }

  move();
  
  // Drawing user Car
  userCar.resize(80, 80);
  image(userCar, x - 40, y);
  
  // Conditionals to End or Win Game
  hitPoliceCar(x, y);
  
  if (gameOver == true) {
    fill(#61B1E5);
    rect(0, 0, width, height);
    fill(255);
    textSize(60);
    text("You Lost :(", 175, 300);
  }
  
  if (winGame == true) {
    fill(#61B1E5);
    rect(0, 0, width, height);
    fill(255);
    textSize(60);
    text("You Won!", 175, 300);
  }
}

void move() {
  if (moveUp == true) {
    y -= userSpeed;
    if (y <= 0) {
      y = 0;
    }
  }
  if (moveDown == true) {
    y += userSpeed;
    if (y >= height - 20) {
      y = height - 20;
    }
  }
  if (moveRight == true) {
    x += userSpeed;
    if (x > width - 110) {
      x = width - 110;
    }
  }
  if (moveLeft == true) {
    x -= userSpeed;
    if (x <= 120) {
      x = 120;
    }
  }
}

void keyPressed() {
  if (keyCode == 38) { // Up Arrow
    moveUp = true;
  }
  if (keyCode == 40) { // Down Arrow
    moveDown = true;
  }
  if (keyCode == 37) { // Left Arrow
    moveLeft = true;
  }
  if (keyCode == 39) { // Right Arrow
    moveRight = true;
  }
}

void keyReleased() {
  if (keyCode == UP) {
    moveUp = false;
  }
  if (keyCode == DOWN) {
    moveDown = false;
  }
  if (keyCode == RIGHT) {
    moveRight = false;
  }
  if (keyCode == LEFT) {
    moveLeft = false;
  }
}

void hitPoliceCar(int boundaryX, float boundaryY) {
  for (int i = 0; i < enemyCount; i += 1) {
    if (boundaryX < enemiesX[i] + 55 && boundaryX > enemiesX[i] && boundaryY > enemiesY[i] && boundaryY < enemiesY[i] + 30) {
      gameOver = true;
    } else if (enemiesY[1] > height + 750) {
      winGame = true;
    }
  }
}

int conditions(int enemiesLeft) {
  for (int i = enemiesLeft - 1; i >= 0; i -= 1) {
    if (enemiesY[i] > 600) {
      enemiesLeft -= 1;
    }
  }
  return enemiesLeft;
}
