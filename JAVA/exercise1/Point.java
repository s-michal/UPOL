package exercise1;

public class Point implements Distance {

    private double x, y;

    public Point(double x, double y) {
        this.x = x;
        this.y = y;
    }

    public double getX() {
        return this.x;
    }

    public double getY() {
        return this.y;
    }

    public double distance (Point P) {
        return Math.sqrt(Math.pow((P.x - x), 2) + Math.pow((P.y - y), 2));
    }

    public String ToString(){
        //System.out.format("(%f, %f)", x, y);
        String temp = "(" + x + " , " + y + ")" + " ";
        return temp;
    }

}
