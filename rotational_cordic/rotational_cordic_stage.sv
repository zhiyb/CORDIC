/////////////////////////////////////////////////////////////////////
// Design unit: rotational_cordic_stage
//            :
// File name  : rotational_cordic_stage.sv
//            :
// Author     : yz39g13@ecs.soton.ac.uk
/////////////////////////////////////////////////////////////////////

// Scale (2^14 = 1), integer

module rotational_cordic_stage #(parameter rot, i, n) (
  output logic signed [n:0] xprime, yprime,
  output logic signed [15:0] theta_out,
  input logic signed [n:0] x, y,
  input logic signed [15:0] theta
);

logic sigma;
assign sigma = theta[15] === 1;

assign theta_out = sigma ? theta + rot : theta - rot;

assign xprime = sigma ? x + (y >>> i) : x - (y >>> i);
assign yprime = sigma ? y - (x >>> i) : y + (x >>> i);

endmodule
