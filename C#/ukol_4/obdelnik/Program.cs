using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace obdelnik
{
    class Program
    {
        static void Main(string[] args)
        {
            Kvadr k1 = new Kvadr();
            Kvadr k2 = new Kvadr(4);
            Kvadr k3 = new Kvadr(4, 5);
            Kvadr k4 = new Kvadr(4, 5, 6);

            Console.WriteLine("Kvádr byl zadán: Kvadr k1 = new Kvadr(); Objem: {0} Povrch {1}", 
                k1.Objem().ToString(), k1.Povrch().ToString());
            Console.WriteLine("Kvádr byl zadán: Kvadr k2 = new Kvadr(4); Objem: {0} Povrch {1}", 
                k2.Objem().ToString(), k2.Povrch().ToString());
            Console.WriteLine("Kvádr byl zadán: Kvadr k3 = new Kvadr(4, 5); Objem: {0} Povrch {1}", 
                k3.Objem().ToString(), k3.Povrch().ToString());
            Console.WriteLine("Kvádr byl zadán: Kvadr k4 = new Kvadr(4, 5, 6); Objem: {0} Povrch {1}", 
                k4.Objem().ToString(), k4.Povrch().ToString());
        }
    }
}
