package exercise1;

public class Rectangle implements GetArea, Distance {

    private Point A, B, C, D;

    public Rectangle(Point A, Point C) {
        this.A = A;
        this.B = new Point(C.getX(), A.getY());
        this.C = C;
        this.D = new Point(A.getX(), C.getY());
    }

    public Rectangle(Point A, double height, double width) {
        this.A = A;
        this.B = new Point(A.getX() + width, A.getY());
        this.C = new Point(A.getX() + width, A.getY() + height);
        this.D = new Point(A.getX(), A.getY() + height);
   }

    public double getArea() {
        double sizeAB = A.distance(B);
        double sizeBC = B.distance(C);
        return sizeAB * sizeBC;
    }

    public double distance(Point P) {
        double []tempValues = new double[4];
        double tempMin = Double.POSITIVE_INFINITY;

        Line AB = new Line(A, B);
        Line BC = new Line(B, C);
        Line DC = new Line(D, C);
        Line AD = new Line(A, D);

        tempValues[0] = AB.distance(P);
        tempValues[1] = BC.distance(P);
        tempValues[2] = DC.distance(P);
        tempValues[3] = AD.distance(P);

        for (double x : tempValues) {
            if (x < tempMin)
                tempMin = x;
        }
        return tempMin;
    }
}
