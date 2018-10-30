using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace obdelnik
{
    class Kvadr
    {
        private double a, b, c;

        public Kvadr(int a = 1, int b = 1, int c = 1)
        {
            this.a = a;
            this.b = b;
            this.c = c;
        }

        public double Objem()
        {
            return a * b * c;
        }

        public double Povrch()
        {
            return (2 * (a * b + a * c + b * c));
        }
    }
}
