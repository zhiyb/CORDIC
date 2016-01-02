#include <stdio.h>
#include <math.h>

int main(int argc, char *argv[])
{
	if (argc != 2)
		return 1;

	int i = atoi(argv[1]);
	double value = 1.f;
	while (i--) {
		double dTheta = atan(value);
		int iTheta = round(dTheta * (double)(1UL << 14));
		printf("16'd%d,\t// %g\n", iTheta, value);
		value /= 2.f;
	}
	return 0;
}
