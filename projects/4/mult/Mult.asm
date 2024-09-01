// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
// The algorithm is based on repetitive addition.

// pseudocode
// sum = 0
// if (RAM[0] == 0) {
//   // do nothing
// }
// if (RAM[0] > 0) {
//   for (i = RAM[0]; i > 0; i--) {
//     sum = sum + RAM[1]
//   }
// } else if (RAM[1] < 0) {
//   for (i = RAM[0]; i < 0; i++) {
//     sum = sum - RAM[1] 
//   }   
// } else {
//   for (i = RAM[1]; i > 0; i--) {
//     sum = sum + RAM[0] 
//   } 
// }

  @sum
  M = 0

  @R0
  D = M

  @ZERO
  D;JEQ // special case

  @POSITIVE
  D;JGT // First if branch

  @R1
  D = M

  @BOTH_NEGATIVE
  D;JLT // Second if branch

  @ONLY_R0_NEGATIVE
  0;JMP // Third if branch

(ZERO)
  @FINAL_ZERO
  0;JMP


(POSITIVE)
  @R0
  D = M
  @i
  M = D // i = RAM[0]
  
  (LOOP_POS)
    @i
    D = M
    @FINAL_POS
    D;JLE // i <= 0, then loop ends

    @R1
    D = M
    @sum
    M = M + D // sum = sum + RAM[1]

    @i
    M = M - 1 // i--

    @LOOP_POS
    0;JMP // goto LOOP

  @FINAL_POS
  0;JMP

(BOTH_NEGATIVE)
  @R0
  D = M
  @i
  M = D // i = RAM[0]
  
  (LOOP_NEG)
    @i
    D = M
    @FINAL_NEG
    D;JGE // i >= 0, then loop ends

    @R1
    D = M
    @sum
    M = M - D // sum = sum - RAM[1]

    @i
    M = M + 1 // i++

    @LOOP_NEG
    0;JMP // goto LOOP

  @FINAL_NEG
  0;JMP

(ONLY_R0_NEGATIVE)
  @R1
  D = M
  @i
  M = D // i = RAM[1]
  
  (LOOP_ONLY)
    @i
    D = M
    @FINAL_ONLY
    D;JLE // i <= 0, then loop ends

    @R0
    D = M
    @sum
    M = M + D // sum = sum + RAM[0]

    @i
    M = M - 1 // i--

    @LOOP_ONLY
    0;JMP // goto LOOP

  @FINAL_ONLY
  0;JMP

(FINAL_NEG)
(FINAL_POS)
(FINAL_ONLY)
(FINAL_ZERO)
  @sum
  D = M
  @R2
  M = D // RAM[2] = sum

(END)
  @END
  0;JMP