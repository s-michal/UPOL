using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dedicnost
{

    class Osoba
    {
        protected string jmeno;
        protected string rodneCislo;

        public Osoba(string jmeno, string rodneCislo)
        {
            this.jmeno = jmeno;
            this.rodneCislo = rodneCislo;
        }

        public void zmen_jmeno(string nj)
        {
            this.jmeno = nj;
        }

        public void zmen_rc(string nrc)
        {
            this.rodneCislo = nrc;
        }

        public string Pohl()
        {
            char num = rodneCislo[2];
            if (num - '0' > 3)
                return "Žena";
            else
                return "Muž";
        }

        public void Vypis()
        {
            Console.WriteLine("Jmeno: " + jmeno + ", Rodne cislo: " + rodneCislo + " " + Pohl());
        }

    }
}
