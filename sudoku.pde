import java.util.Random;

final int CELL_SIZE = 50;
final int N = 3;
final int BOARD_SIZE = CELL_SIZE*N*N;
final int PADDING = 25;
final int BUTT_HEIGHT = CELL_SIZE;
final int BUTT_WIDTH = CELL_SIZE*(N+1);
int boardX, boardY;

Random r = new Random();
Board board;
Button[] buttons;


void setup() {
  size(1000, 1000);
  surface.setSize(PADDING*2 + BOARD_SIZE, PADDING*5 + BOARD_SIZE + BUTT_HEIGHT + CELL_SIZE);
  
  textSize(CELL_SIZE);
  textAlign(CENTER, CENTER);
  PFont ver = createFont("verdana.ttf", 1);
  textFont(ver);
  
  boardX = (width - BOARD_SIZE)/2;
  boardY = (height - BOARD_SIZE)/2-CELL_SIZE;
  
  board = new Board(N);
  
  buttons = new Button[3];
  buttons[0] = new GenerateButton(boardX, boardY+BOARD_SIZE+PADDING*2+CELL_SIZE, BUTT_WIDTH, BUTT_HEIGHT, board);
  buttons[1] = new SolveButton(boardX+BOARD_SIZE-BUTT_WIDTH, boardY+BOARD_SIZE+PADDING*2+CELL_SIZE, BUTT_WIDTH, BUTT_HEIGHT, board);
  buttons[2] = new NumberButton(boardX, boardY+BOARD_SIZE+PADDING, BOARD_SIZE, CELL_SIZE, board);
}

void draw() {
    board.draw();
    
    // buttons
    stroke(167);
    for(int i = 0; i < buttons.length; i++) {
      buttons[i].draw();
    }
  }
  
void mousePressed() {
  for(int i = 0; i < buttons.length; i++) {
   if(buttons[i].contains(mouseX, mouseY)) buttons[i].onClicked();
  }
  
  if(board.bounds.contains(mouseX, mouseY)) board.onClicked();
}

int[] shuffle(int[] array) {
  for(int i = 0; i < array.length; i++) {
    int ind = r.nextInt(array.length);
    int s = array[i];
    array[i] = array[ind];
    array[ind] = s;
  }
  
  return array;
}
