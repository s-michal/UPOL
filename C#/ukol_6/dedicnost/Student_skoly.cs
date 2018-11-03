using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dedicnost
{
    class Student_skoly : Osoba
    {

        protected string nazev;

        public Student_skoly(string nazev, string jmeno, string rodneCislo) : base(jmeno, rodneCislo)
        {          
            this.nazev = nazev;
        }

        public void nastav_skolu(string nsk)
        {
            this.nazev = nsk;
        }

        new public void Vypis()
        {
            base.Vypis();
            Console.WriteLine("Nazev skoly: " + nazev);
        }
    }
}
