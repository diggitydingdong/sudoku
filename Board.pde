public class Board {

  public int[][] board;
  public int[][] state;
  public int N;
  public int s = 1000000;
  public int sel = 1;
  public Rectangle bounds = new Rectangle(boardX, boardY, BOARD_SIZE, BOARD_SIZE);
  int o = 0;

  public Board(int n) {
    N = n;
    board = new int[n*n][n*n];
    state = new int[n*n][n*n];
    
    generate();
  }

  public Board(int n, int[][] b) {
    N = n;
    board = b;
    state = new int[n*n][n*n];
    
    for (int y = 0; y < N*N; y++) {
      for (int x = 0; x < N*N; x++) {
        if(board[y][x] != 0) state[y][x] = 1;
      }
    }
    
  }
  
  void generate() {
    clear();
    solve(true, false, false);
    
    ArrayList<Integer> visited = new ArrayList<Integer>();
      
    for(int i = 0; i < 30; i++) {
      //System.out.println(i);
      o = 0;
      ArrayList<Integer> c = getOccupied(visited);
      if(c.size() == 0) break;
      int t = c.get(r.nextInt(c.size()));
           
      int a = get(t);
      set(t, 0);
      solve(false, true, false);
      if(o != 1) {
        visited.add(t);
        set(t, a);
        state[t/(N*N)][t%(N*N)] = 1;
        i--;
      }
      else {
        visited.clear();
      }
    }
  }

  boolean solve(boolean rand, boolean count, boolean solve) {    
    int empty = getEmpty();
    if (empty == -1)
    {
      o++;
      if(!count) return true;
    }

    int[] digits = new int[N*N];
    for(int i = 0; i < digits.length; i++) digits[i] = i+1;
    
    if (rand) digits = shuffle(digits);

    for (int i = 0; i < digits.length; i++) {
      if (validDigit(digits[i], empty)) {
        set(empty, digits[i]);
        state[empty/(N*N)][empty%(N*N)] = (solve) ? 2 : 1;
        

        if (solve(rand, count, solve)) return true;
        else {
          set(empty, 0);
          state[empty/(N*N)][empty%(N*N)] = 0;
        }
          
      }
      
    }

    return false;
  }

  boolean validDigit(int d, int x) {
    if (d < 1 || d > N*N) return false;
    int row = x/(N*N), col = x%(N*N);

    // row
    for (int c = 0; c < (N*N); c++) if (board[row][c] == d) return false;

    // col
    for (int r = 0; r < (N*N); r++) if (board[r][col] == d) return false;

    // square 
    int R = row / N, C = col / N;
    for (int i = 0; i < (N*N); i++) if (board[R*N+i/N][C*N+i%N] == d) return false;

    return true;
  }
  
  void draw() {
   fill(255);
    stroke(167);
    for (int y = 0; y < N*N; y++) {
      for (int x = 0; x < N*N; x++) {
        rect(boardX + x*CELL_SIZE, boardY + y*CELL_SIZE, CELL_SIZE, CELL_SIZE);
      }
    }

    noFill();
    stroke(0);
    for (int y = 0; y < N; y++) {
      for (int x = 0; x < N; x++) {
        rect(boardX + x*CELL_SIZE*N, boardY + y*CELL_SIZE*N, CELL_SIZE*N, CELL_SIZE*N);
      }
    }

    fill(0);
    textSize(CELL_SIZE*0.7);
    for (int y = 0; y < N*N; y++) {
      for (int x = 0; x < N*N; x++) {
        if (get(x, y) == 0) continue;
        if (state[y][x] == 2) fill(106);
        else if (state[y][x] == 3) fill(255, 0, 0);
        else fill(0);
        text(get(x, y), boardX + (x+0.5)*CELL_SIZE, boardY + (y+0.4)*CELL_SIZE);
      }
    } 
  }

  ArrayList<Integer> getOccupied(ArrayList<Integer> a) {
    ArrayList<Integer> o = new ArrayList<Integer>();
    for (int y = 0; y < N*N; y++) {
      for (int x = 0; x < N*N; x++) {
        if (board[y][x] != 0 && !a.contains(y*N*N+x)) o.add(y*N*N+x);
      }
    }
    return o;
  }
  
  void onClicked() {
    int x = (mouseX-boardX)/(CELL_SIZE);
    int y = (mouseY-boardY)/(CELL_SIZE);
    if(state[y][x] == 1 || state[y][x] == 2) return;
    board[y][x] = sel;
    state[y][x] = 3;
  }

  //ArrayList<Integer> getEmpty() {
  int getEmpty() {
    //ArrayList<Integer> o = new ArrayList<Integer>();
    for (int y = 0; y < N*N; y++) {
      for (int x = 0; x < N*N; x++) {
        if (board[y][x] == 0) return  y*N*N+x;
        //if (board[y][x] == 0) o.add(y*N*N+x);
      }
    }
    return -1;
    //return o;
  }

  void print() {
    for (int y = 0; y < N*N; y++) {
      for (int x = 0; x < N*N; x++) {
        System.out.print(get(x, y)+" ");
      }
      System.out.println();
    }
  }

  int get(int x, int y) {
    return board[y][x];
  }

  int get(int c) {
    return board[c/(N*N)][c%(N*N)];
  }

  void set(int c, int v) {
    board[c/(N*N)][c%(N*N)] = v;
  }
  
  void clear() {
    for (int y = 0; y < N*N; y++) {
      for (int x = 0; x < N*N; x++) {
        board[y][x] = 0;
        state[y][x] = 0;
      }
    }
  }
}
