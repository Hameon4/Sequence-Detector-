`timescale 1ns / 1ps


module seqDec(
    output reg Z,
    input X,
    input Reset,
    input CLK
    );

    parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
    reg [1:0] currentState, nextState;

    //1st block for reset
    //2nd block will discuss where u r right now in transition
    //3rd block is for Second output
    always @ (posedge CLK or negedge Reset)
        if(!Reset)
            currentState <= A;
        else
           currentState <= nextState;

    always @ (currentState or X)
        case(currentState)
            A: if(X) nextState <= B; else nextState = A;
            B: if(X) nextState <= B; else nextState = C;
            C: if(X) nextState <= B; else nextState = D;
            D: if(X) nextState <= B; else nextState = A;
            endcase


      always @(currentState or X)
        case(currentState)
           A : Z <= 0;
           B : Z <= 0;
           C : Z <= 0;
           D : if(X) Z <= 1; else Z <= 0;

            endcase
endmodule
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps


module seqDec_tb();

    wire Z;
    reg X, Reset, CLK;

    seqDec uut(
        .Z(Z),
        .X(X),
        .Reset(Reset),
        .CLK(CLK)
        );

    initial begin
    CLK = 0;

    forever #5 CLK = ~CLK;
    end
    initial begin


    #0   X = 0; Reset = 1;
    #10  X = 1; Reset = 0;
    #10  X = 0; Reset = 0;
    #10  X = 1; Reset = 0;
    #10  X = 1; Reset = 0;
    #10  X = 0; Reset = 0;
    $stop;
    end
endmodule
