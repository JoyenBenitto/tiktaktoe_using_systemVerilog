module tiktaktoe(player,position,reset,out,clk,winner,hex);

input logic player;    // 0- player 1
							 // 1- player 2
input logic reset,clk;
input logic [3:0]position;   //the block picker from 0 - 9 
output logic winner;
output logic [8:0]out;
output logic [7:0][11:0]hex;


always_latch
begin



//     PLAYER 1 INPUTS

	
	begin
	if(player == 1'b0 && reset == 1'b0)          
		begin
			if(position == 4'b0000)//0 block
				out[0]<=1;
			if(position == 4'b0001)//1 block
				out[1]<=1;
			if(position == 4'b0010)//2 block
				out[2]<=1;
			if(position == 4'b0011)//3 block
				out[3]<=1;
			if(position == 4'b0100)//4 block
				out[4]<=1;
			if(position == 4'b0101)//5 block
				out[5]<=1;
			if(position == 4'b0110)//6 block
				out[6]<=1;
			if(position == 4'b0111)//7 block
				out[7]<=1;
			if(position == 4'b1000)//8 block
				out[8]<=1;
		end
			
//     PLAYER 2 INPUTS

	if(player == 1'b1 && reset == 1'b0)
		begin
		if(position == 4'b0000)//0 block
			out[0]<=0;
		if(position == 4'b0001)//1 block
			out[1]<=0;
		if(position == 4'b0010)//2 block
			out[2]<=0;
		if(position == 4'b0011)//3 block
			out[3]<=0;
		if(position == 4'b0100)//4 block
			out[4]<=0;
		if(position == 4'b0101)//5 block
			out[5]<=0;
		if(position == 4'b0110)//6 block
			out[6]<=0;
		if(position == 4'b0111)//7 block
			out[7]<=0;
		if(position == 4'b1000)//8 block
			out[8]<=0;
		
		end
	
	else
	begin
		out<=1'bx;
	end
end
end


//all the always block run simultaneoulsly this always bloc checks for the winner

always_ff@(posedge clk,posedge reset) 
begin
	if(reset)
	begin
		winner<= 1'bx;
	end
	
	else
	begin
		if(out[0]==out[4]==out[8]== 1'b0||
		out[2]==out[4]==out[6]==1'b0||
		out[2]==out[5]==out[8]==1'b0||
		out[6]==out[3]==out[0]==1'b0||
		out[7]==out[4]==out[1]==1'b0||
		out[6]==out[7]==out[8]==1'b0||
		out[3]==out[4]==out[5]==1'b0||
		out[0]==out[1]==out[2]==1'b0)
	
		winner<=1'b0;
	
	
	
		if(out[0]==out[4]==out[8]==1'b1||
		out[2]==out[4]==out[6]==1'b1||
		out[2]==out[5]==out[8]==1'b1||
		out[6]==out[3]==out[0]==1'b1||
		out[7]==out[4]==out[1]==1'b1||
		out[6]==out[7]==out[8]==1'b1||
		out[3]==out[4]==out[5]==1'b1||
		out[0]==out[1]==out[2]==1'b1)
		winner<=1'b1;
	end
end

//building a decoder that will run some 12 segment display showing who is the winner
always_comb
begin
	if(reset == 1'b0)
	begin
		hex[7][11:0]=12'bxxxxxxxxxxxx;
		hex[6][11:0]=12'bxxxxxxxxxxxx;
		hex[5][11:0]=12'bxxxxxxxxxxxx;
		hex[4][11:0]=12'bxxxxxxxxxxxx;
		hex[3][11:0]=12'bxxxxxxxxxxxx;
		hex[2][11:0]=12'bxxxxxxxxxxxx;
		hex[1][11:0]=12'bxxxxxxxxxxxx;
		hex[0][11:0]=12'bxxxxxxxxxxxx;
	end
	else
	begin
		hex[0][11:0] = 12'b10010011100;   //w
		hex[1][11:0] = 12'b11100111111;	 //i
		hex[2][11:0] = 12'b10010010110;	 //n
		hex[3][11:0] = 12'b10010010110;   //n
		hex[4][11:0] = 12'b00100001111;   //e
		hex[5][11:0] = 12'b00110011111;   //r
		hex[6][11:0] = 12'b11111101111;   //-
		if(winner == 1'b0)					 //1 or 2
		begin
			hex[7][11:0] = 12'b11110011111;
		end
		else
		begin
			hex[7][11:0] = 12'b00100101111;
		end
	end
end
endmodule
