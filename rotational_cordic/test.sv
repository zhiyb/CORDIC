module test;

// Input signals
logic [15:0] x, y, theta;
logic clk, reset, start;
// Output signals
logic [15:0] xprime, yprime;
logic data_out_rot;

parameter count = 7;
parameter [15:0] p_test[count][3] = '{
	// x,	y,	theta
	'{16384, 16384, 8579},	// (1, 1, 30)
	'{0, 16384, 5719},	// (0, 1, 20)
	'{14746, 16384, -8579},	// (0.9, 1, -30)
	'{16384, -8192, 5719},	// (1, -0.5, 20)
	'{16384, 0, -14298},	// (1, 0, -50)
	'{6226, 6554, 13011},	// (0.38, 0.4, 45.5)
	'{4915, 8192, -18015}	// (0.3, 0.5, -63)
};

int i;

initial
begin
	clk = 'b0;
	forever #1ns clk = ~clk;
end

initial
begin
	x = 'b0;
	y = 'b0;
	theta = 'b0;
	start = 'b0;
	reset = 'b1;
	#1ns;
	reset = 'b0;
	#1ns;
	for (i = 0; i < count; i++)
	begin
		if (i == 2)
		begin
			start = 'b0;
			#4ns;
		end
		else if (i == 4)
		begin
			start = 'b0;
			#2ns;
		end
		x = p_test[i][0];
		y = p_test[i][1];
		theta = p_test[i][2];
		start = 'b1;
		#2ns;
	end
	start = 'b0;
end

rotational_cordic c0 (.*);

endmodule
