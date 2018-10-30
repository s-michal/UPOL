using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace nezamestnanost
{
    public enum Mesice {leden, unor, brezen, duben, kveten, cerven, cervenec, srpen, zari, rijen, listopad, prosinec};

    class Dvojice
    {
        public Mesice mesic;
        public double udaj;

        public Dvojice(Mesice mesic, double udaj)
        {
            this.mesic = mesic;
            this.udaj = udaj;
        }
    }
}
