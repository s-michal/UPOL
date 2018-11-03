using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dedicnost
{
    class Student : Student_skoly
    {
        protected string obor;

        public Student(string obor, string nazev, string jmeno, string rodneCislo) : base(nazev, jmeno, rodneCislo)
        {
            this.obor = obor;
        }

        new public void Vypis()
        {
            base.Vypis();
            Console.WriteLine("Obor: " + obor);
        }

    }
}
