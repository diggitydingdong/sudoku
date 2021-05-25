import java.awt.Rectangle;

public abstract class Button {
 
  public Rectangle rect;
  public String text;
  
  public Button(int x, int y, int width, int height, String text) {
   rect = new Rectangle(x, y, width, height); 
   this.text = text;
  }
  
  public boolean contains(int x, int y) {
   return rect.contains(x, y); 
  }
  
  void draw() {
      fill(255);
      rect(rect.x, rect.y, rect.width, rect.height);
      
      fill(0);
      textSize(rect.height*0.7);
      text(text, rect.x + 0.5*rect.width, rect.y + 0.4*rect.height); 
  }
  
  abstract void onClicked();
}

public class NumberButton extends Button {
  
  public Board board;
  
  public NumberButton(int x, int y, int width, int height, Board b) {
   super(x, y, width, height, ""); 
   board = b;
  }
  
  void draw() {
    fill(255);
    
    stroke(167);
    for(int i = 0; i < board.N*board.N; i++) {
      rect(rect.x+i*CELL_SIZE, rect.y, CELL_SIZE, CELL_SIZE);
    }
    
    noFill();
    stroke(0);
    rect(rect.x, rect.y, rect.width, rect.height);
    
    textSize(rect.height*0.7);
    for(int i = 0; i < board.N*board.N; i++) {
      if(board.sel-1 == i) fill(255, 0, 0);
      else fill(0);
      text(i+1, rect.x + (i + 0.5)*CELL_SIZE, rect.y + 0.4*rect.height);
    }
  }
  
  public void onClicked() {
    board.sel = (mouseX-rect.x)/(CELL_SIZE)+1;
  }
}

public class GenerateButton extends Button {
  
  public Board board;
  
  public GenerateButton(int x, int y, int width, int height, Board b) {
   super(x, y, width, height, "Generate"); 
   board = b;
  }
  
  public void onClicked() {
    board.generate();
  }
}

public class SolveButton extends Button {
  
  public Board board;
  
  public SolveButton(int x, int y, int width, int height, Board b) {
   super(x, y, width, height, "Solve"); 
   board = b;
  }
  
  public void onClicked() {
    board.solve(false, false, true);
  }
}
