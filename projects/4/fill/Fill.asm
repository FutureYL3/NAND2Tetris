// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

// pseudocode
// while (true) {
//   key = RAM[KBD]
//   if (key != 0) {
//     for (i = 0; i < 8192; i++) {
//       addr = SCREEN + i
//       RAM[addr] = -1
//     } 
//   } else {
//     for (i = 0; i < 8192; i++) {
//       addr = SCREEN + i
//       RAM[addr] = 0
//     } 
//   }
// }

  @8192
  D = A
  @num
  M = D // num = 8192

(MAIN_LOOP)
  @KBD
  D = M // D = RAM[KBD]

  @NOT_PRESSED
  D;JEQ

  @PRESSED
  0;JMP

  (NOT_PRESSED)
    @i
    M = 0 // i = 0
    
    (INNER_LOOP1)
      @num
      D = M
      @i
      D = M - D // D = i - num

      @FINISH1
      D;JGE // if i - num >= 0, then break

      @i
      D = M
      @SCREEN
      A = A + D // A = SCREEN + i

      M = 0 // RAM[SCREEN + i] = 0

      @i
      M = M + 1 // i++

      @INNER_LOOP1
      0;JMP
      
    (FINISH1)
      @MAIN_LOOP
      0;JMP

  (PRESSED)
    @i
    M = 0 // i = 0
    
    (INNER_LOOP2)
      @num
      D = M
      @i
      D = M - D // D = i - num

      @FINISH2
      D;JGE // if i - num >= 0, then break

      @i
      D = M
      @SCREEN
      A = A + D // A = SCREEN + i

      M = -1 // RAM[SCREEN + i] = -1

      @i
      M = M + 1 // i++

      @INNER_LOOP2
      0;JMP
      
    (FINISH2)
      @MAIN_LOOP
      0;JMP





  
