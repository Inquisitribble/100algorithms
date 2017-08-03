import std.stdio;
import std.conv;
//Unfortunately since I suck at this it needs to be a jagged array
int[][3] hanoi_rods;

void hanoi_solver(int height, int left, int middle, int right) {
	if(height > 0) {
		hanoi_solver(height-1, left, middle, right);
		hanoi_rods[right][height-1] = hanoi_rods[left][height-1];
		hanoi_solver(height-1, middle, right, left);
	}
}

int main(string[] args) {
	if(args.length != 2) {
		writeln(args.length);
		writeln("Usage: hanoi #, where # is some integer.");
		return 1;
	}
	
	try {
		const int num_discs = to!int((args[1]));
		
		for(int i = 0; i < 3; i++) {
			hanoi_rods[i] = new int[num_discs];
		}
		
		for(int i = 0; i < num_discs; i++) {
			hanoi_rods[0][num_discs-i-1] = num_discs-i;
		}
		
		hanoi_solver(num_discs, 0, 1, 2);
		//validating that the solution is correct
		writeln("The disks on the rightmost rod are: ");
		for(int i = 0; i < num_discs; i++) {
			writeln(hanoi_rods[2][i]);
		}
		
		return 0;
	} catch (std.conv.ConvOverflowException e) {
		writeln("The supplied command line argument was too large to fit inside of an integer.");
		return 1;
	} catch (std.conv.ConvException e) {
		writeln("The supplied command line argument was not an integer.");
		return 1;
	} 
	
	
}

