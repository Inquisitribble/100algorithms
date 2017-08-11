import std.stdio;
import std.conv;
import std.typecons;
import std.random;
import std.string;
import std.format;

enum int NUM_UNIQUE_DIMENSIONS = 7;
//enum int NUM_DIMENSIONS = NUM_UNIQUE_DIMENSIONS*2;
void matrix_chain_multiplication(ref int[NUM_UNIQUE_DIMENSIONS][NUM_UNIQUE_DIMENSIONS] m, ref int[NUM_UNIQUE_DIMENSIONS][NUM_UNIQUE_DIMENSIONS] s, int [NUM_UNIQUE_DIMENSIONS] dims) {
	int n = NUM_UNIQUE_DIMENSIONS;
	//initializing diagonal
	
	for(int diag = 0; diag < dims.length; diag++) {
		m[diag][diag] = 0;
	}
	
	//indexing variable for computing costs, represents end of subsequence
	//int j, cost;
	
	for(int sublen = 2; sublen < NUM_UNIQUE_DIMENSIONS; sublen++) {
		for(int i = 1; i < NUM_UNIQUE_DIMENSIONS-sublen+1; i++) {
			int j = i+sublen-1;
			m[i][j] = int.max;
			for(int k = i; k < j; k++) {
				int cost = m[i][k] + m[k+1][j] + dims[i-1]*dims[k]*dims[j];
				if(cost < m[i][j]) {
					m[i][j] = cost;
					s[i][j] = k;
				}
			}
		}
	}
}

string mcm_order(int[NUM_UNIQUE_DIMENSIONS][NUM_UNIQUE_DIMENSIONS] s, int i, int j) {
	if(i == j) {
		return format("A_%d", i);
	}
	return format("(%s %s)", mcm_order(s, i, s[i][j]), mcm_order(s, s[i][j]+1, j));
}

int main(string[] args) {
	
	//array that holds dimensions of all matrices, initialized to random values
	int[NUM_UNIQUE_DIMENSIONS] dims;
	
	for(int dim = 0; dim < dims.length; dim++) {
		dims[dim] = uniform(1,10);
	}
	
	//tables for computed costs, optimal parenthesizations
	int[NUM_UNIQUE_DIMENSIONS][NUM_UNIQUE_DIMENSIONS] m;
	int[NUM_UNIQUE_DIMENSIONS][NUM_UNIQUE_DIMENSIONS] s;
	
	matrix_chain_multiplication(m, s, dims);
	int i = 1;
	int j = NUM_UNIQUE_DIMENSIONS-1;
	writefln("Optimal parenthesization is: %s", mcm_order(s, i, j));
	writefln("Optimal cost is: %d", m[1][NUM_UNIQUE_DIMENSIONS-1]);
	for(int dim_index=0; dim_index+1 < NUM_UNIQUE_DIMENSIONS; dim_index++) {
		writefln("Dimensions are: %d x %d", dims[dim_index], dims[dim_index+1]);
	}
	return 0;
}
