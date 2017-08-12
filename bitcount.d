import std.stdio;
import std.conv;
import std.format;

int count_bits(uint bits) {
	int num_bits = 0;
	for(int shift = 0; shift < 32; shift++) {
		num_bits += ((bits >> shift) & 1);
	}
	return num_bits;
}

int main(string[] args) {
	if(args.length != 2) {
		writeln(args.length);
		writeln("Usage: bitcount #, where # is some integer.");
		return 1;
	}
	
	try {
		const uint bits = to!uint((args[1]));
		writefln("The number of bits in %b is %d.", bits, count_bits(bits));
		return 0;
	} catch (std.conv.ConvOverflowException e) {
		writeln("The supplied command line argument was too large to fit inside of an integer.");
		return 1;
	} catch (std.conv.ConvException e) {
		writeln("The supplied command line argument was not an integer.");
		return 1;
	}
}
