import std.stdio;
import std.conv;
import std.format;
import std.algorithm.mutation;

template Permutate(T)
{
	void print_array(ref T[] array) {
		try {
			write("The contents of the sequence are: [ ");
			for(int i = 0; i < array.length-1; i++) {
				writef("%s, ", to!string(array[i]));
			}
			writefln("%s ]", to!string(array[array.length-1]));
		} catch (std.conv.ConvException e) {
			writeln("The contents of the array could not be displayed.");
		}
	}
	void next_permutation(ref T[] sequence) {
		int swap_holder;
		
		for(int i = to!int(sequence.length)-1; i > 1; i--) {
			if(sequence[i-1] < sequence[i]) {
				swap(sequence[i], sequence[i-1]);
				return;
			}
		}
		
		reverse(sequence);
	}
	
	void print_all_permutations(T[] sequence) {
		print_array(sequence);
		for(int i = 1; i < sequence.length; i++) {
			next_permutation(sequence);
			print_array(sequence);
		}
	}
}

void main() {
	int[] digits = [3, 2, 1];
	Permutate!(int).print_all_permutations(digits);
	
	char[] chars = ['F','A','D','E'];
	Permutate!(char).print_all_permutations(chars);
	
}
