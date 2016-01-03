/////////////////////////////////////////////////////////////////////
// Design unit: rotational_cordic
//            :
// File name  : rotational_cordic.sv
//            :
// Author     : yz39g13@ecs.soton.ac.uk
/////////////////////////////////////////////////////////////////////

// Scale (2^14 = 1), integer

// Do not change this next line
module rotational_cordic (
  output logic data_out_rot,
  output logic [15:0] xprime,
  output logic [15:0] yprime,
  input logic [15:0] x,
  input logic [15:0] y,
  input logic [15:0] theta,
  input logic clk, reset, start
);

parameter logic [15:0] rot_lut[16] = '{
	16'd12868,	// 1
	16'd7596,	// 0.5
	16'd4014,	// 0.25
	16'd2037,	// 0.125
	16'd1023,	// 0.0625
	16'd512,	// 0.03125
	16'd256,	// 0.015625
	16'd128,	// 0.0078125
	16'd64,		// 0.00390625
	16'd32,		// 0.00195313
	16'd16,		// 0.000976563
	16'd8,		// 0.000488281
	16'd4,		// 0.000244141
	16'd2,		// 0.00012207
	16'd1,		// 6.10352e-005
	16'd0		// 3.05176e-005
};

parameter k = 0.607252935;
parameter k_scaled = int'(k * int'(1 << 14));
parameter stages = 16;
parameter n = 16;

// Input to calculation stages & registers
logic signed [n:0] r_x[stages], r_y[stages];
logic signed [15:0] r_theta[stages];
logic r_data_out[stages];

assign r_x[0] = {x[15], x};
assign r_y[0] = {y[15], y};
assign r_theta[0] = theta;
assign r_data_out[0] = start;

// Output from calculation stages
logic signed [n:0] x_out[stages], y_out[stages];
logic signed [15:0] theta_out[stages];

assign data_out_rot = r_data_out[stages - 1];

// Scale output by K
logic signed [n:0] x_prime, y_prime;

// No rounding
assign x_prime = x_out[stages - 1] * k_scaled /  (1 << 14);
assign y_prime = y_out[stages - 1] * k_scaled /  (1 << 14);

/*
// Rounding
logic signed [n + 1:0] x_prime_r, y_prime_r;
assign x_prime_r = x_out[stages - 1] * k_scaled /  (1 << 13);
assign y_prime_r = y_out[stages - 1] * k_scaled /  (1 << 13);
assign x_prime = x_prime_r[n + 1:1] + x_prime_r[0];
assign y_prime = y_prime_r[n + 1:1] + y_prime_r[0];
*/

/*
// Real number computation by ModelSim?
assign x_prime = x_out[stages - 1] * k;
assign y_prime = y_out[stages - 1] * k;
*/

// Output, truncated
assign xprime = {x_prime[n], x_prime[n - 2:0]};
assign yprime = {y_prime[n], y_prime[n - 2:0]};

genvar i;

generate
for (i = 0; i < stages - 1; i++)
begin: registers
	always_ff @(posedge clk, posedge reset)
		if (reset)
		begin
			r_x[i + 1] <= 0;
			r_y[i + 1] <= 0;
			r_theta[i + 1] <= 0;
			r_data_out[i + 1] <= 0;
		end
		else
		begin
			r_x[i + 1] <= x_out[i];
			r_y[i + 1] <= y_out[i];
			r_theta[i + 1] <= theta_out[i];
			r_data_out[i + 1] <= r_data_out[i];
		end
end

for (i = 0; i < stages; i++)
begin: calcStages
	rotational_cordic_stage #(.rot(rot_lut[i]), .i(i), .n(n)) s0 (
		.x(r_x[i]), .y(r_y[i]), .theta(r_theta[i]),
		.xprime(x_out[i]), .yprime(y_out[i]), .theta_out(theta_out[i]), .*
	);
end
endgenerate

endmodule
