using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace nezamestnanost
{
    class Nezamestnanost
    {

        private List<Dvojice> seznam = new List<Dvojice>();
        
        public List<Dvojice> Seznam() {
            return this.seznam;
        }

        public double PrumernaNeza()
        {
            double temp = 0;
            foreach (Dvojice n in seznam)
            {
                temp += n.udaj;
            }

            return temp / seznam.Count();
        }

        public Dvojice MinNeza()
        {
            Dvojice min = seznam[0];

            foreach (Dvojice n in seznam)
            {
                if (n.udaj < min.udaj)
                    min = n;
            }

            return min;
        }

        public Dvojice MaxNeza()
        {
            Dvojice max = seznam[0];

            foreach (Dvojice n in seznam)
            {
                if (n.udaj > max.udaj)
                    max = n;
            }

            return max;
        }
    }
}
