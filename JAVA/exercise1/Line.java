package exercise1;

public class Line implements Distance {

    private Point A, B;

    Line(Point A, Point B) {
        this.A = A;
        this.B = B;
    }

    public double getLength() {
        return A.distance(B);
    }

    public double distance(Point P) {
        //výpočet směrového vektoru úsěčky AB
       Point u = new Point(B.getX() - A.getX(), B.getY() - A.getY());

       //vyjádření parametru s z parametrické rovnice přímky q,
        // která prochází bodem P a je kolmá k přímce p,
        // která leží na bodech A, B
       double s = (u.getX() * (P.getY() - A.getY()) -
               u.getY() * (P.getX() - A.getX())) /
               (Math.pow(u.getX(), 2) + Math.pow(u.getY(), 2));

       //vyjádření parametru t z parametrické rovnice
        // přímky p pomomcí průsečíku p, q
       double t = (u.getX() * (P.getX() - A.getX())
               + u.getY() * (P.getY() - A.getY())) /
               (Math.pow(u.getX(), 2) + Math.pow(u.getY(), 2));

       if (t >= 0 && t <= 1) // bod leží mezi
           return Math.abs(s * getLength()); //parametr s může být i záporné číslo
       else if (t < 0) //bod je nejblíže bodu A úsečky
           return P.distance(A);
       else //bod je nejblíže bodu B úsečky
           return P.distance(B);
    }
}
