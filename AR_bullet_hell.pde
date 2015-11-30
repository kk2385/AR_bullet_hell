int SCREEN_WIDTH = 500;
int SCREEN_HEIGHT = 500;
ArrayList<Bullet> bullets;
Player player;

void setup() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  player = new Player();
  bullets = new ArrayList<Bullet>();
}

void draw() {
  background(0);
  player.moveAndDraw();
  moveBullets();
  //System.out.println(bullets.size());
}

void moveBullets() {
  for (int i = 0; i < bullets.size(); i++) {
    bullets.get(i).moveAndDraw();
  }
}

void mouseClicked() {
  bullets.add(new CircularBullet(mouseX, mouseY));
}
