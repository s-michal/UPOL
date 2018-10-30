using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace nezamestnanost
{
    class Program
    {
        static void Main(string[] args)
        {

            Nezamestnanost neza = new Nezamestnanost();
           
            
            for (int i = 0; i < 3; i++)
            {
                Mesice mesic;
                Console.Write("Zadejte mesic: ");
                Mesice.TryParse(Console.ReadLine(), out mesic);
                Console.Write("Zadejte udaj: ");
                double udaj;
                double.TryParse(Console.ReadLine(), out udaj);
                Dvojice dvoj = new Dvojice(mesic, udaj);
                neza.Seznam().Add(dvoj);
            }

            Console.WriteLine("\n");
            Console.Write("Největší nezaměstnanost byla v měsící: ");
            Console.Write(neza.MaxNeza().mesic);
            Console.Write(" a to ");
            Console.Write(neza.MaxNeza().udaj);
            Console.Write(" %");


            Console.WriteLine("\n");
            Console.Write("Nejmenší nezaměstnanost byla v měsící: ");
            Console.Write(neza.MinNeza().mesic);
            Console.Write(" a to ");
            Console.Write(neza.MinNeza().udaj);
            Console.Write(" %");

            Console.WriteLine("\n");
            Console.Write("Průměrná nezaměstnanost: ");
            Console.Write(neza.PrumernaNeza());
            Console.WriteLine("\n");

        }
    }
}
