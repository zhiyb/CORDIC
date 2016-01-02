#include <stdio.h>
#include <math.h>

//#define USE_K

static int roundI(double v)
{
	return round(v * (double)(1UL << 14));
}

int main(int argc, char *argv[])
{
	double pi = acos(0.f) * 2.f;
#ifdef USE_K
	double k = 0.607252935;
#endif
	for (;;) {
		double x, y, deg;
		if (scanf("%lf%lf%lf", &x, &y, &deg) <= 0)
			break;
#ifdef USE_K
		int iX = roundI(x * k);
		int iY = roundI(y * k);
#else
		int iX = roundI(x);
		int iY = roundI(y);
#endif
		double dRad = deg * pi / 180.f;
		int iRad = roundI(dRad);
		printf("'{%d, ", iX);
		printf("%d, ", iY);
		printf("%d},\t", iRad);
		printf("// (%g, %g, %g)\n", x, y, deg);
	}
	return 0;
}
